// ignore_for_file: type_annotate_public_apis

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/wallet/blockchain.dart';
import 'package:sats/cubit/wallet/wallets.dart';
import 'package:sats/deps.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/pkg/bitcoin.dart';
import 'package:sats/pkg/clipboard.dart';
import 'package:sats/pkg/share.dart';

part 'receive.freezed.dart';

abstract class ReceiveEvent {}

class GetAddress extends ReceiveEvent {}

class CopyAddress extends ReceiveEvent {}

class ShareAddress extends ReceiveEvent {}

@freezed
class ReceiveState with _$ReceiveState {
  const factory ReceiveState({
    @Default(true) bool loadingAddress,
    @Default('') String errLoadingAddress,
    String? address,
  }) = _ReceiveState;
}

class ReceiveCubit extends Bloc<ReceiveEvent, ReceiveState> {
  ReceiveCubit(
    this._walletCubit,
    this._bitcoin,
    this._blockchain,
    this._logger,
    this._clipBoard,
    this._share,
  ) : super(const ReceiveState()) {
    on<GetAddress>(getAddress, transformer: concurrent());
    on<CopyAddress>(copyAddress, transformer: concurrent());
    on<ShareAddress>(shareAddress, transformer: concurrent());
    _init();
  }

  final WalletsCubit _walletCubit;
  final IBitcoin _bitcoin;
  final LoggerCubit _logger;
  final BlockchainCubit _blockchain;
  final IShare _share;
  final IClipBoard _clipBoard;

  void _init() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    add(GetAddress());
  }

  void getAddress(event, emit) async {
    try {
      // await Future.delayed(const Duration(milliseconds: 500));

      emit(
        state.copyWith(
          loadingAddress: true,
          errLoadingAddress: '',
        ),
      );

      // await Future.delayed(const Duration(seconds: 1));

      // final w = _walletCubit.state.selectedWallet!.descriptor.split('#')[0];
      final w = _walletCubit.state.selectedWallet!.descriptor;

      final address = await compute(getAdrr, {
        'depositDesc': w,
        'network': _blockchain.state.blockchain.name,
      });
      //await _bitcoin.getAddress(
      //   depositDesc: w,
      //   network: _blockchain.state.blockchain.name,
      //   index: '0',
      // );
      // await Future.delayed(const Duration(seconds: 1));

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

  void copyAddress(event, emit) {
    try {
      _clipBoard.copyToClipBoard(state.address!);
    } catch (e, s) {
      _logger.logException(e, 'WalletCubit.copyAddress', s);
    }
  }

  void shareAddress(event, emit) {
    try {
      final address = state.address!;
      final text = 'This is my bitcoin address:\n$address';
      _share.share(text: text, subjectForEmail: 'Bitcoin Address');
    } catch (e, s) {
      _logger.logException(e, 'WalletCubit.shareAddress', s);
    }
  }
}

String getAdrr(dynamic msg) {
  final data = msg as Map<String, String>;
  final resp = BitcoinFFI().getAddressF(
    depositDesc: data['depositDesc']!,
    network: data['network']!,
    index: '0',
  );
  return resp;
}
