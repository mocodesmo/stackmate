import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/wallet/blockchain.dart';
import 'package:sats/model/transaction.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/pkg/bitcoin.dart';
import 'package:sats/pkg/storage.dart';

part 'history.freezed.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState({
    @Default(false) bool loadingTransactions,
    @Default('') String errLoadingTransactions,
    List<Transaction>? transactions,
  }) = _HistoryState;
}

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(
    this._wallet,
    this._bitcoin,
    this._storage,
    this._logger,
    this._blockchain,
  ) : super(HistoryState());

  final Wallet _wallet;
  final IBitcoin _bitcoin;
  final IStorage _storage;
  final LoggerCubit _logger;
  final BlockchainCubit _blockchain;

  void getHistory() async {
    try {
      emit(state.copyWith(
        loadingTransactions: true,
        errLoadingTransactions: '',
      ));

      final transactions = await _bitcoin.getHistory(
        depositDesc: 'depositDesc',
        nodeAddress: '',
        network: _blockchain.state.blockchain.name,
      );

      emit(state.copyWith(
        loadingTransactions: false,
        transactions: transactions,
      ));
    } catch (e, s) {
      emit(state.copyWith(
        loadingTransactions: false,
        errLoadingTransactions: e.toString(),
      ));
      _logger.logException(e, 'HistoryCubit.getHistory', s);
    }
  }
}
