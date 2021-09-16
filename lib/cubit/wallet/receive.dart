import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/wallet/blockchain.dart';
import 'package:sats/cubit/wallet/wallets.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/pkg/bitcoin.dart';
import 'package:sats/pkg/clipboard.dart';
import 'package:sats/pkg/share.dart';

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
    this._walletCubit,
    this._bitcoin,
    this._blockchain,
    this._logger,
    this._clipBoard,
    this._share,
  ) : super(const ReceiveState()) {
    _init();
  }

  final WalletsCubit _walletCubit;
  final IBitcoin _bitcoin;
  final LoggerCubit _logger;
  final BlockchainCubit _blockchain;
  final IShare _share;
  final IClipBoard _clipBoard;

  void _init() async {
    getAddress();
  }

  void getAddress() async {
    try {
      emit(
        state.copyWith(
          loadingAddress: true,
          errLoadingAddress: '',
        ),
      );

      // await Future.delayed(const Duration(seconds: 4));

      final w = _walletCubit.state.selectedWallet!.descriptor.split('#')[0];

      final address = await _bitcoin.getAddress(
        depositDesc: w, //_wallet.descriptor,
        network: _blockchain.state.blockchain.name,
        index: '0',
      );

      _logger.logAPI(
        'get address',
        'desc: $w\nnetwork: ' +
            _blockchain.state.blockchain.name +
            '\n\nresp:\n$address',
        000,
      );

      emit(
        state.copyWith(
          loadingAddress: false,
          address: address,
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          loadingAddress: false,
          errLoadingAddress: e.toString(),
        ),
      );
      _logger.logException(e, 'ReceiveCubit.getAddress', s);
    }
  }

  void copyAddress(String address) {
    try {
      _clipBoard.copyToClipBoard(address);
    } catch (e, s) {
      _logger.logException(e, 'WalletCubit.copyAddress', s);
    }
  }

  void shareAddress(String address) {
    try {
      final text = 'This is my bitcoin address:\n$address';
      _share.share(text: text, subjectForEmail: 'Bitcoin Address');
    } catch (e, s) {
      _logger.logException(e, 'WalletCubit.shareAddress', s);
    }
  }
}
