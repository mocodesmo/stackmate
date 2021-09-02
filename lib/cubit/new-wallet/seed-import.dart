import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:sats/zold/api/_helpers.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/new-wallet/network.dart';
// import 'package:sats/cubit/network.dart' as net;
// import 'package:sats/zold/cubit/wallet.dart';
import 'package:sats/pkg/bitcoin.dart';
import 'package:sats/pkg/storage.dart';

part 'seed-import.freezed.dart';

enum SeedImportSteps {
  warning,
  security,
  import,
  passphrase,
  label,
  networkOn,
}

@freezed
class SeedImportState with _$SeedImportState {
  const SeedImportState._();
  const factory SeedImportState({
    @Default(SeedImportSteps.warning) SeedImportSteps currentStep,
    @Default('') String seed,
    @Default('') String seedError,
    @Default('') String walletLabel,
    @Default('') String passPhrase,
    @Default(0) int accountNumber,
    @Default('') String errPassPhrase,
    @Default('') String walletLabelError,
    @Default('') String walletDetails,
    @Default(false) bool savingWallet,
    @Default('') String savingWalletError,
    @Default(false) bool newWalletSaved,
    @Default(false) bool labelFixed,
  }) = _SeedImportState;

  bool showWalletConfirmButton() {
    if (walletLabel.length > 4) return true;
    return false;
  }

  bool canGoBack() {
    if (currentStep == SeedImportSteps.warning) return true;
    return false;
  }

  double completePercent() => currentStep.index / SeedImportSteps.values.length;

  String completePercentLabel() =>
      ((currentStep.index / SeedImportSteps.values.length) * 100)
          .toStringAsFixed(0);

  String currentStepLabel() {
    switch (currentStep) {
      case SeedImportSteps.warning:
        return 'Instructions';

      case SeedImportSteps.security:
        return 'Go Offline';

      case SeedImportSteps.import:
        return 'Enter Seed';

      case SeedImportSteps.passphrase:
        return 'Extra Details';

      case SeedImportSteps.label:
        return 'Label Wallet';

      case SeedImportSteps.networkOn:
        return 'Go Online';
    }
  }

  bool showSeedCompleteButton() => seed.split(' ').length == 12 ? true : false;
}

class SeedImportCubit extends Cubit<SeedImportState> {
  SeedImportCubit(
    this._networkCubit,
    this._bitcoin,
    // this._soloWalletAPI,
    // this._storage,
    // this._walletBloc,
    // this._testNetCubit,
    this.logger, {
    String walletLabel = '',
  }) : super(SeedImportState(
          walletLabel: walletLabel,
          labelFixed: walletLabel != '',
        )) {
    _networkCubitSub = _networkCubit.stream.listen((NetworkState nState) {
      if (nState.hasOffError() != '') goToNetworkAndReset();
    });
  }

  StreamSubscription? _networkCubitSub;
  final NetworkCubit _networkCubit;
  // final WalletCubit _walletBloc;

  final IBitcoin _bitcoin;
  // final ISoloWalletAPI _soloWalletAPI;
  // final IStorage _storage;
  final LoggerCubit logger;
  // final net.NetworkCubit _testNetCubit;

  goToNetworkAndReset() {
    if (state.currentStep == SeedImportSteps.networkOn ||
        state.currentStep == SeedImportSteps.warning) return;
    emit(SeedImportState(currentStep: SeedImportSteps.security));
  }

  nextClicked() {
    switch (state.currentStep) {
      case SeedImportSteps.warning:
        emit(SeedImportState(currentStep: SeedImportSteps.security));
        break;

      case SeedImportSteps.security:
        emit(SeedImportState(currentStep: SeedImportSteps.import));
        break;

      case SeedImportSteps.import:
        _checkSeed();
        break;

      case SeedImportSteps.passphrase:
        _checkPassPhrase();
        break;

      case SeedImportSteps.label:
        _checkLabel();
        break;

      case SeedImportSteps.networkOn:
        _saveWallet();
        break;
    }
  }

  backClicked() {
    switch (state.currentStep) {
      case SeedImportSteps.warning:
        break;

      case SeedImportSteps.security:
        emit(SeedImportState(currentStep: SeedImportSteps.warning));
        break;

      case SeedImportSteps.import:
        emit(SeedImportState(currentStep: SeedImportSteps.security));
        break;

      case SeedImportSteps.passphrase:
        emit(SeedImportState(currentStep: SeedImportSteps.import));
        break;

      case SeedImportSteps.label:
        emit(SeedImportState(currentStep: SeedImportSteps.passphrase));
        break;

      case SeedImportSteps.networkOn:
        break;
    }
  }

