import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/chain-select.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/new-wallet/common/seed-generate.dart';
import 'package:sats/cubit/new-wallet/common/xpub-import.dart';
import 'package:sats/cubit/node.dart';
import 'package:sats/cubit/wallets.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/pkg/core.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/pkg/storage.dart';

part 'inheritance-timer.freezed.dart';

enum InteritanceTimerWalletSteps {
  info,
  settings,
  seed,
  import,
  label,
}

@freezed
class InheritanceTimerState with _$InheritanceTimerState {
  const factory InheritanceTimerState({
    @Default(InteritanceTimerWalletSteps.info)
        InteritanceTimerWalletSteps currentStep,
    DateTime? date,
    @Default('') String errDate,
    @Default('') String walletLabel,
    @Default('') String errWalletLabel,
    @Default(false) bool savingWallet,
    @Default('') String errSavingWallet,
    @Default(false) bool newWalletSaved,
  }) = _InheritanceTimerState;
  const InheritanceTimerState._();
}

class InteritanceTimerCubit extends Cubit<InheritanceTimerState> {
  InteritanceTimerCubit(
    this._core,
    this._storage,
    this._logger,
    this._wallets,
    this._blockchainCubit,
    this._generateCubit,
    this._importCubit,
    this._nodeAddressCubit,
    this._blockchain,
  ) : super(const InheritanceTimerState()) {
    _generateCubit.stream.listen((gstate) {
      if (gstate.wallet != null) {
        emit(state.copyWith(currentStep: InteritanceTimerWalletSteps.import));
      }
    });
    _importCubit.stream.listen((istate) {
      if (istate.detailsReady) {
        emit(state.copyWith(currentStep: InteritanceTimerWalletSteps.label));
      }
    });
  }

  final IStackMateCore _core;

  final IStorage _storage;
  final LoggerCubit _logger;

  final WalletsCubit _wallets;
  final ChainSelectCubit _blockchainCubit;

  final SeedGenerateCubit _generateCubit;
  final XpubImportCubit _importCubit;
  late StreamSubscription _generateSub;
  late StreamSubscription _importSub;
  final NodeAddressCubit _nodeAddressCubit;
  final ChainSelectCubit _blockchain;

  void dateSelected(DateTime date) =>
      emit(state.copyWith(date: date, errDate: ''));

  void backClicked() {
    switch (state.currentStep) {
      case InteritanceTimerWalletSteps.info:
        break;
      case InteritanceTimerWalletSteps.settings:
        emit(state.copyWith(currentStep: InteritanceTimerWalletSteps.info));
        break;

      case InteritanceTimerWalletSteps.seed:
        emit(state.copyWith(currentStep: InteritanceTimerWalletSteps.settings));
        _generateCubit.clear();
        break;
      case InteritanceTimerWalletSteps.import:
        emit(state.copyWith(currentStep: InteritanceTimerWalletSteps.settings));
        _importCubit.clear();
        break;

      case InteritanceTimerWalletSteps.label:
        emit(state.copyWith(currentStep: InteritanceTimerWalletSteps.settings));
        break;
    }
  }

  void nextClicked() {
    switch (state.currentStep) {
      case InteritanceTimerWalletSteps.info:
        emit(state.copyWith(currentStep: InteritanceTimerWalletSteps.settings));

        break;
      case InteritanceTimerWalletSteps.settings:
        if (state.date == null || state.date!.isBefore(DateTime.now())) {
          emit(state.copyWith(errDate: 'Invalid Date Selected'));
          return;
        }
        emit(state.copyWith(currentStep: InteritanceTimerWalletSteps.seed));
        break;

      case InteritanceTimerWalletSteps.seed:
      case InteritanceTimerWalletSteps.import:
        break;

      case InteritanceTimerWalletSteps.label:
        saveClicked();
        break;
    }
  }

  void labelChanged(String text) =>
      emit(state.copyWith(walletLabel: text, errWalletLabel: ''));

  void saveClicked() async {
    try {
      if (state.walletLabel.length < 4 ||
          state.walletLabel.length > 10 ||
          state.walletLabel.contains(' ')) {
        emit(state.copyWith(errWalletLabel: 'Invalid Label'));
        return;
      }

      final wallet = _generateCubit.state.wallet;
      if (wallet == null) return;
      final mainPolicy =
          'pk([${wallet.fingerPrint}/${wallet.hardenedPath}]${wallet.xprv}/0/*)'
              .replaceFirst('/m', '');

      final xpubState = _importCubit.state;
      final fingerprint = xpubState.fingerPrint;
      final path = xpubState.path;
      final xpub = xpubState.xpub;
      String backupPolicy = '';
      if (!xpubState.showOtherDetails())
        backupPolicy = 'pk($xpub/0/*)';
      else
        backupPolicy =
            'pk([$fingerprint/$path]$xpub/0/*)'.replaceFirst('/m', '');


      final from = DateTime.now();
      final to = state.date!;
      final days = (to.difference(from).inHours / 24).round();
      final blocks = _core.daysToBlocks(days: days.toString());
      final currentHeight = _core.getHeight(
        network: _blockchain.state.blockchain.name,
        nodeAddress: _nodeAddressCubit.state.getAddress(),
      );
      final height = currentHeight + blocks;
      final combinedPolicy =
          'or($mainPolicy,and($backupPolicy, after($height)))';
      final res = _core.compile(
        policy: combinedPolicy,
        scriptType: 'wsh',
      );

      var newWallet = Wallet(
        label: state.walletLabel,
        descriptor: res.descriptor.split('#')[0],
        blockchain: _blockchainCubit.state.blockchain.name,
        walletType: 'INHERITANCE',
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
          savingWallet: false,
          newWalletSaved: true,
        ),
      );
    } catch (e, s) {
      _logger.logException(e, 'SeedImportCubit._saveWalletLocally', s);
    }
  }

  @override
  Future<void> close() {
    _importSub.cancel();
    _generateSub.cancel();
    return super.close();
  }
}
