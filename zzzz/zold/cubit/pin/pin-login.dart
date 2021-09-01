import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/zold/api/auth.dart';
import 'package:sats/pkg/crypto.dart';
import 'package:sats/pkg/storage.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/zold/cubit/pin/pin-keyboard.dart';

part 'pin-login.freezed.dart';

@freezed
class PinLoginState with _$PinLoginState {
  const PinLoginState._();
  const factory PinLoginState({
    @Default(0) int pin,
    @Default('') String error,
    @Default(false) bool confirmingPin,
    @Default(-1) int retryCount,
    @Default(false) bool verified,
  }) = _PinLoginState;

  bool locked() => retryCount == 0;
  bool notVerifiedEvenOnce() => retryCount == -1;
}

class PinLoginCubit extends Cubit<PinLoginState> {
  PinLoginCubit(
    this.keyboardBloc,
    this._authAPI,
    this._storageService,
    this.logger,
  ) : super(PinLoginState()) {
    _keyboardBlocSubscription = keyboardBloc.stream.listen(
      (state) => this.pinLoginFieldChanged(state.enteredLength()),
    );
  }

  final PinKeyboardCubit keyboardBloc;
  StreamSubscription? _keyboardBlocSubscription;

  final IAuthAPI _authAPI;
  final IStorage _storageService;
  final LoggerCubit logger;

  void pinLoginFieldChanged(int pinLength) async {
    emit(PinLoginState(pin: pinLength));
  }

  void pinLoginVerifyButtonPressed() async {
    if (state.pin != 4) return;
    String pin = '';
    for (var key in keyboardBloc.state.numbersEntered) pin += key;
    String hash = Crypto.hashEncrypt(pin);

    emit(state.copyWith(confirmingPin: true));
    try {
      final authToken = await _storageService.getItem(key: CacheKeys.token);
      final response =
          await _authAPI.postPin(authToken: authToken, hashedPin: hash);

      if (response.statusCode == null) throw Exception('');

      if (response.statusCode == 403) {
        //final data = jsonDecode(response.data);
        final attempts = response.data['message']['retry'] as int;

        if (attempts == 0) {
          emit(PinLoginState(retryCount: 0));
          return;
        }

        emit(PinLoginState(
            error: 'Incorrect Pin Entered.', retryCount: attempts));
        keyboardBloc
          ..shuffleKeys()
          ..clearKeys();
        return;
      }

      if (response.statusCode != 200) throw Exception('');

      _storageService.saveOrUpdateItem(key: CacheKeys.hashedPin, value: hash);
      emit(PinLoginState(verified: true));
    } catch (e, s) {
      logger.logException(
          e, 'PinLoginBloc._mapPinLoginVerifyButtonPressedToState', s);
      emit(PinLoginState(error: 'Error Occured. Please try again.'));
      keyboardBloc
        ..shuffleKeys()
        ..clearKeys();
    }
  }

  @override
  Future<void> close() {
    if (_keyboardBlocSubscription != null) {
      _keyboardBlocSubscription!.cancel();
    }
    return super.close();
  }
}
