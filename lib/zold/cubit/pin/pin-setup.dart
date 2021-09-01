import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/zold/api/auth.dart';
import 'package:sats/pkg/crypto.dart';
import 'package:sats/pkg/storage.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/zold/cubit/pin/pin-keyboard.dart';

part 'pin-setup.freezed.dart';

@freezed
class PinSetupState with _$PinSetupState {
  const factory PinSetupState({
    @Default(0) int pin,
    @Default('') String pinHash,
    @Default(false) bool pinEntered,
    @Default(0) int confirmPin,
    @Default('') String confirmPinError,
    @Default(false) bool savingPin,
    @Default(false) bool pinSaved,
  }) = _PinSetupState;
}

class PinSetupCubit extends Cubit<PinSetupState> {
  PinSetupCubit(
    this.keyboardBloc,
    this._authAPI,
    this._storageService,
    this.logger,
  ) : super(PinSetupState()) {
    _keyboardBlocSubscription = keyboardBloc.stream.listen(
      (state) => this.pinChanged(state.enteredLength()),
    );
  }

  final PinKeyboardCubit keyboardBloc;
  StreamSubscription? _keyboardBlocSubscription;

  final IAuthAPI _authAPI;
  final IStorage _storageService;
  final LoggerCubit logger;

  void pinChanged(int pinLength) async {
    if (!state.pinEntered)
      emit(state.copyWith(pin: pinLength));
    else
      emit(state.copyWith(confirmPin: pinLength, confirmPinError: ''));
  }

  void confirmButtonPressed() async {
    if (!state.pinEntered) {
      if (state.pin != 4) return;
      String pin = '';
      for (var key in keyboardBloc.state.numbersEntered) pin += key;
      String hash = Crypto.hashEncrypt(pin);
      keyboardBloc
        ..shuffleKeys()
        ..clearKeys();
      emit(state.copyWith(pinEntered: true, pinHash: hash, pin: 0));
      return;
    }

    String pin = '';
    for (var key in keyboardBloc.state.numbersEntered) pin += key;
    String hash = Crypto.hashEncrypt(pin);
    if (hash != state.pinHash) {
      emit(state.copyWith(
          confirmPin: 0, confirmPinError: 'The pin does not match.'));
      return;
    }

    emit(state.copyWith(savingPin: true));
    try {
      final authToken = await _storageService.getItem(key: CacheKeys.token);
      final response =
          await _authAPI.postPin(authToken: authToken, hashedPin: hash);

      if (response.statusCode == null || response.statusCode != 200)
        throw Exception('');
      _storageService.saveOrUpdateItem(key: CacheKeys.hashedPin, value: hash);
      emit(state.copyWith(savingPin: false, pinSaved: true));
    } catch (e, s) {
      logger.logException(e, 'PinSetupBloc._mapConfirmButtonPressed', s);
      emit(state.copyWith(
          savingPin: false,
          confirmPinError: 'Error Occured. Please try again.'));
    }
  }

  void confirmPinBackClicked() async {
    emit(state.copyWith(
      pinEntered: false,
      pin: 0,
      pinHash: '',
      pinSaved: false,
      savingPin: false,
      confirmPin: 0,
      confirmPinError: '',
    ));

    keyboardBloc.clearKeys();
  }

  @override
  Future<void> close() {
    if (_keyboardBlocSubscription != null) {
      _keyboardBlocSubscription!.cancel();
    }
    return super.close();
  }
}
