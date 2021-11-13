import 'package:bloc/bloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/pkg/clipboard.dart';

part 'xpub-import.freezed.dart';

@freezed
class XpubImportState with _$XpubImportState {
  const factory XpubImportState({
    @Default('') String xpub,
    @Default('') String fingerPrint,
    @Default('') String path,
    @Default('') String errXpub,
    @Default(false) bool cameraOpened,
    @Default(false) bool detailsReady,
  }) = _SeedImportXpubState;
  const XpubImportState._();

  bool showOtherDetails() {
    if (xpub.startsWith('[') && xpub.contains(']') && xpub.contains('/'))
      return false;
    return true;
  }
}

class XpubImportCubit extends Cubit<XpubImportState> {
  XpubImportCubit(
    // this._soloWalletAPI,
    this._logger,
    this._clipboard,
  ) : super(const XpubImportState());

  final IClipBoard _clipboard;
  // final ISoloWalletAPI _soloWalletAPI;
  final LoggerCubit _logger;

  void toggleCamera() async {
    try {
      emit(state.copyWith(cameraOpened: true, errXpub: ''));

      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        false,
        ScanMode.QR,
      );

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

  void checkDetails() {
    if (state.xpub == '' || state.xpub.length < 10) {
      emit(
        state.copyWith(
          errXpub: 'Invalid xPub. Try again.',
        ),
      );
      return;
    }
    if (state.showOtherDetails() && state.fingerPrint.length < 8) {
      emit(
        state.copyWith(
          errXpub: 'Invalid Fingerprint. Try again.',
        ),
      );
      return;
    }
    if (state.showOtherDetails() && state.path == '') {
      emit(
        state.copyWith(
          errXpub: 'Invalid Path. Try again.',
        ),
      );
      return;
    }

    emit(state.copyWith(detailsReady: true));
  }
}
