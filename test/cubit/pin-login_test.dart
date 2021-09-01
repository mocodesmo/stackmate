////
//import 'package:dio/dio.dart';
//import 'package:sats/api/auth.dart';
//import 'package:sats/pkg/crypto.dart';
//import 'package:sats/pkg/storage.dart';
//import 'package:sats/view/pin-keyboard/bloc/bloc.dart';
//import 'package:sats/view/pin-login/bloc/bloc.dart';
//import 'package:test/test.dart';
//import 'package:bloc_test/bloc_test.dart';
//import 'package:mockito/mockito.dart';

//class _MockStorage extends Mock implements IStorage {}

//class _MockAuthApi extends Mock implements IAuthAPI {}

//class _MockPinKeyboardBloc extends MockBloc<PinKeyboardEvent, PinKeyboardState>
//    implements PinKeyboardBloc {}

//main() {
//  group('Pin Login Bloc', () {
//    PinLoginBloc pinLoginBloc;
//    PinKeyboardBloc keyboardBloc;
//    IAuthAPI authAPI;
//    IStorage storage;

//    final hash = Crypto.hashEncrypt('1234');

//    setUp(() {
//      authAPI = _MockAuthApi();
//      storage = _MockStorage();
//      keyboardBloc = _MockPinKeyboardBloc();
//      pinLoginBloc = PinLoginBloc(keyboardBloc, authAPI, storage);

//      when(keyboardBloc.state)
//          .thenReturn(PinKeyboardState(numbersEntered: ['1', '2', '3', '4']));

//      when(storage.getItem(key: CacheKeys.token))
//          .thenAnswer((_) async => 'abc');
//    });

//    tearDown(() {
//      pinLoginBloc.close();
//      keyboardBloc.close();
//    });

//    test('initial state should be blank', () {
//      expect(pinLoginBloc.state, PinLoginState());
//    });

//    blocTest('should update pin length',
//        build: () => pinLoginBloc,
//        act: (PinLoginBloc bloc) {
//          bloc.add(PinLoginFieldChanged(3));
//        },
//        expect: () => [
//              PinLoginState(pin: 3),
//            ]);

//    blocTest('should fail pinlogin and show 2 retries left',
//        build: () {
//          when(authAPI.postPin(authToken: 'abc', hashedPin: hash)).thenAnswer(
//              (_) async => Response(
//                  request: RequestOptions(path: ''), statusCode: 403, data: '''
//                {
//                    "status": false,
//                    "message": {
//                        "retry": 2
//                    }
//                }'''));

//          return pinLoginBloc;
//        },
//        act: (PinLoginBloc bloc) {
//          bloc
//            ..add(PinLoginFieldChanged(4))
//            ..add(PinLoginVerifyButtonPressed());
//        },
//        expect: () => [
//              PinLoginState(pin: 4),
//              PinLoginState(pin: 4, confirmingPin: true),
//              PinLoginState(error: 'Incorrect Pin Entered.', retryCount: 2),
//            ]);

//    blocTest('should fail pinlogin and show locked',
//        build: () {
//          when(authAPI.postPin(authToken: 'abc', hashedPin: hash)).thenAnswer(
//              (_) async => Response(
//                  request: RequestOptions(path: ''), statusCode: 403, data: '''
//                {
//                    "status": false,
//                    "message": {
//                        "retry": 0
//                    }
//                }'''));

//          return pinLoginBloc;
//        },
//        act: (PinLoginBloc bloc) {
//          bloc
//            ..add(PinLoginFieldChanged(4))
//            ..add(PinLoginVerifyButtonPressed());
//        },
//        expect: () => [
//              PinLoginState(pin: 4),
//              PinLoginState(pin: 4, confirmingPin: true),
//              PinLoginState(retryCount: 0),
//            ]);

//    blocTest(
//      'should login successful and save hash to storage',
//      build: () {
//        when(authAPI.postPin(authToken: 'abc', hashedPin: hash)).thenAnswer(
//            (_) async =>
//                Response(request: RequestOptions(path: ''), statusCode: 200));

//        return pinLoginBloc;
//      },
//      act: (PinLoginBloc bloc) {
//        bloc..add(PinLoginFieldChanged(4))..add(PinLoginVerifyButtonPressed());
//      },
//      expect: () => [
//        PinLoginState(pin: 4),
//        PinLoginState(pin: 4, confirmingPin: true),
//        PinLoginState(verified: true)
//      ],
//      verify: (PinLoginBloc bloc) {
//        verify(storage.getItem(key: CacheKeys.token)).called(1);
//        verify(authAPI.postPin(authToken: 'abc', hashedPin: hash)).called(1);
//        verify(storage.saveOrUpdateItem(key: CacheKeys.hashedPin, value: hash))
//            .called(1);
//      },
//    );

//    blocTest('should fail pinlogin for unknown reason',
//        build: () {
//          when(authAPI.postPin(
//                  authToken: 'abc', hashedPin: Crypto.hashEncrypt('1234')))
//              .thenAnswer((_) async =>
//                  Response(request: RequestOptions(path: ''), statusCode: 500));

//          return pinLoginBloc;
//        },
//        act: (PinLoginBloc bloc) {
//          bloc
//            ..add(PinLoginFieldChanged(4))
//            ..add(PinLoginVerifyButtonPressed());
//        },
//        expect: () => [
//              PinLoginState(pin: 4),
//              PinLoginState(pin: 4, confirmingPin: true),
//              PinLoginState(error: 'Error Occured. Please try again.')
//            ]);
//  });
//}
