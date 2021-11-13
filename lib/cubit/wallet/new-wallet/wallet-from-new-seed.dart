import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/wallet/blockchain.dart';
import 'package:sats/cubit/wallet/wallets.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/pkg/bitcoin.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/pkg/storage.dart';

part 'wallet-from-new-seed.freezed.dart';

enum SeedGenerateWalletSteps {
  warning,
  passphrase,
  generate,
  confirm,
  label,
}

@freezed
class SeedGenerateWalletState with _$SeedGenerateWalletState {
  const factory SeedGenerateWalletState({
    @Default(SeedGenerateWalletSteps.warning)
        SeedGenerateWalletSteps currentStep,
    List<String>? seed,
    String? xpriv,
    String? fingerPrint,
    @Default(false) bool generatingSeed,
    @Default('') String seedError,
    @Default(0) int quizSeedCompleted,
    @Default('') String quizSeedAnswer,
    @Default(-1) int quizSeedAnswerIdx,
    @Default([]) List<String> quizSeedList,
    @Default([]) List<String> quizSeedCompletedAnswers,
    @Default('') String quizSeedError,
    @Default('') String passPhrase,
    @Default('') String errPassphrase,
    @Default('') String walletLabel,
    @Default('') String walletLabelError,
    @Default(false) bool savinngWallet,
    @Default('') String savingWalletError,
    @Default(false) bool newWalletSaved,
  }) = _SeedGenerateWalletState;
  const SeedGenerateWalletState._();

  bool showWalletConfirmButton() {
    if (walletLabel.length > 4) return true;
    return false;
  }

  bool canGoBack() {
    if (currentStep == SeedGenerateWalletSteps.warning) return true;
    return false;
  }

  double completePercent() =>
      currentStep.index / SeedGenerateWalletSteps.values.length;

  String completePercentLabel() =>
      ((currentStep.index / SeedGenerateWalletSteps.values.length) * 100)
          .toStringAsFixed(0);

  String currentStepLabel() {
    switch (currentStep) {
      case SeedGenerateWalletSteps.warning:
        return 'Instructions';

      case SeedGenerateWalletSteps.generate:
        return 'Write Seed';

      case SeedGenerateWalletSteps.confirm:
        return 'Confirm Seed';

      case SeedGenerateWalletSteps.passphrase:
        return 'Enter Passphrase';

      case SeedGenerateWalletSteps.label:
        return 'Label Wallet';
    }
  }
}

class SeedGenerateWalletCubit extends Cubit<SeedGenerateWalletState> {
  SeedGenerateWalletCubit(
    this._bitcoin,
    this._storage,
    this._logger,
    this._wallets,
    this._blockchainCubit,
  ) : super(const SeedGenerateWalletState());

  final IFFFI _bitcoin;

  final IStorage _storage;
  final LoggerCubit _logger;

  final WalletsCubit _wallets;
  final BlockchainCubit _blockchainCubit;

  void _checkPassphrase() {
    if (state.passPhrase.length > 8 || state.passPhrase.contains(' ')) {
      emit(state.copyWith(errPassphrase: 'Invalid Passphrase'));
      return;
    }

    _generateSeed();

    emit(
      state.copyWith(
        currentStep: SeedGenerateWalletSteps.generate,
        errPassphrase: '',
      ),
    );
  }

  void _generateSeed() async {
    try {
      emit(
        state.copyWith(
          generatingSeed: true,
          seedError: '',
        ),
      );

      final neu = _bitcoin.generateMaster(
        length: '12',
        passphrase: state.passPhrase,
        network: _blockchainCubit.state.blockchain.name,
      );

      emit(
        state.copyWith(
          generatingSeed: false,
          currentStep: SeedGenerateWalletSteps.generate,
          seed: neu.neuList,
          xpriv: neu.xprv,
          fingerPrint: neu.fingerprint,
        ),
      );
    } catch (e, s) {
      _logger.logException(e, 'SeedGenerateWalletCubit._generateSeed', s);

      emit(
        state.copyWith(
          generatingSeed: false,
          seedError: 'Error Occured.',
        ),
      );
      _logger.logException(e, 'SeedGenerateWalletCubit._generateSeed', s);
    }
  }

  void _confirmSeed() {
    emit(
      state.copyWith(
        currentStep: SeedGenerateWalletSteps.confirm,
        quizSeedCompleted: 0,
      ),
    );

    _generateQuiz();
  }