  seedTextChanged(String seed) {
    emit(state.copyWith(
      seed: seed,
      seedError: '',
    ));
  }

  _checkSeed() {
    try {
      final seed = state.seed;

      if (seed.split(' ').length != 12) {
        emit(state.copyWith(seedError: 'Invalid Seed.'));
        return;
      }

      emit(state.copyWith(currentStep: SeedImportSteps.passphrase));
    } catch (e) {}
  }

  passPhraseChanged(String text) {
    emit(state.copyWith(passPhrase: text));
  }

  accountNumberChanged(String number) {
    try {
      final val = int.parse(number);
      emit(state.copyWith(accountNumber: val));
    } catch (e) {}
  }

  _checkPassPhrase() {
    if (state.passPhrase.length > 8 || state.passPhrase.contains(' ')) {
      emit(state.copyWith(errPassPhrase: 'Invalid Passphrase'));
      return;
    }

    emit(state.copyWith(currentStep: SeedImportSteps.label, errPassPhrase: ''));
  }

  labelChanged(String text) {
    emit(state.copyWith(walletLabel: text, walletLabelError: ''));
  }

  _checkLabel() async {
    if (state.walletLabel.length < 4 ||
        state.walletLabel.length > 10 ||
        state.walletLabel.contains(' ')) {
      emit(state.copyWith(walletLabelError: 'Invalid Label'));
      return;
    }
    // if (_walletBloc.state.labelExists(state.walletLabel)) {
    //   emit(state.copyWith(walletLabelError: 'Label already exists'));
    //   return;
    // }
    emit(state.copyWith(walletLabelError: ''));
    _saveWalletLocally();
  }

  _saveWalletLocally() async {
    try {
      // final xpriv = await _bitcoin.generateMaster(
      //   mnemonic: state.seed,
      //   passphrase: state.passPhrase,
      //   network: _testNetCubit.state.isTestNet ? '1h' : '0h',
      // );

      final result = '';
      // await _bitcoin.deriveHardened(
      //   masterXPriv: xpriv,
      //   account: '0',
      // );

      final results = result.split(':');
      final fingerPrint = results[0];
      final path = results[1];
      final childXPriv = results[2];
      final childXPub = results[3];

      if (state.labelFixed) {
        // final wallet = _walletBloc.state.wallets
        //     .where((w) => w.label == state.walletLabel)
        //     .first;
        // if (wallet.xpub != childXPub) {
        //   emit(state.copyWith(walletLabelError: 'Public key does not match.'));
        //   return;
        // }
      }

      // await _storage.saveOrUpdateItem(
      //     key: CacheKeys.xPriv + ':' + state.walletLabel, value: childXPriv);

      if (state.labelFixed) {
        emit(state.copyWith(newWalletSaved: true));
        return;
      }

      emit(state.copyWith(
        currentStep: SeedImportSteps.networkOn,
        walletDetails: fingerPrint + ':' + path + ':' + childXPub,
      ));
    } catch (e, s) {
      logger.logException(e, 'SeedImportCubit._saveWalletLocally', s);
    }
  }

  _saveWallet() async {
    emit(state.copyWith(
      savingWallet: true,
      savingWalletError: '',
    ));

    try {
      // final authToken = await _storage.getItem(key: CacheKeys.token);

      // final results = state.walletDetails.split(':');

      // final response = await _soloWalletAPI.postGenesis(
      //   authToken: authToken,
      //   nickname: state.walletLabel,
      //   fingerprint: results[0],
      //   pathh: results[1],
      //   xpub: results[2],
      //   rescan: true,
      //   start: 1974272,
      //   end: 1974279,
      // );

      // if (response.statusCode != 200) throw '';

      // emit(state.copyWith(
      //   savingWallet: false,
      //   newWalletSaved: true,
      // ));
    } catch (e, s) {
      logger.logException(e, 'SeedImportCubit._saveWallet', s);

      emit(state.copyWith(
        savingWalletError: 'Error Occured.',
        newWalletSaved: true,
      ));
    }
  }

  @override
  Future<void> close() {
    if (_networkCubitSub != null) _networkCubit.close();
    return super.close();
  }
}
