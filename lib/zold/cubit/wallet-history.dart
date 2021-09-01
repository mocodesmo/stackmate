import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/zold/api/wallet-solo.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/zold/cubit/wallet.dart';
import 'package:sats/zold/model/wallet-transaction.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/pkg/launcher.dart';
import 'package:sats/pkg/share.dart';
import 'package:sats/pkg/storage.dart';

part 'wallet-history.freezed.dart';

@freezed
class WalletHistoryState with _$WalletHistoryState {
  const factory WalletHistoryState({
    @Default([]) List<Transaction> transactions,
    @Default(false) bool loadingHistory,
    @Default('') String errLoading,
  }) = _WalletHistoryState;
}

class WalletHistoryCubit extends Cubit<WalletHistoryState> {
  WalletHistoryCubit(
    this._walletCubit,
    this._storageService,
    this._soloWalletAPI,
    this._share,
    this._launcher,
    this._logger,
  ) : super(WalletHistoryState()) {
    this.getHistory();
  }

  final IStorage _storageService;
  final ISoloWalletAPI _soloWalletAPI;
  final LoggerCubit _logger;
  final WalletCubit _walletCubit;
  final IShare _share;
  final ILauncher _launcher;

  void getHistory() async {
    try {
      emit(state.copyWith(
        loadingHistory: true,
        errLoading: '',
      ));

      final authToken = await _storageService.getItem(key: CacheKeys.token);
      final response = await _soloWalletAPI.getHistory(
        authToken: authToken,
        nickname: _walletCubit.state.selectedWallet!.nickname,
        skip: state.transactions.length,
        limit: 10,
      );

      final history = _parseTransactions(response.data);

      //await compute(_parseTransactions, response.data);

      emit(state.copyWith(
        transactions: history,
        loadingHistory: false,
      ));
    } catch (e, s) {
      _logger.logException(e, 'WalletBloc.getHistory', s);
      emit(state.copyWith(
        loadingHistory: false,
        errLoading: 'Error Occured.',
      ));
    }
  }

  void shareOrder(Transaction transaction) {
    try {
      String text = '';

      text += 'Amount: ' + transaction.amountToBtc() + ' BTC';
      text += '\nTxId: ' + transaction.txid;
      text += '\nAddress: ' + transaction.address;
      text += '\nFee: ' + transaction.feesToBtc() + ' BTC';

      _share.share(text: text, subjectForEmail: 'Transaction');
    } catch (e, s) {
      _logger.logException(e, 'BtcWalletOrderCell._shareOrder', s);
    }
  }

  void openLink(Transaction transaction) {
    try {
      //final link = 'https://blockstream.info/tx/' + widget.order.txId;
      _launcher.launchApp(transaction.link());
    } catch (e, s) {
      _logger.logException(e, 'BtcWalletOrderCell._openLink', s);
    }
  }
}

List<Transaction> _parseTransactions(dynamic body) {
  //final data = jsonDecode(body);
  final historyJson = body['message'];
  List<Transaction> historyList = [];
  for (var history in historyJson)
    historyList.add(Transaction.fromJson(history));
  return historyList;
}
