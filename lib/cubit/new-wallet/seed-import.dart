// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/wallet/blockchain.dart';
import 'package:sats/cubit/wallet/wallets.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/pkg/bitcoin.dart';
import 'package:sats/pkg/storage.dart';

part 'seed-import.freezed.dart';

enum SeedImportSteps {
  warning,
  passphrase,
  import,
  label,
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

      case SeedImportSteps.import:
        return 'Enter Seed';

      case SeedImportSteps.passphrase:
        return 'Extra Details';

      case SeedImportSteps.label:
        return 'Label Wallet';
    }
  }

  bool showSeedCompleteButton() => seed.split(' ').length == 12 ? true : false;
}

class SeedImportCubit extends Cubit<SeedImportState> {
  SeedImportCubit(
    this._bitcoin,
    this._storage,
    this._wallets,
    this._blockchainCubit,
    this.logger, {
    String walletLabel = '',
  }) : super(
          SeedImportState(
            walletLabel: walletLabel,
            labelFixed: walletLabel != '',
          ),
        );

  final IFFFI _bitcoin;

  final IStorage _storage;
  final LoggerCubit logger;
  final WalletsCubit _wallets;
  final BlockchainCubit _blockchainCubit;

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

  void _saveClicked() async {
    if (state.walletLabel.length < 4 ||
        state.walletLabel.length > 10 ||
        state.walletLabel.contains(' ')) {
      emit(state.copyWith(walletLabelError: 'Invalid Label'));
      return;
    }

    emit(state.copyWith(walletLabelError: ''));
    try {
      final neu = await _bitcoin.importMaster(
        mnemonic: state.seed,
        passphrase: state.passPhrase,
        network: _blockchainCubit.state.blockchain.name,
      );

      final der = await _bitcoin.deriveHardened(
        masterXPriv: neu.xprv,
        account: '',
        purpose: '',
      );
      final com = await _bitcoin.compile(
        policy: der.policy,
        scriptType: 'wpkh',
      );

      var newWallet = Wallet(
        label: state.walletLabel,
        walletType: 'SINGLE SIGNATURE',
        descriptor: com.descriptor.split('#')[0],
        blockchain: _blockchainCubit.state.blockchain.name,
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

      if (state.labelFixed) {
        emit(state.copyWith(newWalletSaved: true));
        return;
      }

      _wallets.refresh();

      emit(
        state.copyWith(
          savingWallet: false,
          newWalletSaved: true,
        ),
      );
    } catch (e, s) {
      logger.logException(e, 'SeedImportCubit._saveWalletLocally', s);
    }
  }

  void nextClicked() {
    switch (state.currentStep) {
      case SeedImportSteps.warning:
        emit(const SeedImportState(currentStep: SeedImportSteps.passphrase));
        break;

      case SeedImportSteps.passphrase:
        _checkPassPhrase();
        break;

      case SeedImportSteps.import:
        _checkSeed();
        break;

      case SeedImportSteps.label:
        _saveClicked();
        break;
    }
  }

  void backClicked() {
    switch (state.currentStep) {
      case SeedImportSteps.warning:
        break;

      case SeedImportSteps.passphrase:
        emit(
          const SeedImportState(
            currentStep: SeedImportSteps.warning,
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
}
