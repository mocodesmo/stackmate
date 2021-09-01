import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pin-change.freezed.dart';

@freezed
class PinChangeState with _$PinChangeState {
  const factory PinChangeState({
    @Default('') String currentPin,
    @Default('') String currentPinError,
    @Default(false) bool checkingCurrentPin,
    @Default(false) bool currentPinChecked,
    @Default('') String newPin,
    @Default('') String newPinError,
    @Default(false) bool newPinComplete,
    @Default('') String confirmNewPin,
    @Default('') String confirmNewPinError,
    @Default(false) bool savingNewPin,
  }) = _PinChangeState;
}

class PinChangeCubit extends Cubit<PinChangeState> {
  PinChangeCubit() : super(PinChangeState());
}
