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

part 'seed-generate.freezed.dart';

enum SeedGenerateSteps {
  warning,
  passphrase,
  generate,
  confirm,
  label,
}

@freezed
class SeedGenerateState with _$SeedGenerateState {
  const factory SeedGenerateState({
    @Default(SeedGenerateSteps.warning) SeedGenerateSteps currentStep,
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
  }) = _SeedGenerateState;
  const SeedGenerateState._();

  bool showWalletConfirmButton() {
    if (walletLabel.length > 4) return true;
    return false;
  }

  bool canGoBack() {
    if (currentStep == SeedGenerateSteps.warning) return true;
    return false;
  }

  double completePercent() =>
      currentStep.index / SeedGenerateSteps.values.length;

  String completePercentLabel() =>
      ((currentStep.index / SeedGenerateSteps.values.length) * 100)
          .toStringAsFixed(0);

  String currentStepLabel() {
    switch (currentStep) {
      case SeedGenerateSteps.warning:
        return 'Instructions';

      case SeedGenerateSteps.generate:
        return 'Write Seed';

      case SeedGenerateSteps.confirm:
        return 'Confirm Seed';

      case SeedGenerateSteps.passphrase:
        return 'Enter Passphrase';

      case SeedGenerateSteps.label:
        return 'Label Wallet';
    }
  }
}

class SeedGenerateCubit extends Cubit<SeedGenerateState> {
  SeedGenerateCubit(
    this._bitcoin,
    this._storage,
    this._logger,
    this._wallets,
    this._blockchainCubit,
  ) : super(const SeedGenerateState());

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
        currentStep: SeedGenerateSteps.generate,
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
          currentStep: SeedGenerateSteps.generate,
          seed: neu.neuList,
          xpriv: neu.xprv,
          fingerPrint: neu.fingerprint,
        ),
      );
    } catch (e, s) {
      _logger.logException(e, 'SeedGenerateCubit._generateSeed', s);

      emit(
        state.copyWith(
          generatingSeed: false,
          seedError: 'Error Occured.',
        ),
      );
      _logger.logException(e, 'SeedGenerateCubit._generateSeed', s);
    }
  }

  void _confirmSeed() {
    emit(
      state.copyWith(
        currentStep: SeedGenerateSteps.confirm,
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
      final der = _bitcoin.deriveHardened(
        masterXPriv: state.xpriv!,
        account: '',
        purpose: '',
      );

      final com = _bitcoin.compile(
        policy: der.policy,
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
      _logger.logException(e, 'SeedGenerateCubit._createNewLocalWallet', s);
    }
  }

  void nextClicked() {
    switch (state.currentStep) {
      case SeedGenerateSteps.warning:
        emit(state.copyWith(currentStep: SeedGenerateSteps.passphrase));
        break;

      case SeedGenerateSteps.passphrase:
        _checkPassphrase();
        break;
      case SeedGenerateSteps.generate:
        _confirmSeed();
        break;
      case SeedGenerateSteps.confirm:
        break;
      case SeedGenerateSteps.label:
        _saveClicked();
        break;
    }
  }

  void backClicked() {
    switch (state.currentStep) {
      case SeedGenerateSteps.warning:
        break;

      case SeedGenerateSteps.passphrase:
        emit(
          state.copyWith(
            currentStep: SeedGenerateSteps.warning,
            passPhrase: '',
            xpriv: null,
            fingerPrint: null,
          ),
        );
        break;
      case SeedGenerateSteps.generate:
        emit(
          state.copyWith(
            currentStep: SeedGenerateSteps.passphrase,
            xpriv: null,
            fingerPrint: null,
          ),
        );
        break;
      case SeedGenerateSteps.confirm:
        emit(
          state.copyWith(
            currentStep: SeedGenerateSteps.passphrase,
            quizSeedAnswer: '',
            quizSeedList: [],
            quizSeedError: '',
            quizSeedCompletedAnswers: [],
            xpriv: null,
            fingerPrint: null,
          ),
        );
        break;
      case SeedGenerateSteps.label:
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
      emit(state.copyWith(currentStep: SeedGenerateSteps.label));
      return;
    }

    _generateQuiz();
  }

  void labelChanged(String text) {
    emit(state.copyWith(walletLabel: text, walletLabelError: ''));
  }
}
