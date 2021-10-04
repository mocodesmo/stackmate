import 'package:flutter/foundation.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/wallet/blockchain.dart';
import 'package:sats/cubit/wallet/history.dart';
import 'package:sats/cubit/wallet/wallets.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/pkg/bitcoin.dart';
import 'package:sats/pkg/clipboard.dart';
import 'package:sats/pkg/share.dart';
import 'package:sats/pkg/validation.dart';

part 'send.freezed.dart';

@freezed
class SendState with _$SendState {
  const factory SendState({
    @Default(true) bool loadingStart,
    @Default(false) bool buildingTx,
    @Default(false) bool sendingTx,
    @Default('') String errLoading,
    @Default('') String errAddress,
    @Default('') String errAmount,
    @Default('') String errFees,
    @Default('') String address,
    @Default('') String amount,
    @Default('') String fees,
    double? feeSlow,
    double? feeMedium,
    double? feefast,
    int? balance,
    @Default(1) int feesOption,
    @Default('') String psbt,
    @Default('') String txId,
  }) = _SendState;
  const SendState._();

  bool confirmStep() => psbt != '' && txId == '';
  bool confirmedStep() => txId != '';

  double feeRate() {
    try {
      if (fees != '') return double.parse(fees);
      if (feesOption == 0) return feeSlow!;
      if (feesOption == 1) return feeMedium!;
      if (feesOption == 2) return feefast!;
    } catch (e) {
      print(e.toString());
    }
    return 0;
  }

  int total() {
    try {
      final amountInt = int.parse(amount);
      final feeInt = feeRate();
      return amountInt; //+ feeInt;
    } catch (e) {
      print(e);
    }

    return 0;
  }

  bool zeroBalanceAmt() => balance != null && balance == 0;
}

class SendCubit extends Cubit<SendState> {
  SendCubit(
    bool withQR,
    this._walletCubit,
    this._bitcoin,
    this._blockchain,
    this._logger,
    this._clipBoard,
    this._share,
  ) : super(const SendState()) {
    _init(withQR);
  }

  final WalletsCubit _walletCubit;
  final IBitcoin _bitcoin;
  final LoggerCubit _logger;
  final BlockchainCubit _blockchain;
  final IShare _share;
  final IClipBoard _clipBoard;

  void _init(bool withQR) async {
    if (withQR) {
      await Future.delayed(const Duration(milliseconds: 500));
      scanAddress(true);
    } else {
      await Future.delayed(const Duration(milliseconds: 1000));
      getFees();
    }
  }

  void getFees() async {
    try {
      emit(
        state.copyWith(
          loadingStart: true,
        ),
      );

      final feeFast = await compute(getFeees, {
        'targetSize': '1',
        'network': _blockchain.state.blockchain.name,
      });

      final feeMedium = await compute(getFeees, {
        'targetSize': '3',
        'network': _blockchain.state.blockchain.name,
      });

      final feeSlow = await compute(getFeees, {
        'targetSize': '6',
        'network': _blockchain.state.blockchain.name,
      });

      emit(
        state.copyWith(
          feefast: feeFast,
          feeMedium: feeMedium,
          feeSlow: feeSlow,
        ),
      );

      getBalance();
    } catch (e, s) {
      emit(
        state.copyWith(
          loadingStart: false,
          errLoading: e.toString(),
        ),
      );
      _logger.logException(e, 'SendCubit.getFees', s);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(error, stackTrace);
  }

  void getBalance() async {
    try {
      emit(
        state.copyWith(
          errLoading: '',
        ),
      );

      final bal = await compute(computeBalance, {
        'depositDesc': _walletCubit.state.selectedWallet!.descriptor,
        'network': _blockchain.state.blockchain.name,
      });

      emit(
        state.copyWith(
          balance: bal,
          loadingStart: false,
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          loadingStart: false,
          errLoading: e.toString(),
        ),
      );
      _logger.logException(e, 'SendCubit.getBalance', s);
    }
  }

  void adddressChanged(String text) {
    emit(state.copyWith(address: text));
  }

  void pasteAddress() async {
    final text = await _clipBoard.pasteFromClipBoard();
    emit(state.copyWith(address: text));
  }

  void scanAddress(bool onStart) async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        false,
        ScanMode.QR,
      );
      if (barcodeScanRes == '-1') barcodeScanRes = '';

      emit(state.copyWith(address: barcodeScanRes));

      await Future.delayed(const Duration(milliseconds: 1000));