  void _generateQuiz() {
    final List<String> quizList = [...state.seed!];

    String answer = '';
    while (answer == '') {
      final idx = Random().nextInt(quizList.length);
      if (!state.quizSeedCompletedAnswers.contains(quizList[idx]))
        answer = quizList[idx];
    }
    final answerIdx = quizList.indexOf(answer);

    for (final completed in state.quizSeedCompletedAnswers)
      quizList.remove(completed);

    final List<String> answerList = [answer];
    quizList.remove(answer);
    for (var i = 0; i < 5; i++) {
      final randIdx = Random().nextInt(quizList.length);
      answerList.add(quizList[randIdx]);
      quizList.remove(quizList[randIdx]);
      if (quizList.isNotEmpty) quizList.removeLast();
    }

    answerList.shuffle();

    emit(
      state.copyWith(
        quizSeedError: '',
        quizSeedAnswer: answer,
        quizSeedList: answerList,
        quizSeedAnswerIdx: answerIdx + 1,
      ),
    );
  }

  void _saveClicked() async {
    if (state.walletLabel.length < 4 ||
        state.walletLabel.length > 10 ||
        state.walletLabel.contains(' ')) {
      emit(state.copyWith(walletLabelError: 'Invalid Label'));
      return;
    }

    try {
      final wallet = _bitcoin.deriveHardened(
        masterXPriv: state.xpriv!,
        account: '',
        purpose: '',
      );

      final policy =
          'pk([${wallet.fingerPrint}/${wallet.hardenedPath}]${wallet.xprv}/0/*)'
              .replaceFirst('/m', '');

      final com = _bitcoin.compile(
        policy: policy,
        scriptType: 'wpkh',
      );

      var newWallet = Wallet(
        label: state.walletLabel,
        walletType: 'SINGLE ACCOUNT',
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

      _wallets.refresh();
      emit(
        state.copyWith(
          savingWalletError: '',
          savinngWallet: false,
          newWalletSaved: true,
        ),
      );
    } catch (e, s) {
      _logger.logException(
          e, 'SeedGenerateWalletCubit._createNewLocalWallet', s);
    }
  }

  void nextClicked() {
    switch (state.currentStep) {
      case SeedGenerateWalletSteps.warning:
        emit(state.copyWith(currentStep: SeedGenerateWalletSteps.passphrase));
        break;

      case SeedGenerateWalletSteps.passphrase:
        _checkPassphrase();
        break;
      case SeedGenerateWalletSteps.generate:
        _confirmSeed();
        break;
      case SeedGenerateWalletSteps.confirm:
        break;
      case SeedGenerateWalletSteps.label:
        _saveClicked();
        break;
    }
  }

  void backClicked() {
    switch (state.currentStep) {
      case SeedGenerateWalletSteps.warning:
        break;

      case SeedGenerateWalletSteps.passphrase:
        emit(
          state.copyWith(
            currentStep: SeedGenerateWalletSteps.warning,
            passPhrase: '',
            xpriv: null,
            fingerPrint: null,
          ),
        );
        break;
      case SeedGenerateWalletSteps.generate:
        emit(
          state.copyWith(
            currentStep: SeedGenerateWalletSteps.passphrase,
            xpriv: null,
            fingerPrint: null,
          ),
        );
        break;
      case SeedGenerateWalletSteps.confirm:
        emit(
          state.copyWith(
            currentStep: SeedGenerateWalletSteps.passphrase,
            quizSeedAnswer: '',
            quizSeedList: [],
            quizSeedError: '',
            quizSeedCompletedAnswers: [],
            xpriv: null,
            fingerPrint: null,
          ),
        );
        break;
      case SeedGenerateWalletSteps.label:
        break;
    }
  }

  void passPhrasedChanged(String text) {
    emit(state.copyWith(passPhrase: text));
  }

  void seedWordSelected(String text) async {
    if (text != state.quizSeedAnswer) {
      emit(state.copyWith(quizSeedError: 'Incorrect Word Selected'));
      await Future.delayed(const Duration(seconds: 1));
      backClicked();
      return;
    }
    emit(state.copyWith(quizSeedError: ''));

    final List<String> completedAnswers =
        state.quizSeedCompletedAnswers.toList();
    completedAnswers.add(text);

    emit(
      state.copyWith(
        quizSeedCompletedAnswers: completedAnswers,
        quizSeedCompleted: completedAnswers.length,
      ),
    );

    if (completedAnswers.length == 3) {
      emit(state.copyWith(currentStep: SeedGenerateWalletSteps.label));
      return;
    }

    _generateQuiz();
  }

  void labelChanged(String text) {
    emit(state.copyWith(walletLabel: text, walletLabelError: ''));
  }
}
