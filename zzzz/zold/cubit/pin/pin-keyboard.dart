import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/pkg/vibrate.dart';

part 'pin-keyboard.freezed.dart';

@freezed
class PinKeyboardState with _$PinKeyboardState {
  const PinKeyboardState._();
  const factory PinKeyboardState({
    @Default(['2', '7', '0', '1', '8', '4', '3', '6', '9', '5'])
        List<String> numberList,
    @Default([]) List<String> numbersEntered,
  }) = _PinKeyboardState;

  bool fourKeysEntered() => numbersEntered.length == 4;
  int enteredLength() => numbersEntered.length;
}

class PinKeyboardCubit extends Cubit<PinKeyboardState> {
  PinKeyboardCubit(
    this._vibrate,
    this._logger,
  ) : super(PinKeyboardState()) {
    this.shuffleKeys();
  }

  final IVibrate _vibrate;
  final LoggerCubit _logger;

  void shuffleKeys() async {
    List<String> numList = state.numberList.toList();
    numList.shuffle();
    emit(state.copyWith(numberList: numList));
  }

  void keyPressed(String key) async {
    _vibratePhone();
    if (state.numbersEntered.length < 4) {
      List<String> numsEntered = state.numbersEntered.toList();
      numsEntered.add(key);
      emit(state.copyWith(numbersEntered: numsEntered));
    }
  }

  void clearKeys() async {
    _vibratePhone();
    emit(state.copyWith(numbersEntered: []));
  }

  void _vibratePhone() {
    try {
      _vibrate.vibe();
    } catch (e, s) {
      _logger.logException(e, 'PinKey._vibrateOnClicked', s);
    }
  }
}
