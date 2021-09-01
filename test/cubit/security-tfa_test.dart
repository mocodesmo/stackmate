////
//import 'package:dio/dio.dart';
//import 'package:sats/api/auth.dart';
//import 'package:sats/pkg/clipboard.dart';
//import 'package:sats/view/security-tfa/cubit/cubit.dart';
//import 'package:test/test.dart';
//import 'package:sats/pkg/storage.dart';
//import 'package:bloc_test/bloc_test.dart';
//import 'package:mockito/mockito.dart';

//class _MockStorage extends Mock implements IStorage {}

//class _MockAuthApi extends Mock implements IAuthAPI {}

//class _MockClipboard extends Mock implements IClipBoard {}

//main() {
//  group('Security Tfa Bloc', () {
//    SecurityTfaBloc bloc;
//    IAuthAPI authAPI;
//    IStorage storage;
//    IClipBoard clipBoard;

//    setUp(() {
//      authAPI = _MockAuthApi();
//      storage = _MockStorage();
//      clipBoard = _MockClipboard();

//      bloc = SecurityTfaBloc(authAPI, storage, clipBoard);

//      when(storage.getItem(key: CacheKeys.hashedPin))
//          .thenAnswer((_) async => 'abc');

//      when(storage.getItem(key: CacheKeys.token))
//          .thenAnswer((_) async => 'abc');
//    });

//    tearDown(() {
//      bloc.close();
//    });

//    test('initial state should be blank', () {
//      expect(bloc.state, SecurityTfaState());
//    });

//    blocTest('should show error while generating key',
//        build: () {
//          when(authAPI.getTfa(authToken: 'abc', hashedPin: 'abc')).thenAnswer(
//              (_) async =>
//                  Response(request: RequestOptions(path: ''), statusCode: 500));

//          return bloc;
//        },
//        act: (SecurityTfaBloc bloc) {
//          bloc.add(GenerateKey());
//        },
//        expect: () => [
//              SecurityTfaState(generatingKey: true),
//              SecurityTfaState(
//                  keyGenerateError: 'Error Occured. Please try again.')
//            ],
//        verify: (SecurityTfaBloc bloc) {
//          verify(storage.getItem(key: CacheKeys.token)).called(1);
//          verify(storage.getItem(key: CacheKeys.hashedPin)).called(1);
//          verify(authAPI.getTfa(authToken: 'abc', hashedPin: 'abc')).called(1);
//        });

//    blocTest('should show key',
//        build: () {
//          when(authAPI.getTfa(authToken: 'abc', hashedPin: 'abc')).thenAnswer(
//              (_) async => Response(
//                  request: RequestOptions(path: ''), statusCode: 200, data: '''
//            {
//              "status": true,
//              "message": {
//                "secret": "xyz"
//              }
//            }
//            '''));

//          return bloc;
//        },
//        act: (SecurityTfaBloc bloc) {
//          bloc.add(GenerateKey());
//        },
//        expect: () => [
//              SecurityTfaState(generatingKey: true),
//              SecurityTfaState(keyGenerated: true, key: 'xyz'),
//            ],
//        verify: (SecurityTfaBloc bloc) {
//          verify(storage.getItem(key: CacheKeys.token)).called(1);
//          verify(storage.getItem(key: CacheKeys.hashedPin)).called(1);
//          verify(authAPI.getTfa(authToken: 'abc', hashedPin: 'abc')).called(1);
//        });

//    blocTest(
//      'should copy key',
//      build: () {
//        when(authAPI.getTfa(authToken: 'abc', hashedPin: 'abc')).thenAnswer(
//            (_) async => Response(
//                request: RequestOptions(path: ''), statusCode: 200, data: '''
//            {
//              "status": true,
//              "message": {
//                "secret": "xyz"
//              }
//            }
//            '''));

//        return bloc;
//      },
//      act: (SecurityTfaBloc bloc) {
//        bloc..add(GenerateKey())..add(CopyKey());
//      },
//      expect: () => [
//        SecurityTfaState(generatingKey: true),
//        SecurityTfaState(keyGenerated: true, key: 'xyz'),
//      ],
//      verify: (SecurityTfaBloc bloc) {
//        verify(storage.getItem(key: CacheKeys.token)).called(1);
//        verify(storage.getItem(key: CacheKeys.hashedPin)).called(1);
//        verify(clipBoard.copyToClipBoard('xyz')).called(1);
//        verify(authAPI.getTfa(authToken: 'abc', hashedPin: 'abc')).called(1);
//      },
//    );

//    blocTest('should paste code',
//        build: () {
//          when(authAPI.getTfa(authToken: 'abc', hashedPin: 'abc')).thenAnswer(
//              (_) async => Response(
//                  request: RequestOptions(path: ''), statusCode: 200, data: '''
//            {
//              "status": true,
//              "message": {
//                "secret": "xyz"
//              }
//            }
//            '''));

//          when(clipBoard.pasteFromClipBoard())
//              .thenAnswer((_) async => '123456');

//          return bloc;
//        },
//        act: (SecurityTfaBloc bloc) {
//          bloc..add(GenerateKey())..add(PasteCode());
//        },
//        expect: () => [
//              SecurityTfaState(generatingKey: true),
//              SecurityTfaState(keyGenerated: true, key: 'xyz'),
//              SecurityTfaState(keyGenerated: true, key: 'xyz', pin: '123456'),
//            ],
//        verify: (SecurityTfaBloc bloc) {
//          verify(storage.getItem(key: CacheKeys.token)).called(1);
//          verify(storage.getItem(key: CacheKeys.hashedPin)).called(1);
//          verify(clipBoard.pasteFromClipBoard()).called(1);
//          verify(authAPI.getTfa(authToken: 'abc', hashedPin: 'abc')).called(1);
//        });

