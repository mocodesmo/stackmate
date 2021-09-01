////
//import 'package:dio/dio.dart';
//import 'package:sats/api/auth.dart';
//import 'package:sats/pkg/crypto.dart';
//import 'package:sats/pkg/storage.dart';
//import 'package:sats/view/pin-keyboard/bloc/bloc.dart';
//import 'package:sats/view/pin-setup/bloc/bloc.dart';
//import 'package:test/test.dart';
//import 'package:bloc_test/bloc_test.dart';
//import 'package:mockito/mockito.dart';

//class _MockStorage extends Mock implements IStorage {}

//class _MockAuthApi extends Mock implements IAuthAPI {}

//class _MockPinKeyboardBloc extends MockBloc<PinKeyboardEvent, PinKeyboardState>
//    implements PinKeyboardBloc {}

//main() {
//  group('Pin Setup Bloc', () {
//    PinSetupBloc pinSetupBloc;
//    PinKeyboardBloc keyboardBloc;
//    IAuthAPI authAPI;
//    IStorage storage;

//    final hash = Crypto.hashEncrypt('1234');

//    setUp(() {
//      authAPI = _MockAuthApi();
//      storage = _MockStorage();
//      keyboardBloc = _MockPinKeyboardBloc();
//      pinSetupBloc = PinSetupBloc(keyboardBloc, authAPI, storage);
//    });

//    tearDown(() {
//      pinSetupBloc.close();
//      keyboardBloc.close();
//    });

//    test('initial state should be blank', () {
//      expect(pinSetupBloc.state, PinSetupState());
//    });

//    blocTest('should update pin length',
//        build: () => pinSetupBloc,
//        act: (PinSetupBloc bloc) {
//          bloc.add(PinSetupFieldChanged(4));
//        },
//        expect: () => [
//              PinSetupState(pin: 4),
//            ]);

//    blocTest(
//      'should update to pin entered and hash pin on confirm',
//      build: () {
//        when(keyboardBloc.state)
//            .thenReturn(PinKeyboardState(numbersEntered: ['1', '2', '3', '4']));

//        return pinSetupBloc;
//      },
//      act: (PinSetupBloc bloc) async {
//        bloc..add(PinSetupFieldChanged(4))..add(PinSetupConfirmButtonPressed());
//      },
//      expect: () => [
//        PinSetupState(pin: 4),
//        PinSetupState(pinEntered: true, pinHash: hash),
//      ],
//    );

//    blocTest(
//      'should update confirm pin length',
//      build: () {
//        when(keyboardBloc.state)
//            .thenReturn(PinKeyboardState(numbersEntered: ['1', '2', '3', '4']));

//        return pinSetupBloc;
//      },
//      act: (PinSetupBloc bloc) {
//        bloc.add(PinSetupFieldChanged(4));
//        bloc.add(PinSetupConfirmButtonPressed());
//        bloc.add(PinSetupFieldChanged(3));
//      },
//      expect: () => [
//        PinSetupState(pin: 4),
//        PinSetupState(pinEntered: true, pinHash: hash),
//        PinSetupState(pinEntered: true, pinHash: hash, confirmPin: 3),
//      ],
//    );

//    test('should show not matching pins on second confirm', () async {
//      when(keyboardBloc.state)
//          .thenReturn(PinKeyboardState(numbersEntered: ['1', '2', '3', '4']));

//      pinSetupBloc
//        ..add(PinSetupFieldChanged(4))
//        ..add(PinSetupConfirmButtonPressed());

//      await Future.delayed(Duration(microseconds: 1));
//      when(keyboardBloc.state)
//          .thenReturn(PinKeyboardState(numbersEntered: ['6', '2', '3', '3']));

//      pinSetupBloc
//        ..add(PinSetupFieldChanged(4))
//        ..add(PinSetupConfirmButtonPressed());

//      await Future.delayed(Duration(microseconds: 1));
//      expect(
//          pinSetupBloc.state,
//          PinSetupState(
//              pinEntered: true,
//              pinHash: hash,
//              confirmPinError: 'The pin does not match.'));
//    });

//    blocTest('should show save pin with auth api and save to storage',
//        build: () {
//          when(keyboardBloc.state).thenReturn(
//              PinKeyboardState(numbersEntered: ['1', '2', '3', '4']));

//          when(storage.getItem(key: CacheKeys.token))
//              .thenAnswer((_) async => 'abc');

//          when(authAPI.postPin(authToken: 'abc', hashedPin: hash)).thenAnswer(
//              (_) async =>
//                  Response(request: RequestOptions(path: ''), statusCode: 200));

//          return pinSetupBloc;
//        },
//        act: (PinSetupBloc bloc) {
//          bloc.add(PinSetupFieldChanged(4));
//          bloc.add(PinSetupConfirmButtonPressed());
//          bloc.add(PinSetupFieldChanged(4));
//          bloc.add(PinSetupConfirmButtonPressed());
//        },
//        expect: () => [
//              PinSetupState(pin: 4),
//              PinSetupState(pinEntered: true, pinHash: hash),
//              PinSetupState(pinEntered: true, pinHash: hash, confirmPin: 4),
//              PinSetupState(
//                  pinEntered: true,
//                  pinHash: hash,
//                  savingPin: true,
//                  confirmPin: 4),
//              PinSetupState(
//                  pinEntered: true,
//                  pinHash: hash,
//                  confirmPin: 4,
//                  pinSaved: true)
//            ],
//        verify: (PinSetupBloc bloc) {
//          verify(storage.getItem(key: CacheKeys.token)).called(1);
//          verify(authAPI.postPin(authToken: 'abc', hashedPin: hash)).called(1);
//          verify(storage.saveOrUpdateItem(
//                  key: CacheKeys.hashedPin, value: hash))
//              .called(1);
//        });
//  });
//}
