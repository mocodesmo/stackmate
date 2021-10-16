import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/wallet/node.dart';
import 'package:sats/cubit/wallet/wallets.dart';
import 'package:sats/model/transaction.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/pkg/bitcoin.dart';
import 'package:sats/pkg/launcher.dart';
import 'package:sats/pkg/share.dart';
import 'package:sats/pkg/storage.dart';
import 'package:sats/pkg/vibrate.dart';

part 'wallet.freezed.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState({
    @Default(false) bool loadingTransactions,
    @Default('') String errLoadingTransactions,
    @Default(true) bool loadingBalance,
    @Default('') String errLoadingBalance,
    int? balance,
    List<Transaction>? transactions,
    @Default('') String errDeleting,
    @Default(false) bool deleted,
  }) = _HistoryState;
  const HistoryState._();

  bool zeroBalance() => balance == null || balance == 0;
  bool zeroBalanceAmt() => balance != null && balance == 0;
}

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(
    this._walletsCubit,
    // this._bitcoin,
    this._storage,
    this._logger,
    // this._blockchain,
    this._launcher,
    this._share,
    this._vibrate,
    this._nodeAddressCubit,
  ) : super(const HistoryState()) {
    // scheduleMicrotask(() async {
    //   await Future.delayed(const Duration(milliseconds: 1000));
    //   getHistory();
    // });
    // getHistory();

    // getHistory();
    _init();
  }

  final WalletsCubit _walletsCubit;
  // final IBitcoin _bitcoin;
  final IStorage _storage;
  final LoggerCubit _logger;
  // final BlockchainCubit _blockchain;
  final IShare _share;
  final ILauncher _launcher;
  final IVibrate _vibrate;
  final NodeAddressCubit _nodeAddressCubit;

  void _init() async {
    // await Future.delayed(const Duration(millis .econds: 1000));

    getHistory();
  }

  void getHistory() async {
    try {
      emit(
        state.copyWith(
          loadingBalance: true,
          errLoadingTransactions: '',
        ),
      );

      final node = _nodeAddressCubit.state.getAddress();

      final bal = await compute(computeBalance, {
        'depositDesc': _walletsCubit.state.selectedWallet!.descriptor,
        'nodeAddress': node,
      });

      _vibrate.vibe();

      emit(
        state.copyWith(
          loadingBalance: false,
          loadingTransactions: true,
          balance: bal,
        ),
      );

      final transactions = await compute(computeHistory, {
        'depositDesc': _walletsCubit.state.selectedWallet!.descriptor,
        'nodeAddress': node,
        // 'network': _blockchain.state.blockchain.name,
      });

      _vibrate.vibe();

      emit(
        state.copyWith(
          loadingTransactions: false,
          transactions: transactions,
          errLoadingTransactions: '',
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          loadingTransactions: false,
          errLoadingTransactions: e.toString(),
        ),
      );
      _logger.logException(e, 'HistoryCubit.getHistory', s);
    }
  }

  void openLink(Transaction transaction) {
    try {
      //final link = 'https://blockstream.info/tx/' + widget.order.txId;
      _launcher.launchApp(transaction.link());
    } catch (e, s) {
      _logger.logException(e, 'HistoryCubit.openLink', s);
    }
  }

  void shareTransaction(Transaction transaction) {
    try {
      String text = '';

      text += 'Amount: ' + transaction.amountToBtc() + ' BTC';
      text += '\nTxId: ' + transaction.txid;
      // text += '\nAddress: ' + transaction.address;
      text += '\nFee: ' + transaction.feesToBtc() + ' BTC';

      _share.share(text: text, subjectForEmail: 'Transaction');
    } catch (e, s) {
      _logger.logException(e, 'HistoryCubit.shareTransaction', s);
    }
  }

  void deleteClicked() {
    emit(state.copyWith(errDeleting: ''));

    if (state.balance == null || state.balance! > 0) {
      emit(state.copyWith(errDeleting: 'Empty wallet first'));
      return;
    }

    _storage.deleteItemAt<Wallet>(
      StoreKeys.Wallet.name,
      _walletsCubit.state.selectedWallet!.id!,
    );

    _walletsCubit.refresh();

    emit(state.copyWith(deleted: true));
  }
}

List<Transaction> computeHistory(dynamic obj) {
  final data = obj as Map<String, String>;
  final resp = BitcoinFFI().getHistory(
    depositDesc: data['depositDesc']!,
    nodeAddress: data['nodeAddress']!,
  );
  return resp;
}

int computeBalance(dynamic obj) {
  final data = obj as Map<String, String>;
  final resp = BitcoinFFI().syncBalance(
    depositDesc: data['depositDesc']!,
    nodeAddress: data['nodeAddress']!,
  );
  return resp;
}
