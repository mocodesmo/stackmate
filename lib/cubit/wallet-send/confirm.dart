// import 'package:bloc/bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:sats/cubit/logger.dart';
// import 'package:sats/pkg/clipboard.dart';
// import 'package:sats/pkg/validation.dart';

// part 'tfa.freezed.dart';

// @freezed
// class BtcSendTfaState with _$BtcSendTfaState {
//   const factory BtcSendTfaState({
//     @Default('') String code,
//     @Default('') String error,
//   }) = _BtcSendTfaState;
// }

// class BtcSendTfaCubit extends Cubit<BtcSendTfaState> {
//   BtcSendTfaCubit(
//     this._clipboard,
//     this.logger,
//   ) : super(BtcSendTfaState());

//   final IClipBoard _clipboard;
//   final LoggerCubit logger;

//   void tfaClicked() {}

//   void tfaCodeChanged(String code) async {
//     emit(state.copyWith(code: code, error: ''));
//   }

//   void pasteClicked() async {
//     try {
//       final text = await _clipboard.pasteFromClipBoard();
//       if (text.length == 6 && Validation.isNumeric(text)) {
//         emit(state.copyWith(code: text, error: ''));
//       }
//     } catch (e, s) {
//       logger.logException(e, 'BtcSendTfaBloc.pasteClicked', s);
//     }
//   }

//   void checkTfaCode() async {
//     if (state.code.length != 6 || !Validation.isNumeric(state.code)) {
//       emit(state.copyWith(error: "Enter valid 2-FA code"));
//     }
//   }

//   void addTfaError(String error) async {
//     emit(state.copyWith(error: error));
//   }
// }
