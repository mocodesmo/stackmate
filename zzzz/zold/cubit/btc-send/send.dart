import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/zold/api/network.dart';
import 'package:sats/zold/api/wallet-solo.dart';
import 'package:sats/zold/cubit/btc-send/fee.dart';
import 'package:sats/zold/cubit/user.dart';
import 'package:sats/zold/cubit/wallet.dart';
import 'package:sats/pkg/bitcoin.dart';
import 'package:sats/pkg/storage.dart';
import 'package:sats/zold/cubit/btc-send/address.dart';
import 'package:sats/zold/cubit/btc-send/amount.dart';
import 'package:sats/zold/cubit/btc-send/confirm.dart';
import 'package:sats/cubit/logger.dart';

part 'send.freezed.dart';
part 'send.g.dart';

@freezed
class BtcSendState with _$BtcSendState {
  const factory BtcSendState({
    @Default(BtcSendSteps.address) BtcSendSteps step,
    @Default(false) bool submitting,
    @Default(false) bool confirming,
    @Default('') String confirmingError,
    @Default(false) bool submitted,
    @Default('') String psbt,
  }) = _BtcSendState;
}

@freezed
class BtcSendError with _$BtcSendError {
  const BtcSendError._();
  factory BtcSendError({
    @JsonKey(name: 'address') @Default(false) bool address,
    @JsonKey(name: 'comment') @Default(false) bool comment,
    @JsonKey(name: 'amount') @Default(false) bool amount,
  }) = _BtcSendError;

  factory BtcSendError.fromJson(Map<String, dynamic> json) =>
      _$BtcSendErrorFromJson(json);
}

enum BtcSendSteps { address, amount, confirm }

class BtcSendCubit extends Cubit<BtcSendState> {
  BtcSendCubit(
    this._walletCubit,
    this._addressBloc,
    this._feesCubit,
    this._amountBloc,
    this._tfaBloc,
    this._storage,
    this._soloWalletAPI,
    this._userCubit,
    this._networkAPI,
    this._bitcoin,
    this.logger,
  ) : super(BtcSendState()) {
    _tfaBlocSubscription = _tfaBloc.stream.listen((state) {
      if (state.code.length == 6) this.nextClicked();
    });
  }

  final IStorage _storage;
  final ISoloWalletAPI _soloWalletAPI;
  final LoggerCubit logger;
  final WalletCubit _walletCubit;
  final UserCubit _userCubit;
  final IBitcoin _bitcoin;
  final INetworkAPI _networkAPI;

  final BtcSendAddressCubit _addressBloc;
  final BtcSendAmountCubit _amountBloc;
  final BtcSendFeesCubit _feesCubit;
  final BtcSendTfaCubit _tfaBloc;
  StreamSubscription? _tfaBlocSubscription;

  void backClicked() async {
    switch (state.step) {
      case BtcSendSteps.address:
        break;
      case BtcSendSteps.amount:
        emit(state.copyWith(step: BtcSendSteps.address));
        break;

      case BtcSendSteps.confirm:
        emit(state.copyWith(step: BtcSendSteps.amount));
        break;
    }
  }

  void nextClicked() async {
    switch (state.step) {
      case BtcSendSteps.address:
        _nextOnAddress();
        break;
      case BtcSendSteps.amount:
        _nextOnAmount();
        break;

      case BtcSendSteps.confirm:
        _nextOnConfirm();
        break;
    }
  }

  _nextOnAddress() async {
    _addressBloc.checkAddress();
    await Future.delayed(Duration(microseconds: 5));
    if (!_addressBloc.state.hasError()) {
      _feesCubit.fetchFee();
      emit(state.copyWith(step: BtcSendSteps.amount));
    }
  }

