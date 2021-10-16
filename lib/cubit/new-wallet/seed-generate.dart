import 'dart:async';
import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/new-wallet/network.dart';
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
  security,
  passphrase,
  generate,
  confirm,
  label,
  networkOn,
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
    // @Default('') String walletDetails,
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

      case SeedGenerateSteps.security:
        return 'Go Offline';

      case SeedGenerateSteps.generate:
        return 'Write Seed';

      case SeedGenerateSteps.confirm:
        return 'Confirm Seed';

      case SeedGenerateSteps.passphrase:
        return 'Enter Passphrase';

      case SeedGenerateSteps.label:
        return 'Label Wallet';

      case SeedGenerateSteps.networkOn:
        return 'Go Online';
    }
  }
}

class SeedGenerateCubit extends Cubit<SeedGenerateState> {
  SeedGenerateCubit(
    this._networkCubit,
    this._bitcoin,
    // this._soloWalletAPI,
    this._storage,
    // this._walletBloc,
    // this._testNetCubit,
    this._logger,
    this._wallets,
    this._blockchainCubit,
  ) : super(const SeedGenerateState()) {
    _networkCubitSub = _networkCubit.stream.listen((NetworkState nState) {
      if (nState.hasOffError() != '') _goToNetworkAndReset();
    });
  }

  late StreamSubscription _networkCubitSub;
  final NetworkCubit _networkCubit;
  // final WalletCubit _walletBloc;

  final IBitcoin _bitcoin;
  // final ISoloWalletAPI _soloWalletAPI;
  final IStorage _storage;
  final LoggerCubit _logger;
  // final net.NetworkCubit _testNetCubit;
  final WalletsCubit _wallets;
  final BlockchainCubit _blockchainCubit;

  void _goToNetworkAndReset() {
    if (state.currentStep == SeedGenerateSteps.networkOn ||
        state.currentStep == SeedGenerateSteps.warning ||
        state.currentStep == SeedGenerateSteps.security) return;
    emit(const SeedGenerateState(currentStep: SeedGenerateSteps.security));
  }

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

      final neu = await _bitcoin.generateMaster(
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

    _createNewLocalWallet();
  }

  void _createNewLocalWallet() async {
    try {
      final der = await _bitcoin.deriveHardened(
        masterXPriv: state.xpriv!,
        account: '',
        purpose: '',
      );

      final com = await _bitcoin.compile(
        policy: der.policy,
        scriptType: 'wsh',
      );

      // final len = _storage.getAll<Wallet>(StoreKeys.Wallet.name).length;

      var newWallet = Wallet(
        label: state.walletLabel,
        descriptor: com.descriptor.split('#')[0],
        blockchain: _blockchainCubit.state.blockchain.name,
        // index: len,
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

      emit(
        state.copyWith(
          currentStep: SeedGenerateSteps.networkOn,
        ),
      );
    } catch (e, s) {
      _logger.logException(e, 'SeedGenerateCubit._createNewLocalWallet', s);
    }
  }

  void _saveWallet() async {
    _wallets.refresh();
    emit(
      state.copyWith(
        savingWalletError: '',
        savinngWallet: false,
        newWalletSaved: true,
      ),
    );
    // emit(state.copyWith(
    //   savinngWallet: true,
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
      //   savinngWallet: false,
      //   newWalletSaved: true,
      // ));
    } catch (e, s) {
      _logger.logException(e, 'SeedGenerateCubit._saveWallet', s);
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
      case SeedGenerateSteps.warning:
        emit(state.copyWith(currentStep: SeedGenerateSteps.security));
        break;
      case SeedGenerateSteps.security:
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
        _checkLabel();
        break;
      case SeedGenerateSteps.networkOn:
        _saveWallet();
        break;
    }
  }

  void backClicked() {
    switch (state.currentStep) {
      case SeedGenerateSteps.warning:
        break;
      case SeedGenerateSteps.security:
        emit(state.copyWith(currentStep: SeedGenerateSteps.warning));
        break;
      case SeedGenerateSteps.passphrase:
        emit(
          state.copyWith(
            currentStep: SeedGenerateSteps.security,
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
      case SeedGenerateSteps.networkOn:
        break;
    }
  }

  void passPhrasedChanged(String text) {
    emit(state.copyWith(passPhrase: text));
  }

  void seedWordSelected(String text) {
    if (text != state.quizSeedAnswer) {
      emit(state.copyWith(quizSeedError: 'Incorrect Word Selected'));
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

  @override
  Future<void> close() {
    _networkCubitSub.cancel();
    return super.close();
  }
}
