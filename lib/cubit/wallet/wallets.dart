import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/wallet/blockchain.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/pkg/storage.dart';

part 'wallets.freezed.dart';

@freezed
class WalletsState with _$WalletsState {
  const factory WalletsState({
    @Default([]) List<Wallet> wallets,
  }) = _WalletsState;
}

class WalletsCubit extends Cubit<WalletsState> {
  WalletsCubit(
    this._storage,
    this._logger,
    this._blockchainCubit,
  ) : super(WalletsState());

  final IStorage _storage;
  final LoggerCubit _logger;
  final BlockchainCubit _blockchainCubit;

  void refresh() {
    try {
      var wallets = _storage.getAll<Wallet>(StoreKeys.Wallet.name);

      // wallets.removeWhere(
      //     (w) => w.blockchain.name != _blockchainCubit.state.blockchain.name);

      emit(state.copyWith(wallets: wallets));
    } catch (e, s) {
      _logger.logException(e, 'WalletsCubit.refresh', s);
    }
  }
}
