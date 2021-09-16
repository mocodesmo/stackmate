import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/wallet/blockchain.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/pkg/storage.dart';

part 'wallets.freezed.dart';

@freezed
class WalletsState with _$WalletsState {
  const factory WalletsState({
    @Default([]) List<Wallet> wallets,
    Wallet? selectedWallet,
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
      wallets.sort((a, b) => a.index.compareTo(b.index));

      emit(state.copyWith(wallets: wallets));
    } catch (e, s) {
      _logger.logException(e, 'WalletsCubit.refresh', s);
    }
  }

  void walletSelected(Wallet wallet) async {
    emit(state.copyWith(selectedWallet: wallet));
  }

  void clearSelectedWallet() {
    emit(state.copyWith(selectedWallet: null));
  }
}

// List<Wallet> _wallets = const [
//   Wallet(
//     label: 'wallet2',
//     descriptor: 'oooooo',
//     blockchain: 'main',
//     index: 0,
//   ),
//   Wallet(
//     label: 'wallet3',
//     descriptor: 'oooooo',
//     blockchain: 'main',
//     index: 0,
//   ),
//   Wallet(
//     label: 'wallet4',
//     descriptor: 'oooooo',
//     blockchain: 'main',
//     index: 0,
//   ),
//   Wallet(
//     label: 'wallet6',
//     descriptor: 'oooooo',
//     blockchain: 'main',
//     index: 0,
//   ),
//   Wallet(
//     label: 'wallet5',
//     descriptor: 'oooooo',
//     blockchain: 'main',
//     index: 0,
//   ),
// ];
