import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/wallet/wallets.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/pkg/bitcoin.dart';
import 'package:sats/pkg/clipboard.dart';
import 'package:sats/pkg/storage.dart';

part 'xpub-import.freezed.dart';

enum XpubImportStep { import, label }

@freezed
class XpubImportState with _$XpubImportState {
  const XpubImportState._();
  const factory XpubImportState({
    @Default(XpubImportStep.import) XpubImportStep currentStep,
    @Default('') String xpub,
    @Default('') String fingerPrint,
    @Default('') String path,
    @Default('') String errXpub,
    @Default(false) bool cameraOpened,
    @Default('') String label,
    @Default(false) bool savingWallet,
    @Default('') String errSavingWallet,
    @Default(false) bool newWalletSaved,
  }) = _SeedImportXpubState;

  double completePercent() => currentStep.index / XpubImportStep.values.length;

  String completePercentLabel() =>
      ((currentStep.index / XpubImportStep.values.length) * 100)
          .toStringAsFixed(0);

  String currentStepLabel() {
    switch (currentStep) {
      case XpubImportStep.import:
        return 'Import XPub';
      case XpubImportStep.label:
        return 'Label Wallet';
    }
  }

  bool canGoBack() => currentStep == XpubImportStep.import;

  bool showOtherDetails() {
    if (xpub.startsWith('[') && xpub.contains(']') && xpub.contains('/'))
      return false;
    return true;
  }
}

class XpubImportCubit extends Cubit<XpubImportState> {
  XpubImportCubit(
    // this._soloWalletAPI,
    this._bitcoin,
    this._logger,
    this._clipboard,
    this._storage,
    this._wallets,
  ) : super(XpubImportState());

  final IClipBoard _clipboard;
  // final ISoloWalletAPI _soloWalletAPI;
  final LoggerCubit _logger;
  final IStorage _storage;
  final IBitcoin _bitcoin;
  final WalletsCubit _wallets;

  void _saveWallet() async {
    // emit(state.copyWith(
    //   savingWallet: true,
    //   errSavingWallet: '',
    // ));

    try {
      final result = await _bitcoin.deriveHardened(
        masterXPriv: state.xpub,
        account: '',
        purpose: '',
      );

      if (result.startsWith('Error')) throw result;

      final obj = jsonDecode(result);

      final fingerPrint = obj['fingerPrint'];
      final path = obj['hardened_path'];
      final childXPriv = obj['xprv'];
      final childXPub = obj['xpub'];

      final newWallet = Wallet(
        label: state.label,
        policy: '',
        descriptor: '',
      );

      _storage.saveItem(StoreKeys.Wallet.name, newWallet);

      _wallets.refresh();

      emit(state.copyWith(
        savingWallet: false,
        newWalletSaved: true,
      ));
    } catch (e, s) {
      _logger.logException(e, 'SeedImportCubit._saveWallet', s);

      emit(state.copyWith(
        errSavingWallet: 'Error Occured.',
        newWalletSaved: true,
      ));
    }
  }

  void toggleCamera() async {
    try {
      emit(state.copyWith(cameraOpened: true, errXpub: ''));

      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', false, ScanMode.QR);

      if (barcodeScanRes == '-1') barcodeScanRes = '';

      emit(state.copyWith(xpub: barcodeScanRes, cameraOpened: false));
    } catch (e, s) {
      emit(state.copyWith(cameraOpened: false, errXpub: 'Error Occured.'));

      _logger.logException(e, 'BtcSendAddressBloc._mapToggleCameraEvent', s);
    }
  }

  void xpubPasteClicked() async {
    try {
      final text = await _clipboard.pasteFromClipBoard();
      emit(state.copyWith(xpub: text, errXpub: ''));
    } catch (e, s) {
      _logger.logException(e, 'BtcSendAddressBloc._mapPasteAddressEvent', s);
    }
  }

  void xpubChanged(String text) {
    emit(state.copyWith(xpub: text, errXpub: ''));
  }

  void fingerPrintChanged(String text) {
    emit(state.copyWith(fingerPrint: text, errXpub: ''));
  }

  void fingerPrintPastedClicked() async {
    try {
      final text = await _clipboard.pasteFromClipBoard();
      emit(state.copyWith(fingerPrint: text, errXpub: ''));
    } catch (e, s) {
      _logger.logException(e, 'BtcSendAddressBloc.fingerPrintPastedClicked', s);
    }
  }

  void pathChanged(String text) {
    emit(state.copyWith(path: text, errXpub: ''));
  }

  void pathPasteClicked() async {
    try {
      final text = await _clipboard.pasteFromClipBoard();
      emit(state.copyWith(path: text, errXpub: ''));
    } catch (e, s) {
      _logger.logException(e, 'BtcSendAddressBloc.pathPasteClicked', s);
    }
  }

  void labelChanged(String text) {
    emit(state.copyWith(label: text, errSavingWallet: ''));
  }

  void nextClicked() {
    switch (state.currentStep) {
      case XpubImportStep.import:
        if (state.xpub == '' || state.xpub.length < 10) {
          emit(state.copyWith(
            errXpub: 'Invalid xPub. Try again.',
          ));
          return;
        }
        if (state.showOtherDetails() && state.fingerPrint.length < 8) {
          emit(state.copyWith(
            errXpub: 'Invalid Fingerprint. Try again.',
          ));
          return;
        }
        if (state.showOtherDetails() && state.path == '') {
          emit(state.copyWith(
            errXpub: 'Invalid Path. Try again.',
          ));
          return;
        }

        emit(state.copyWith(currentStep: XpubImportStep.label));
        break;
      case XpubImportStep.label:
        if (state.label == '' || state.label.length < 5) {
          emit(state.copyWith(errSavingWallet: 'Invalid Label.'));
          return;
        }
        _saveWallet();
        break;
    }
  }

  void backClicked() {
    switch (state.currentStep) {
      case XpubImportStep.import:
        break;
      case XpubImportStep.label:
        emit(state.copyWith(
          currentStep: XpubImportStep.import,
          label: '',
        ));
        break;
    }
  }
}
