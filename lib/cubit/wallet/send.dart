import 'dart:convert';

import 'package:bitcoin/types.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/wallet/blockchain.dart';
import 'package:sats/cubit/wallet/node.dart';
import 'package:sats/cubit/wallet/wallet.dart';
import 'package:sats/cubit/wallet/wallets.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/pkg/bitcoin.dart';
import 'package:sats/pkg/clipboard.dart';
import 'package:sats/pkg/share.dart';
import 'package:sats/pkg/validation.dart';

part 'send.freezed.dart';

enum SendSteps {
  address,
  amounts,
  fees,
  confirm,
  sent,
}

@freezed
class SendState with _$SendState {
  const factory SendState({
    @Default(SendSteps.address) SendSteps currentStep,
    @Default(true) bool loadingStart,
    @Default(false) bool calculatingFees,
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
    int? finalFee,
    int? finalAmount,
    @Default(false) bool sweepWallet,
  }) = _SendState;
  const SendState._();

  // bool confirmStep() => psbt != '' && txId == '';
  // bool confirmedStep() => txId != '';

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

  int total() => finalFee! + finalAmount!;

  bool zeroBalanceAmt() => balance != null && balance == 0;
}

class SendCubit extends Cubit<SendState> {
  SendCubit(
    bool withQR,
    this._walletCubit,
    // this._bitcoin,
    this._blockchain,
    this._logger,
    this._clipBoard,
    this._share,
    this._nodeAddressCubit,
  ) : super(const SendState()) {
    _init(withQR);
  }

  final WalletsCubit _walletCubit;
  // final IBitcoin _bitcoin;
  final LoggerCubit _logger;
  final BlockchainCubit _blockchain;
  final IShare _share;
  final IClipBoard _clipBoard;
  final NodeAddressCubit _nodeAddressCubit;

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

      final nodeAddress = _nodeAddressCubit.state.getAddress();

      // final onehour = await compute(getFeees, {
      //   'targetSize': '6',
      //   'network': _blockchain.state.blockchain.name,
      //   'nodeAddress': nodeAddress,
      // });

      final feeFast = await compute(estimateFeees, {
        'targetSize': '1',
        'network': _blockchain.state.blockchain.name,
        'nodeAddress': nodeAddress,
      });

      final feeMedium = await compute(estimateFeees, {
        'targetSize': '3',
        'network': _blockchain.state.blockchain.name,
        'nodeAddress': nodeAddress,
      });

      final feeSlow = await compute(estimateFeees, {
        'targetSize': '6',
        'network': _blockchain.state.blockchain.name,
        'nodeAddress': nodeAddress,
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
    super.onError(error, stackTrace);
  }

  void getBalance() async {
    try {
      emit(
        state.copyWith(
          errLoading: '',
        ),
      );
      final nodeAddress = _nodeAddressCubit.state.getAddress();

      final bal = await compute(computeBalance, {
        'depositDesc': _walletCubit.state.selectedWallet!.descriptor,
        'nodeAddress': nodeAddress,
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

  void toggleSweep() {
    emit(state.copyWith(sweepWallet: !state.sweepWallet, amount: ''));
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

      final nodeAddress = _nodeAddressCubit.state.getAddress();

      final psbt = await compute(buildTx, {
        'depositDesc': _walletCubit.state.selectedWallet!.descriptor,
        'nodeAddress': nodeAddress,
        'toAddress': state.address,
        'amount': state.sweepWallet ? '0' : state.amount,
        'feeRate': state.feeRate().toString(),
        'sweep': state.sweepWallet.toString(),
      });

      final decode = await compute(decodePSBT, {
        'network': _blockchain.state.blockchain.name,
        'psbt': psbt,
      });

      final amtoutput = decode.firstWhere((o) => o.to == state.address);
      final feeoutput = decode.firstWhere((o) => o.to == 'miner');

      emit(
        state.copyWith(
          buildingTx: false,
          psbt: psbt,
          finalFee: feeoutput.value,
          finalAmount: amtoutput.value,
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
    emit(state.copyWith(psbt: '', finalAmount: null, finalFee: null));
  }

  void backClicked() {}

  void sendClicked() async {
    try {
      emit(state.copyWith(sendingTx: true, errLoading: ''));
      final nodeAddress = _nodeAddressCubit.state.getAddress();

      final signed = await compute(signTx, {
        'depositDesc': _walletCubit.state.selectedWallet!.descriptor,
        'nodeAddress': nodeAddress,
        'unsignedPSBT': state.psbt,
      });

      final txid = await compute(broadcastTx, {
        'depositDesc': _walletCubit.state.selectedWallet!.descriptor,
        'nodeAddress': nodeAddress,
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

double estimateFeees(dynamic data) {
  final obj = data as Map<String, String>;
  final resp = BitcoinFFI().estimateFees(
    targetSize: obj['targetSize']!,
    network: obj['network']!,
    nodeAddress: obj['nodeAddress']!,
  );
  return resp;
}

int getWeight(dynamic data) {
  final obj = data as Map<String, String>;
  final resp = BitcoinFFI().getWeight(
    depositDesc: obj['depositDesc']!,
    psbt: obj['psbt']!,
  );
  return resp;
}

AbsoluteFees getAbsoluteFees(dynamic data) {
  final obj = data as Map<String, String>;
  final resp = BitcoinFFI().getAbsoluteFees(
    feeRate: obj['feeRate']!,
    weight: obj['weight']!,
  );
  return resp;
}

String buildTx(dynamic data) {
  final obj = data as Map<String, String>;
  final resp = BitcoinFFI().buildTransaction(
    nodeAddress: obj['nodeAddress']!,
    amount: obj['amount']!,
    depositDesc: obj['depositDesc']!,
    feeRate: obj['feeRate']!,
    toAddress: obj['toAddress']!,
    sweep: obj['sweep']!,
  );
  return resp;
}

List<DecodedTxOutput> decodePSBT(dynamic data) {
  final obj = data as Map<String, String>;
  final resp = BitcoinFFI().decodePsbt(
    network: obj['network']!,
    psbt: obj['psbt']!,
  );
  final json = jsonDecode(resp)['outputs']['outputs'];

  final List<DecodedTxOutput> decoded = [];
  for (final out in json)
    decoded.add(DecodedTxOutput.fromJson(out as Map<String, dynamic>));

  return decoded;
}

String signTx(dynamic data) {
  final obj = data as Map<String, String>;

  final resp = BitcoinFFI().signTransaction(
    nodeAddress: obj['nodeAddress']!,
    depositDesc: obj['depositDesc']!,
    unsignedPSBT: obj['unsignedPSBT']!,
  );
  return resp;
}

String broadcastTx(dynamic data) {
  final obj = data as Map<String, String>;

  final resp = BitcoinFFI().broadcastTransaction(
    nodeAddress: obj['nodeAddress']!,
    depositDesc: obj['depositDesc']!,
    signedPSBT: obj['signedPSBT']!,
  );
  return resp;
}
