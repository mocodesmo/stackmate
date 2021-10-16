import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/wallet/blockchain.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/model/transaction.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/pkg/storage.dart';

part 'wallets.freezed.dart';

@freezed
class WalletsState with _$WalletsState {
  const factory WalletsState({
    @Default([]) List<Wallet> wallets,
    Wallet? selectedWallet,
    @Default(false) bool isRearranging,
  }) = _WalletsState;
}

class WalletsCubit extends Cubit<WalletsState> {
  WalletsCubit(
    this._storage,
    this._logger,
    this._blockchain,
  ) : super(const WalletsState()) {
    refresh();
  }

  final IStorage _storage;
  final LoggerCubit _logger;
  final BlockchainCubit _blockchain;

  void refresh() {
    try {
      final wallets = _storage.getAll<Wallet>(StoreKeys.Wallet.name);

      wallets.removeWhere(
        (w) => w.blockchain != _blockchain.state.blockchain.name,
      );

      wallets.sort((a, b) => a.id!.compareTo(b.id!));

      emit(state.copyWith(wallets: wallets));
    } catch (e, s) {
      _logger.logException(e, 'WalletsCubit.refresh', s);
    }
  }

  void walletSelected(Wallet wallet) async {
    emit(state.copyWith(selectedWallet: wallet));
  }

  void addTransactionsToSelectedWallet(List<Transaction> transactions) {
    final wallet = state.selectedWallet!.copyWith(
      transactions: transactions,
    );
    emit(state.copyWith(selectedWallet: wallet));
  }

  Future<void> addBalanceToSelectedWallet(int balance) async {
    final wallet = state.selectedWallet!.copyWith(
      balance: balance,
    );
    emit(state.copyWith(selectedWallet: wallet));
  }

  void clearSelectedWallet() async {
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(selectedWallet: null));
  }

  void toggleRearranging() {
    emit(state.copyWith(isRearranging: !state.isRearranging));
  }

  void rearrange(int oldId, int newId) async {
    var oldwallet = state.wallets.firstWhere((w) => w.id == oldId);
    var newwallet = state.wallets.firstWhere((w) => w.id == newId);

    oldwallet = oldwallet.copyWith(id: newId);
    newwallet = newwallet.copyWith(id: oldId);

    await _storage.saveItemAt<Wallet>(StoreKeys.Wallet.name, newId, oldwallet);
    await _storage.saveItemAt<Wallet>(StoreKeys.Wallet.name, oldId, newwallet);

    refresh();
  }
}