  _nextOnAmount() async {
    _amountBloc.checkAmount();
    await Future.delayed(Duration(microseconds: 5));
    if (_amountBloc.state.hasError()) return;

    emit(state.copyWith(confirming: true, confirmingError: ''));

    try {
      final authToken = await _storage.getItem(key: CacheKeys.token);
      final hashedPin = await _storage.getItem(key: CacheKeys.hashedPin);

      final response = await _soloWalletAPI.postPayment(
        authToken: authToken,
        hashedPin: hashedPin,
        tfaCode: _userCubit.state.user!.tfaStatus ? _tfaBloc.state.code : null,
        nickname: _walletCubit.state.selectedWallet!.nickname,
        address: _addressBloc.state.address,
        amount: _amountBloc.state.amountEnteredD.toInt(),
        comment: _addressBloc.state.comment,
        fees: _feesCubit.state.feeEnteredD.toInt(),
      );

      //if (response.statusCode == 403) {
      //  //_tfaBloc.addTfaError('Invalid 2FA Code');
      //  emit(state.copyWith(confirming: false));
      //  return;
      //}

      if (response.statusCode == 400) {
        final errors = BtcSendError.fromJson(response.data['message']);
        BtcSendSteps step = BtcSendSteps.confirm;
        if (!errors.amount) {
          _amountBloc.addAmountError('Invalid Amount');
          step = BtcSendSteps.amount;
        }
        if (!errors.comment) {
          _addressBloc.addCommentError('Invalid Comment');
          step = BtcSendSteps.address;
        }
        if (!errors.address) {
          _addressBloc.addAddressError('Invalid Address');
          step = BtcSendSteps.address;
        }
        emit(state.copyWith(confirming: false, step: step));
        return;
      }
      if (response.statusCode != 202 && response.statusCode != 200) throw '';
      final data = response.data['message']['txid'];
      _feesCubit.feeEntered(data['fee'].toString());
      //_amountBloc.amountEntered(data['amount'].toString());
      await Future.delayed(Duration(milliseconds: 5));
      emit(state.copyWith(
        confirming: false,
        psbt: data['psbt'],
        step: BtcSendSteps.confirm,
      ));
    } catch (e, s) {
      logger.logException(e, 'BtcSendBloc._mapNextClickedEventToState', s);
      emit(state.copyWith(
        confirming: false,
        confirmingError: 'Error Occured. Please try again',
      ));
      //_tfaBloc.addTfaError('Error Occured. Please try again');
    }
  }

  _nextOnConfirm() async {
    try {
      // if (_userCubit.state.user!.tfaStatus) _tfaBloc.checkTfaCode();
      // await Future.delayed(Duration(microseconds: 5));
      // if (_userCubit.state.user!.tfaStatus && _tfaBloc.state.error != '')
      //   return;
      // emit(state.copyWith(submitting: true));
      // final selectedWallet = _walletCubit.state.selectedWallet!;

      // final xpriv = await _storage.getItem(
      //     key: CacheKeys.xPriv + ':' + selectedWallet.nickname);

      // final signedPsbt = '';
      // // await _bitcoin.signPsbt(
      // //   fingerprint: selectedWallet.fingerprint,
      // //   accountIndex: '0',
      // //   xprv: xpriv,
      // //   psbt: state.psbt,
      // //   //xprv: mockPriv,
      // //   //psbt: mockPsbt,
      // // );

      // final psbtStr = signedPsbt.split(':');
      // if (!Validation.toBoolean(psbtStr[0])) throw 'PSBT status failed';

      // final authToken = await _storage.getItem(key: CacheKeys.token);
      // final response = await _networkAPI.postBroadcast(
      //   authToken: authToken,
      //   psbt: psbtStr[1],
      // );

      // if (response.statusCode != 200) throw '';

      // emit(state.copyWith(submitting: false, submitted: true));
    } catch (e, s) {
      logger.logException(e, 'BtcSendBloc._mapNextClickedEventToState', s);
      emit(state.copyWith(submitting: false));
      _tfaBloc.addTfaError('Error Occured. Please try again');
    }
  }

  @override
  Future<void> close() {
    if (_tfaBlocSubscription != null) _tfaBlocSubscription!.cancel();
    return super.close();
  }
}

const mockPriv =
    'tprv8gowNnAeEeS2u25ozp8KajdBzPKT2nbYiM4cf67b9YGcnSiA3zfzhab1TtFXaLJFbgCjwYBgEwnkqZx2Rwx8ZM7e4naCUmmdzQ3ewCWdPZf';

const mockPsbt =
    'cHNidP8BAHICAAAAATU5V1ZI/LDxZUSeyXODquplqyeTazqgcLVUJ7YuRR7YAAAAAAD9////AugDAAAAAAAAF6kUz3vt766SeJkQkxQXIgptuN9izCyH6ioAAAAAAAAWABTxLiP8caGqpqO2Al94gqWZ3I7C5wAAAAAAAQDhAgAAAALOZTmtqgu57xSP+xcC2CChEjrPo/UH+W+V/NcaN8GWFgAAAAAjIgAgdyaNkRKBppt0tWBZNJHa7tZpSIycvB68QjXlGC3tJCX9////wBa6qkgZOscUEpbWMxaMJls6cOZQthqD9pRulfD9aoQAAAAAIyIAIP7ABjTuCF8VaAc97ag/cTWEKMonVodR8qEBUFPcOACe/f///wLgLgAAAAAAABYAFCurLzJcOORhMtGkttTRItmYA5gxuYQJAAAAAAAXqRQSfNS819dS8oDsd8LYU9AkriL6IoenGh4AAQEf4C4AAAAAAAAWABQrqy8yXDjkYTLRpLbU0SLZmAOYMSIGAg8pgoei4kRGxnX3oJqYRB6gZrtMYD+RC0ACY5HB9DSmGD6bDr1UAACAAQAAgAAAAIAAAAAAAAAAAAAAIgIDUrKOhiCB69BmsJ8jweJgffgZBIPvBsTEJHbAU/f1ucgYPpsOvVQAAIABAACAAAAAgAEAAAAAAAAAAA==';
