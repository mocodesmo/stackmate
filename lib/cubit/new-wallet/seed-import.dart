// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/new-wallet/network.dart';
import 'package:sats/cubit/wallet/blockchain.dart';
import 'package:sats/cubit/wallet/wallets.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/pkg/bitcoin.dart';
import 'package:sats/pkg/storage.dart';

part 'seed-import.freezed.dart';

enum SeedImportSteps {
  warning,
  security,
  passphrase,
  import,
  label,
  networkOn,
}

@freezed
class SeedImportState with _$SeedImportState {
  const factory SeedImportState({
    @Default(SeedImportSteps.warning) SeedImportSteps currentStep,
    @Default('') String seed,
    @Default('') String seedError,
    @Default('') String walletLabel,
    @Default('') String passPhrase,
    @Default(0) int accountNumber,
    @Default('') String errPassPhrase,
    @Default('') String walletLabelError,
    // @Default('') String walletDetails,
    @Default(false) bool savingWallet,
    @Default('') String savingWalletError,
    @Default(false) bool newWalletSaved,
    @Default(false) bool labelFixed,
  }) = _SeedImportState;
  const SeedImportState._();

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
    this._storage,
    // this._walletBloc,
    // this._testNetCubit,
    this._wallets,
    this._blockchainCubit,
    this.logger, {
    String walletLabel = '',
  }) : super(
          SeedImportState(
            walletLabel: walletLabel,
            labelFixed: walletLabel != '',
          ),
        ) {
    networkCubitSub = _networkCubit.stream.listen((NetworkState nState) {
      if (nState.hasOffError() != '') _goToNetworkAndReset();
    });
  }

  late StreamSubscription networkCubitSub;
  final NetworkCubit _networkCubit;
  // final WalletCubit _walletBloc;

  final IBitcoin _bitcoin;
  // final ISoloWalletAPI _soloWalletAPI;
  final IStorage _storage;
  final LoggerCubit logger;
  final WalletsCubit _wallets;
  final BlockchainCubit _blockchainCubit;

  // final net.NetworkCubit _testNetCubit;

  void _goToNetworkAndReset() {
    if (state.currentStep == SeedImportSteps.networkOn ||
        state.currentStep == SeedImportSteps.warning) return;
    emit(const SeedImportState(currentStep: SeedImportSteps.security));
  }

  void _checkPassPhrase() {
    if (state.passPhrase.length > 8 || state.passPhrase.contains(' ')) {
      emit(state.copyWith(errPassPhrase: 'Invalid Passphrase'));
      return;
    }

    emit(
      state.copyWith(
        currentStep: SeedImportSteps.import,
        errPassPhrase: '',
      ),
    );
  }

  void _checkSeed() {
    try {
      final seed = state.seed;

      if (seed.split(' ').length != 12) {
        emit(state.copyWith(seedError: 'Invalid Seed.'));
        return;
      }

      emit(state.copyWith(currentStep: SeedImportSteps.label));
    } catch (e) {
      print(e.toString());
    }
  }

  void _checkLabel() async {
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

  void _saveWalletLocally() async {
    try {
      final neu = await _bitcoin.importMaster(
        mnemonic: state.seed,
        passphrase: state.passPhrase,
        network: _blockchainCubit.state.blockchain.name,
      );

      //check nmeu ?

      final der = await _bitcoin.deriveHardened(
        masterXPriv: neu.xprv,
        account: '',
        purpose: '',
      );
      final com = await _bitcoin.compile(
        policy: der.policy,
        scriptType: 'wsh',
      );

      final len = _storage.getAll<Wallet>(StoreKeys.Wallet.name).length;

      final newWallet = Wallet(
        label: state.walletLabel,
        descriptor: com.descriptor.split('#')[0],
        blockchain: _blockchainCubit.state.blockchain.name,
        index: len,
      );

      _storage.saveItem(StoreKeys.Wallet.name, newWallet);

      if (state.labelFixed) {
        emit(state.copyWith(newWalletSaved: true));
        return;
      }

      emit(
        state.copyWith(
          currentStep: SeedImportSteps.networkOn,
        ),
      );
    } catch (e, s) {
      logger.logException(e, 'SeedImportCubit._saveWalletLocally', s);
    }
  }

  void _saveWallet() async {
    _wallets.refresh();

    emit(
      state.copyWith(
        savingWallet: false,
        newWalletSaved: true,
      ),
    );
    // emit(state.copyWith(
    //   savingWallet: true,
    //   savingWalletError: '',
    // ));

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

      emit(
        state.copyWith(
          savingWalletError: 'Error Occured.',
          newWalletSaved: true,
        ),
      );
    }
  }

  void nextClicked() {
    switch (state.currentStep) {
      case SeedImportSteps.warning:
        emit(const SeedImportState(currentStep: SeedImportSteps.security));
        break;

      case SeedImportSteps.security:
        emit(const SeedImportState(currentStep: SeedImportSteps.passphrase));
        break;

      case SeedImportSteps.passphrase:
        _checkPassPhrase();
        break;

      case SeedImportSteps.import:
        _checkSeed();
        break;

      case SeedImportSteps.label:
        _checkLabel();
        break;

      case SeedImportSteps.networkOn:
        _saveWallet();
        break;
    }
  }

  void backClicked() {
    switch (state.currentStep) {
      case SeedImportSteps.warning:
        break;

      case SeedImportSteps.security:
        emit(const SeedImportState(currentStep: SeedImportSteps.warning));
        break;

      case SeedImportSteps.passphrase:
        emit(
          const SeedImportState(
            currentStep: SeedImportSteps.security,
            passPhrase: '',
            errPassPhrase: '',
          ),
        );
        break;

      case SeedImportSteps.import:
        emit(
          const SeedImportState(
            currentStep: SeedImportSteps.passphrase,
            seed: '',
            seedError: '',
          ),
        );
        break;

      case SeedImportSteps.label:
        emit(const SeedImportState(currentStep: SeedImportSteps.passphrase));
        break;

      case SeedImportSteps.networkOn:
        break;
    }
  }

  void seedTextChanged(String seed) {
    emit(
      state.copyWith(
        seed: seed,
        seedError: '',
      ),
    );
  }

  void passPhraseChanged(String text) {
    emit(state.copyWith(passPhrase: text));
  }

  void accountNumberChanged(String number) {
    try {
      final val = int.parse(number);
      emit(state.copyWith(accountNumber: val));
    } catch (e) {
      print(e.toString());
    }
  }

  void labelChanged(String text) {
    emit(state.copyWith(walletLabel: text, walletLabelError: ''));
  }

  @override
  Future<void> close() {
    networkCubitSub.cancel();
    return super.close();
  }
}