      if (onStart) getFees();
    } catch (e, s) {
      if (onStart) getFees();
      emit(
        state.copyWith(
          // loadingStart: false,
          errLoading: e.toString(),
        ),
      );
      _logger.logException(e, 'SendCubit.scanqr', s);
    }
  }

  void amountChanged(String amount) {
    final checked = amount.replaceAll('.', '');
    emit(state.copyWith(amount: checked));
  }

  void emptyWallet() {
    //calc fees
    emit(
      state.copyWith(
        amount: state.balance!.toString(),
      ),
    );
  }

  void feeSelected(int idx) {
    //calc total
    emit(
      state.copyWith(
        feesOption: idx,
      ),
    );
  }

  void feeChanged(String fee) {
    final checked = fee.replaceAll('.', '');
    emit(state.copyWith(fees: checked, feesOption: 4));
  }

  void confirmClicked() async {
    try {
      emit(
        state.copyWith(
          errAddress: '',
          errAmount: '',
          errFees: '',
          errLoading: '',
        ),
      );

      if (!Validation.isBtcAddress(state.address))
        emit(state.copyWith(errAddress: 'Invalid Wallet Address'));

      if (!_checkAmount())
        emit(state.copyWith(errAmount: 'Please enter a valid amount'));

      if (!_checkFee())
        emit(state.copyWith(errAmount: 'Please enter a valid fee amount'));

      await Future.delayed(const Duration(milliseconds: 100));

      if (state.errAddress != '' ||
          state.errAmount != '' ||
          state.errFees != '') return;

      emit(state.copyWith(buildingTx: true, errLoading: ''));

      final psbt = await compute(buildTx, {
        'depositDesc': _walletCubit.state.selectedWallet!.descriptor,
        'network': _blockchain.state.blockchain.name,
        'toAddress': state.address,
        'amount': state.amount,
        'feeRate': state.feeRate().toString(),
      });

      emit(
        state.copyWith(
          buildingTx: false,
          psbt: psbt,
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          buildingTx: false,
          errLoading: e.toString(),
        ),
      );

      _logger.logException(e, 'SendCubit.confirmclicked', s);
    }
  }

  bool _checkAmount() {
    return true;
  }

  bool _checkFee() {
    return true;
  }

  void clearPsbt() {
    emit(state.copyWith(psbt: ''));
  }

  void sendClicked() async {
    try {
      emit(state.copyWith(sendingTx: true, errLoading: ''));

      final signed = await compute(signTx, {
        'depositDesc': _walletCubit.state.selectedWallet!.descriptor,
        'network': _blockchain.state.blockchain.name,
        'unsignedPSBT': state.psbt,
      });

      final txid = await compute(broadcastTx, {
        'depositDesc': _walletCubit.state.selectedWallet!.descriptor,
        'network': _blockchain.state.blockchain.name,
        'signedPSBT': signed,
      });

      emit(
        state.copyWith(
          sendingTx: false,
          errLoading: '',
          txId: txid,
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          sendingTx: false,
          errLoading: e.toString(),
        ),
      );
      _logger.logException(e, 'SendCubit.sendclicked', s);
    }
  }

  void shareTxId() {
    _share.share(
      text: 'This is the txid: ' + state.txId,
      subjectForEmail: 'transaction',
    );
  }
}

double getFeees(dynamic data) {
  final obj = data as Map<String, String>;
  final resp = BitcoinFFI().getFees(
    targetSize: obj['targetSize']!,
    network: obj['network']!,
  );
  return resp;
}

String buildTx(dynamic data) {
  final obj = data as Map<String, String>;
  final resp = BitcoinFFI().buildTransaction(
    network: obj['network']!,
    amount: obj['amount']!,
    depositDesc: obj['depositDesc']!,
    feeRate: obj['feeRate']!,
    toAddress: obj['toAddress']!,
  );
  return resp;
}

String signTx(dynamic data) {
  final obj = data as Map<String, String>;

  final resp = BitcoinFFI().signTransaction(
    network: obj['network']!,
    depositDesc: obj['depositDesc']!,
    unsignedPSBT: obj['unsignedPSBT']!,
  );
  return resp;
}

String broadcastTx(dynamic data) {
  final obj = data as Map<String, String>;

  final resp = BitcoinFFI().broadcastTransaction(
    network: obj['network']!,
    depositDesc: obj['depositDesc']!,
    signedPSBT: obj['signedPSBT']!,
  );
  return resp;
}
