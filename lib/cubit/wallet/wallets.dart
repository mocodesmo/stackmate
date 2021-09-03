import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/model/wallet.dart';
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
  ) : super(WalletsState()) {
    this.refresh();
  }

  final IStorage _storage;
  final LoggerCubit _logger;

  void refresh() {
    try {
      final wallets = _storage.getAll<Wallet>(StoreKeys.Wallet.name);
      emit(state.copyWith(wallets: wallets));
    } catch (e, s) {
      _logger.logException(e, 'WalletsCubit.refresh', s);
    }
  }
}
