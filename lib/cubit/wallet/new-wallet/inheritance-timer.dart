import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/chain-select.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/wallet/common/seed-generate.dart';
import 'package:sats/cubit/wallets.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/pkg/bitcoin.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/pkg/storage.dart';

part 'inheritance-timer.freezed.dart';

enum InteritanceTimerWalletCubit {
  warning,
  settings,
  seed,
  import,
  label,
}

@freezed
class InheritanceTimerState with _$InheritanceTimerState {
  const factory InheritanceTimerState({
    @Default(InteritanceTimerWalletCubit.warning)
        InteritanceTimerWalletCubit currentStep,
    @Default(365) int days,
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
    this._bitcoin,
    this._storage,
    this._logger,
    this._wallets,
    this._blockchainCubit,
    this._generateCubit,
  ) : super(const InheritanceTimerState());

  final IBitcoinCore _bitcoin;

  final IStorage _storage;
  final LoggerCubit _logger;

  final WalletsCubit _wallets;
  final ChainSelectCubit _blockchainCubit;
  final SeedGenerateCubit _generateCubit;
  late StreamSubscription _generateSub;

  void dateSelected(DateTime date) {
    emit(state);
  }

  void backClicked() {
    switch (state.currentStep) {
      case InteritanceTimerWalletCubit.warning:
        break;
      case InteritanceTimerWalletCubit.settings:
        break;
      case InteritanceTimerWalletCubit.seed:
        break;
      case InteritanceTimerWalletCubit.import:
        break;
      case InteritanceTimerWalletCubit.label:
        break;
    }
  }

  void nextClicked() {
    switch (state.currentStep) {
      case InteritanceTimerWalletCubit.warning:
        break;
      case InteritanceTimerWalletCubit.settings:
        break;
      case InteritanceTimerWalletCubit.seed:
        break;
      case InteritanceTimerWalletCubit.import:
        break;
      case InteritanceTimerWalletCubit.label:
        break;
    }
  }

  void labelChanged(String text) =>
      emit(state.copyWith(walletLabel: text, errWalletLabel: ''));

  void saveClicked() {}
}
