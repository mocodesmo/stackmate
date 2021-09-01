import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/zold/api/network.dart';
import 'package:sats/pkg/storage.dart';
import 'package:sats/zold/model/network-info.dart';
import 'package:sats/cubit/logger.dart';

part 'traffic.freezed.dart';

@freezed
class TrafficState with _$TrafficState {
  const factory TrafficState({
    Fee? fee,
    @Default(false) bool loading,
    @Default('') String error,
  }) = _TrafficState;
}

class TrafficCubit extends Cubit<TrafficState> {
  TrafficCubit(
    this._storage,
    this._networkAPI,
    this.logger,
  ) : super(TrafficState()) {
    this.fetchTraffic();
  }

  //final IWalletAPI _walletAPI;
  final INetworkAPI _networkAPI;
  final IStorage _storage;
  final LoggerCubit logger;

  void fetchTraffic() async {
    try {
      emit(state.copyWith(loading: true));

      final authToken = await _storage.getItem(key: CacheKeys.token);
      final response = await _networkAPI.getInfo(authToken: authToken);

      if (response.statusCode == null || response.statusCode != 200) throw '';
      final networkInfo = NetworkInfo.fromJson(response.data['message']);
      final fees = networkInfo.fees; //Fee.fromJson(response.data['message']);

      emit(state.copyWith(fee: fees, loading: false));
    } catch (e, s) {
      logger.logException(e, 'BtcSendAmountBloc._mapFetchTraffic', s);
      emit(state.copyWith(
          loading: false, error: 'Error Occured. Please try again.'));
    }
  }

  void updateTraffic(Fee trafficFee) async {
    emit(state.copyWith(fee: trafficFee));
  }
}
