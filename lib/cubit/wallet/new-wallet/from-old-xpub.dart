import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/chain-select.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/wallet/common/xpub-import.dart';
import 'package:sats/cubit/wallet/new-wallet/from-old-seed.dart';
import 'package:sats/cubit/wallets.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/pkg/bitcoin.dart';
import 'package:sats/pkg/storage.dart';

part 'from-old-xpub.freezed.dart';

enum XpubImportWalletStep { import, label }

@freezed
class XpubImportWalletState with _$XpubImportWalletState {
  const factory XpubImportWalletState({
    @Default(XpubImportWalletStep.import) XpubImportWalletStep currentStep,
    @Default('') String label,
    @Default(false) bool savingWallet,
    @Default('') String errSavingWallet,
    @Default(false) bool newWalletSaved,
  }) = _SeedImportXpubState;
  const XpubImportWalletState._();

  double completePercent() =>
      currentStep.index / XpubImportWalletStep.values.length;

  String completePercentLabel() =>
      ((currentStep.index / XpubImportWalletStep.values.length) * 100)
          .toStringAsFixed(0);

  String currentStepLabel() {
    switch (currentStep) {
      case XpubImportWalletStep.import:
        return 'Import XPub';
      case XpubImportWalletStep.label:
        return 'Label Wallet';
    }
  }

  bool canGoBack() => currentStep == XpubImportWalletStep.import;
}

class XpubImportWalletCubit extends Cubit<XpubImportWalletState> {
  XpubImportWalletCubit(
    // this._soloWalletAPI,
    this._bitcoin,
    this._logger,
    this._storage,
    this._wallets,
    this._blockchainCubit,
    this._importCubit,
  ) : super(const XpubImportWalletState()) {
    _importCubit.stream.listen((istate) {
      if (istate.detailsReady) {
        emit(state.copyWith(currentStep: XpubImportWalletStep.label));
      }
    });
  }

  // final ISoloWalletAPI _soloWalletAPI;
  final LoggerCubit _logger;
  final IStorage _storage;
  final IBitcoinCore _bitcoin;
  final WalletsCubit _wallets;
  final ChainSelectCubit _blockchainCubit;
  final XpubImportCubit _importCubit;
  late StreamSubscription _importSub;

  void _saveWallet() async {
    emit(
      state.copyWith(
        savingWallet: true,
        errSavingWallet: '',
      ),
    );

    try {
      final xpubState = _importCubit.state;
      final fingerprint = xpubState.fingerPrint;
      final path = xpubState.path;
      final xpub = xpubState.xpub;
      String policy = '';
      if (!xpubState.showOtherDetails())
        policy = 'pk($xpub/0/*)';
      else
        policy = 'pk([$fingerprint/$path]$xpub/0/*)'.replaceFirst('/m', '');
      final com = _bitcoin.compile(
        policy: policy,
        scriptType: 'wpkh',
      );

      // final len = _storage.getAll<Wallet>(StoreKeys.Wallet.name).length;

      var newWallet = Wallet(
        label: state.label,
        descriptor: com.descriptor.split('#')[0],
        blockchain: _blockchainCubit.state.blockchain.name,
        walletType: 'WATCH ONLY',
      );

      final id = await _storage.saveItem<Wallet>(
        StoreKeys.Wallet.name,
        newWallet,
      );

      newWallet = newWallet.copyWith(id: id);

      await _storage.saveItemAt<Wallet>(
        StoreKeys.Wallet.name,
        id,
        newWallet,
      );

      // _storage.saveItem(StoreKeys.Wallet.name, newWallet);

      _wallets.refresh();

      emit(
        state.copyWith(
          savingWallet: false,
          newWalletSaved: true,
        ),
      );
    } catch (e, s) {
      _logger.logException(e, 'SeedImportCubit._saveWallet', s);

      emit(
        state.copyWith(
          errSavingWallet: 'Error Occured.',
          newWalletSaved: true,
        ),
      );
    }
  }

  void labelChanged(String text) {
    emit(state.copyWith(label: text, errSavingWallet: ''));
  }

  void nextClicked() async {
    switch (state.currentStep) {
      case XpubImportWalletStep.import:
        break;

      case XpubImportWalletStep.label:
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
      case XpubImportWalletStep.import:
        break;
      case XpubImportWalletStep.label:
        emit(
          state.copyWith(
            currentStep: XpubImportWalletStep.import,
            label: '',
          ),
        );
        break;
    }
  }

  @override
  Future<void> close() {
    _importSub.cancel();
    return super.close();
  }
}
