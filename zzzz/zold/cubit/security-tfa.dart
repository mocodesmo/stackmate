// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sats/zold/api/auth.dart';
// import 'package:sats/pkg/clipboard.dart';
// import 'package:sats/pkg/storage.dart';
// import 'package:sats/cubit/logger.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'security-tfa.freezed.dart';

// @freezed
// class SecurityTfaState with _$SecurityTfaState {
//   const SecurityTfaState._();
//   const factory SecurityTfaState({
//     @Default(false) bool keyGenerated,
//     @Default(false) bool generatingKey,
//     @Default('') String keyGenerateError,
//     @Default('') String key,
//     @Default('') String pin,
//     @Default('') String pinError,
//     @Default(false) bool verifyingPin,
//     @Default(false) bool pinVerified,
//   }) = _SecurityTfaState;

//   bool showVerify() => pin.length == 6;
// }

// class SecurityTfaCubit extends Cubit<SecurityTfaState> {
//   SecurityTfaCubit(
//     this._authAPI,
//     this._storageService,
//     this._clipBoardService,
//     this.logger,
//   ) : super(SecurityTfaState());

//   final IAuthAPI _authAPI;
//   final IStorage _storageService;
//   final IClipBoard _clipBoardService;
//   final LoggerCubit logger;

//   void generateKey() async {
//     logger.logEvent('SecurityTfaCubit.generateKey');

//     try {
//       emit(state.copyWith(generatingKey: true));
//       final authToken = await _storageService.getItem(key: CacheKeys.token);
//       final hashedPin = await _storageService.getItem(key: CacheKeys.hashedPin);
//       final response =
//           await _authAPI.getTfa(authToken: authToken, hashedPin: hashedPin);
//       if (response.statusCode == null || response.statusCode != 200) throw '';
//       if (response.data['message']['secret'] == null) throw '';
//       emit(SecurityTfaState(
//         keyGenerated: true,
//         key: response.data['message']['secret'],
//       ));
//     } catch (e, s) {
//       logger.logException(e, 'SecurityTfaBloc.generateKey', s);
//       emit(SecurityTfaState(
//           keyGenerateError: 'Error Occured. Please try again.'));
//     }
//   }

//   void copyKey() async {
//     logger.logEvent('SecurityTfaCubit.copyKey');

//     try {
//       _clipBoardService.copyToClipBoard(state.key);
//     } catch (e, s) {
//       logger.logException(e, 'SecurityTfaBloc.copyKey', s);
//     }
//   }

//   void pasteCode() async {
//     logger.logEvent('SecurityTfaCubit.pasteCode');

//     try {
//       final code = await _clipBoardService.pasteFromClipBoard();
//       emit(state.copyWith(pin: code));
//     } catch (e, s) {
//       logger.logException(e, 'SecurityTfaBloc.pasteCode', s);
//     }
//   }

//   void tfaCodeChanged(String code) {
//     logger.logEvent('SecurityTfaCubit.tfaCodeChanged');

//     emit(state.copyWith(pin: code));
//   }

//   void verifyCode() async {
//     logger.logEvent('SecurityTfaCubit.verifyCode');

//     try {
//       emit(state.copyWith(verifyingPin: true));
//       final authToken = await _storageService.getItem(key: CacheKeys.token);
//       final hashedPin = await _storageService.getItem(key: CacheKeys.hashedPin);
//       final response = await _authAPI.postTfa(
//           authToken: authToken, hashedPin: hashedPin, code: state.pin);
//       if (response.statusCode == null) throw '';
//       if (response.statusCode == 403) {
//         emit(state.copyWith(
//             pinError: 'Invalid Code. Try Again.',
//             pin: '',
//             verifyingPin: false));
//         return;
//       }
//       if (response.statusCode != 200) throw '';
//       emit(state.copyWith(verifyingPin: false, pinVerified: true));
//     } catch (e, s) {
//       logger.logException(e, 'SecurityTfaBloc.verifyCode', s);
//       emit(state.copyWith(
//           verifyingPin: false,
//           pinError: 'Error Occured. Please try again.',
//           pin: ''));
//     }
//   }
// }
