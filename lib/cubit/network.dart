import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network.freezed.dart';

@freezed
class NetworkState with _$NetworkState {
  const NetworkState._();
  const factory NetworkState({
    @Default(true) bool isTestNet,
  }) = _NetworkState;

  String url() =>
      isTestNet ? 'https://test.satswala.com/' : 'https://api.satswala.com/';
}

class NetworkCubit extends Cubit<NetworkState> {
  NetworkCubit(
      // this._userCubit,
      )
      : super(NetworkState());

  // final UserCubit _userCubit;

  toggleTestNet({bool fromHome = false}) async {
    emit(NetworkState(isTestNet: !state.isTestNet));

    if (!fromHome) {
      await Future.delayed(Duration(seconds: 1));
      // _userCubit.getUser();
    }
  }
}
