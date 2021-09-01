import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/zold/api/_helpers.dart';
import 'package:sats/zold/api/wallet.dart';
import 'package:sats/zold/cubit/btc-send/fee.dart';
import 'package:sats/zold/cubit/wallet.dart';
import 'package:sats/pkg/storage.dart';
import 'package:sats/pkg/validation.dart';
import 'package:sats/cubit/logger.dart';

part 'amount.freezed.dart';

@freezed
class BtcSendAmountState with _$BtcSendAmountState {
  const BtcSendAmountState._();
  const factory BtcSendAmountState({
    @Default('') String amountEntered,
    @Default(0) double amountEnteredD,
    @Default('') String amountError,
    @Default(0) double finalAmountD,
    @Default('0.00 BTC') String amountEnteredSmall,
    //@Default(false) bool useMaxBalance,
  }) = _BtcSendAmountState;

  String finalAmountBtc() => (finalAmountD / 100000000).toStringAsFixed(8);

  String finalAmountSats() =>
      Validation.addCommas(finalAmountD.toStringAsFixed(0));

  bool hasError() => amountError != '';
}

class BtcSendAmountCubit extends Cubit<BtcSendAmountState> {
  BtcSendAmountCubit(
    this._walletCubit,
    this.storage,
    this.walletAPI,
    this._feesCubit,
    this.logger,
  ) : super(BtcSendAmountState()) {
    feeSub = _feesCubit.stream.listen((state) {
      feeChanged(state.feeEnteredD);
    });
  }

  final WalletCubit _walletCubit;
  final BtcSendFeesCubit _feesCubit;

  StreamSubscription? feeSub;

  final IStorage storage;
  final IWalletAPI walletAPI;

  final LoggerCubit logger;

  void feeChanged(int fees) {
    emit(state.copyWith(finalAmountD: state.amountEnteredD + fees));
  }

  //void toggleMaxBalance(bool useMaxB) {
  //  emit(state.copyWith(useMaxBalance: useMaxB));
  //}

  void amountEntered(String amount) async {
    try {
      String amt = amount;

      if (amt.startsWith('0')) {
        amt = amt.substring(1, amt.length);
      }

      var amountD = double.parse(Validation.removeCommas(amt));

      emit(state.copyWith(amountEntered: '', amountError: ''));

      emit(state.copyWith(
        amountEntered: Validation.addCommas(amt),
        amountEnteredD: amountD,
        finalAmountD: amountD + _feesCubit.state.feeEnteredD,
        amountEnteredSmall: (amountD / 100000000).toStringAsFixed(8),
      ));
    } catch (e, s) {
      logger.logException(
          e, 'BtcSendAmountBloc._mapAmountEnteredEventToState', s);

      emit(state.copyWith(
          amountEntered: '0',
          amountEnteredD: 0,
          finalAmountD: 0,
          amountEnteredSmall: '0.00'));
    }
  }

  void checkAmount() async {
    try {
      //if (state.useMaxBalance) {
      //  emit(state.copyWith(amountError: ''));
      //  return;
      //}

      if (state.amountEntered == "") {
        emit(state.copyWith(amountError: 'Please enter valid amount'));
        return;
      }

      final amt = state.amountEnteredD;

      if (amt <= 0 ||
          amt > _walletCubit.state.selectedWallet!.balances.confirmed)
        emit(state.copyWith(amountError: 'Please enter valid amount'));
      else
        emit(state.copyWith(amountError: ''));
    } catch (e, s) {
      logger.logException(
          e, 'BtcSendAmountBloc._mapCheckAmountEventToState', s);
      emit(state.copyWith(amountError: 'Please enter valid amount'));
    }
  }

  void addAmountError(String error) async {
    emit(state.copyWith(amountError: error));
  }

  @override
  Future<void> close() {
    if (feeSub != null) feeSub!.cancel();
    return super.close();
  }
}
