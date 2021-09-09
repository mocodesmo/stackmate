import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/wallet/blockchain.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/pkg/bitcoin.dart';

part 'receive.freezed.dart';

@freezed
class ReceiveState with _$ReceiveState {
  const factory ReceiveState({
    @Default(false) bool loadingAddress,
    @Default('') String errLoadingAddress,
    String? address,
  }) = _ReceiveState;
}

class ReceiveCubit extends Cubit<ReceiveState> {
  ReceiveCubit(
    this._wallet,
    this._bitcoin,
    this._blockchain,
    this._logger,
  ) : super(ReceiveState());

  final Wallet _wallet;
  final IBitcoin _bitcoin;
  final LoggerCubit _logger;
  final BlockchainCubit _blockchain;

  void getAddress() async {
    try {
      emit(state.copyWith(
        loadingAddress: true,
        errLoadingAddress: '',
      ));

      final address = await _bitcoin.getAddress(
        depositDesc: '',
        network: _blockchain.state.blockchain.name,
        index: '0',
      );

      emit(state.copyWith(
        loadingAddress: false,
        address: address,
      ));
    } catch (e, s) {
      emit(state.copyWith(
        loadingAddress: false,
        errLoadingAddress: e.toString(),
      ));
      _logger.logException(e, 'ReceiveCubit.getAddress', s);
    }
  }
}
