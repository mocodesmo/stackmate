import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/zold/api/network.dart';
import 'package:sats/zold/api/wallet.dart';
import 'package:sats/zold/model/network-info.dart';
import 'package:sats/pkg/storage.dart';
import 'package:sats/pkg/validation.dart';
import 'package:sats/zold/cubit/btc-send/traffic.dart';
import 'package:sats/cubit/logger.dart';

part 'fee.freezed.dart';

enum Traffic { low, medium, high }

@freezed
class BtcSendFeesState with _$BtcSendFeesState {
  const BtcSendFeesState._();
  const factory BtcSendFeesState({
    @Default('') String feeEntered,
    @Default(0) int feeEnteredD,
    @Default('0.00 BTC') String feeEnteredSmall,
    @Default('') String feeError,
    @Default(false) bool fetchingFee,
    @Default(NetworkInfo()) NetworkInfo networkInfo,
    @Default(Traffic.medium) Traffic feeSelected,
    @Default('') String fetchFeeError,
  }) = _BtcSendFeesState;

  bool hasError() => fetchFeeError != '';

  String feeSats() {
    final feeD = feeSelected == Traffic.medium
        ? networkInfo.fees.medium
        : networkInfo.fees.slow;
    return Validation.addCommas(feeD.toStringAsFixed(0));
  }

  String feesBtc() {
    int feeI = 0;

    if (feeSelected == Traffic.low) feeI = networkInfo.fees.slow;
    if (feeSelected == Traffic.medium) feeI = networkInfo.fees.medium;
    if (feeSelected == Traffic.high) feeI = networkInfo.fees.high;

    //final feeD = feeSelected == Traffic.medium
    //    ? networkInfo.fees.medium
    //    : networkInfo.fees.slow;
    return (feeI / 100000000).toStringAsFixed(8);
  }
}

class BtcSendFeesCubit extends Cubit<BtcSendFeesState> {
  BtcSendFeesCubit(
    this._trafficBloc,
    this.storage,
    this.walletAPI,
    this._networkAPI,
    this.logger,
  ) : super(BtcSendFeesState());

  final TrafficCubit _trafficBloc;

  final IStorage storage;
  final IWalletAPI walletAPI;
  final INetworkAPI _networkAPI;

  final LoggerCubit logger;

  void fetchFee() async {
    try {
      emit(state.copyWith(fetchingFee: true));
      final authToken = await storage.getItem(key: CacheKeys.token);
      final response = await _networkAPI.getInfo(authToken: authToken);
      if (response.statusCode == null || response.statusCode != 200) throw '';

      final data = response.data['message'];
      final networkInfo = NetworkInfo.fromJson(data);
      final fees = networkInfo.fees;

      _trafficBloc.updateTraffic(fees);
      emit(state.copyWith(
        networkInfo: networkInfo,
        fetchingFee: false,
      ));
      await Future.delayed(Duration(microseconds: 100));

      switch (networkInfo.traffic) {
        case 'low':
          changeFee(Traffic.low);
          break;
        case 'medium':
          changeFee(Traffic.medium);
          break;
        case 'high':
          changeFee(Traffic.high);
          break;
      }
    } catch (e, s) {
      logger.logException(e, 'BtcSendAmountBloc._mapFetchFeeEventToState', s);

      emit(state.copyWith(
          fetchFeeError: 'Error Occured. Please try again.',
          fetchingFee: false));
    }
  }

  void feeEntered(String amount) {
    try {
      String amt = amount;

      if (amt.startsWith('0')) {
        amt = amt.substring(1, amt.length);
      }

      var feeD = int.parse(Validation.removeCommas(amt));

      emit(state.copyWith(feeError: ''));

      emit(state.copyWith(
        feeEntered: Validation.addCommas(amt),
        feeEnteredD: feeD,
        feeEnteredSmall: (feeD / 100000000).toStringAsFixed(8),
      ));
    } catch (e, s) {
      logger.logException(
          e, 'BtcSendAmountBloc._mapAmountEnteredEventToState', s);

      emit(state.copyWith(
        feeEntered: '0',
        feeEnteredD: 0,
        feeEnteredSmall: '0.00 BTC',
      ));
    }
  }

  void changeFee(Traffic traffic) async {
    try {
      String fee = '';
      int feeD = 0;

      switch (traffic) {
        case Traffic.low:
          feeD = state.networkInfo.fees.slow;
          fee = feeD.toString();
          break;
        case Traffic.medium:
          feeD = state.networkInfo.fees.medium;
          fee = feeD.toString();
          break;
        case Traffic.high:
          feeD = state.networkInfo.fees.high;
          fee = feeD.toString();
          break;
      }

      emit(state.copyWith(
        feeEnteredD: feeD,
        feeEntered: Validation.addCommas(fee),
        feeSelected: traffic,
      ));
    } catch (e, s) {
      logger.logException(e, 'BtcSendAmountBloc._mapChangeFeeEventToState', s);
    }
  }
}
