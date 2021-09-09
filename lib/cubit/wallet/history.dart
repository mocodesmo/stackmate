import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/wallet/blockchain.dart';
import 'package:sats/model/transaction.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/pkg/bitcoin.dart';
import 'package:sats/pkg/launcher.dart';
import 'package:sats/pkg/share.dart';
import 'package:sats/pkg/storage.dart';

part 'history.freezed.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState(
      {@Default(false) bool loadingTransactions,
      @Default('') String errLoadingTransactions,
      List<Transaction>? transactions,
      Wallet? wallet}) = _HistoryState;
}

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(
    Wallet wallet,
    this._bitcoin,
    this._storage,
    this._logger,
    this._blockchain,
    this._launcher,
    this._share,
  ) : super(HistoryState(wallet: wallet)) {
    this.getHistory();
  }

  // final Wallet _wallet;
  final IBitcoin _bitcoin;
  final IStorage _storage;
  final LoggerCubit _logger;
  final BlockchainCubit _blockchain;
  final IShare _share;
  final ILauncher _launcher;

  void getHistory() async {
    try {
      emit(state.copyWith(
        loadingTransactions: true,
        errLoadingTransactions: '',
      ));

      final transactions = await _bitcoin.getHistory(
        depositDesc: state.wallet!.descriptor,
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

  openLink(Transaction transaction) {
    try {
      //final link = 'https://blockstream.info/tx/' + widget.order.txId;
      _launcher.launchApp(transaction.link());
    } catch (e, s) {
      _logger.logException(e, 'BtcWalletOrderCell._openLink', s);
    }
  }

  shareTransaction(Transaction transaction) {
    try {
      String text = '';

      text += 'Amount: ' + transaction.amountToBtc() + ' BTC';
      text += '\nTxId: ' + transaction.txid;
      // text += '\nAddress: ' + transaction.address;
      text += '\nFee: ' + transaction.feesToBtc() + ' BTC';

      _share.share(text: text, subjectForEmail: 'Transaction');
    } catch (e, s) {
      _logger.logException(e, 'BtcWalletOrderCell._shareOrder', s);
    }
  }
}
