import 'package:bloc/bloc.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/wallet/blockchain.dart';
import 'package:sats/cubit/wallet/wallets.dart';
import 'package:sats/model/wallet.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/pkg/storage.dart';
import 'package:sats/state.dart';

part 'reorder-wallets.freezed.dart';

@freezed
class ReorderWalletsState with _$ReorderWalletsState {
  const factory ReorderWalletsState({
    @Default([]) List<Wallet> wallets,
    @Default(false) bool arranging,
  }) = _ReorderWalletsState;
}

class ReorderWalletsCubit extends Cubit<ReorderWalletsState> {
  ReorderWalletsCubit(
    this._walletsCubit,
    this._storage,
    this._logger,
    this._blockchain,
  ) : super(ReorderWalletsState());

  final IStorage _storage;
  final LoggerCubit _logger;
  final BlockchainCubit _blockchain;
  final WalletsCubit _walletsCubit;

  void getWallets() async {
    try {
      var wallets = _storage.getAll<Wallet>(StoreKeys.Wallet.name);
      wallets.sort((a, b) => a.index.compareTo(b.index));

      emit(state.copyWith(wallets: wallets));
    } catch (e, s) {
      _logger.logException(e, 'WalletsCubit.refresh', s);
    }
  }

  void rearrange(int oldIdx, int newIdx) {
    try {
      emit(state.copyWith(arranging: true));
      var wallets = _storage.getAll<Wallet>(StoreKeys.Wallet.name);
      wallets.sort((a, b) => a.index.compareTo(b.index));
      var movedWallet = wallets.removeAt(oldIdx);
      wallets.insert(newIdx, movedWallet);
      _storage.clearAll(StoreKeys.Wallet.name);
      for (var i = 0; i < wallets.length; i++) {
        final w = wallets[0].copyWith(index: i);
        _storage.saveItem(StoreKeys.Wallet.name, w);
      }
      walletsCubit.refresh();
      emit(state.copyWith(arranging: false));
    } catch (e, s) {
      emit(state.copyWith(arranging: false));
      _logger.logException(e, 'ReorderWalletsCubit.rearrange', s);
    }
  }
}