//    blocTest(
//      'should verify code succesfully',
//      build: () {
//        when(authAPI.getTfa(authToken: 'abc', hashedPin: 'abc')).thenAnswer(
//            (_) async => Response(
//                request: RequestOptions(path: ''), statusCode: 200, data: '''
//            {
//              "status": true,
//              "message": {
//                "secret": "xyz"
//              }
//            }
//            '''));

//        when(authAPI.postTfa(
//                authToken: 'abc', hashedPin: 'abc', code: '123456'))
//            .thenAnswer((_) async => Response(
//                request: RequestOptions(path: ''), statusCode: 200, data: '''
//            {
//              "status": true,
//              "message": "Valid Token"
//            }
//            '''));

//        return bloc;
//      },
//      act: (SecurityTfaBloc bloc) {
//        bloc
//          ..add(GenerateKey())
//          ..add(TfaCodeChanged('123456'))
//          ..add(VerifyCode());
//      },
//      expect: () => [
//        SecurityTfaState(generatingKey: true),
//        SecurityTfaState(keyGenerated: true, key: 'xyz'),
//        SecurityTfaState(keyGenerated: true, key: 'xyz', pin: '123456'),
//        SecurityTfaState(
//            keyGenerated: true, key: 'xyz', pin: '123456', verifyingPin: true),
//        SecurityTfaState(
//            keyGenerated: true, key: 'xyz', pin: '123456', pinVerified: true),
//      ],
//      verify: (SecurityTfaBloc bloc) {
//        verify(storage.getItem(key: CacheKeys.token)).called(2);
//        verify(storage.getItem(key: CacheKeys.hashedPin)).called(2);
//        verify(authAPI.getTfa(authToken: 'abc', hashedPin: 'abc')).called(1);
//        verify(authAPI.postTfa(
//                authToken: 'abc', hashedPin: 'abc', code: '123456'))
//            .called(1);
//      },
//    );

//    blocTest(
//      'should show incorrect tfa code',
//      build: () {
//        when(authAPI.getTfa(authToken: 'abc', hashedPin: 'abc')).thenAnswer(
//            (_) async => Response(
//                request: RequestOptions(path: ''), statusCode: 200, data: '''
//            {
//              "status": true,
//              "message": {
//                "secret": "xyz"
//              }
//            }
//            '''));

//        when(authAPI.postTfa(
//                authToken: 'abc', hashedPin: 'abc', code: '123456'))
//            .thenAnswer((_) async =>
//                Response(request: RequestOptions(path: ''), statusCode: 403));

//        return bloc;
//      },
//      act: (SecurityTfaBloc bloc) {
//        bloc
//          ..add(GenerateKey())
//          ..add(TfaCodeChanged('123456'))
//          ..add(VerifyCode());
//      },
//      expect: () => [
//        SecurityTfaState(generatingKey: true),
//        SecurityTfaState(keyGenerated: true, key: 'xyz'),
//        SecurityTfaState(keyGenerated: true, key: 'xyz', pin: '123456'),
//        SecurityTfaState(
//            keyGenerated: true, key: 'xyz', pin: '123456', verifyingPin: true),
//        SecurityTfaState(
//            keyGenerated: true,
//            key: 'xyz',
//            pin: '',
//            pinError: 'Invalid Code. Try Again.'),
//      ],
//      verify: (SecurityTfaBloc bloc) {
//        verify(storage.getItem(key: CacheKeys.token)).called(2);
//        verify(storage.getItem(key: CacheKeys.hashedPin)).called(2);
//        verify(authAPI.getTfa(authToken: 'abc', hashedPin: 'abc')).called(1);
//        verify(authAPI.postTfa(
//                authToken: 'abc', hashedPin: 'abc', code: '123456'))
//            .called(1);
//      },
//    );

//    blocTest(
//      'should show error on tfa code verify',
//      build: () {
//        when(authAPI.getTfa(authToken: 'abc', hashedPin: 'abc')).thenAnswer(
//            (_) async => Response(
//                request: RequestOptions(path: ''), statusCode: 200, data: '''
//            {
//              "status": true,
//              "message": {
//                "secret": "xyz"
//              }
//            }
//            '''));

//        when(authAPI.postTfa(
//                authToken: 'abc', hashedPin: 'abc', code: '123456'))
//            .thenAnswer((_) async =>
//                Response(request: RequestOptions(path: ''), statusCode: 500));

//        return bloc;
//      },
//      act: (SecurityTfaBloc bloc) {
//        bloc
//          ..add(GenerateKey())
//          ..add(TfaCodeChanged('123456'))
//          ..add(VerifyCode());
//      },
//      expect: () => [
//        SecurityTfaState(generatingKey: true),
//        SecurityTfaState(keyGenerated: true, key: 'xyz'),
//        SecurityTfaState(keyGenerated: true, key: 'xyz', pin: '123456'),
//        SecurityTfaState(
//            keyGenerated: true, key: 'xyz', pin: '123456', verifyingPin: true),
//        SecurityTfaState(
//            keyGenerated: true,
//            key: 'xyz',
//            pin: '',
//            pinError: 'Error Occured. Please try again.'),
//      ],
//      verify: (SecurityTfaBloc bloc) {
//        verify(storage.getItem(key: CacheKeys.token)).called(2);
//        verify(storage.getItem(key: CacheKeys.hashedPin)).called(2);
//        verify(authAPI.getTfa(authToken: 'abc', hashedPin: 'abc')).called(1);
//        verify(authAPI.postTfa(
//                authToken: 'abc', hashedPin: 'abc', code: '123456'))
//            .called(1);
//      },
//    );
//  });
//}
