////
//import 'package:bloc_test/bloc_test.dart';
//import 'package:dio/dio.dart';
//import 'package:sats/api/firebase.dart';
//import 'package:sats/api/profile.dart';
//import 'package:sats/model/user.dart';
//import 'package:sats/pkg/storage.dart';
//import 'package:sats/view/common/user-bloc/bloc.dart';
//import 'package:mockito/mockito.dart';
//import 'package:test/test.dart';

//class _MockStorage extends Mock implements IStorage {}

//class _MockProfileApi extends Mock implements IProfileAPI {}

//class _MockAuthGateway extends Mock implements IAuthGateway {}

//main() {
//  group('User Bloc', () {
//    UserBloc bloc;
//    IProfileAPI profileAPI;
//    IAuthGateway authGateway;
//    IStorage storage;

//    final user = User(
//      email: 'mj@mj.mj',
//      locked: false,
//      pinStatus: false,
//      tfaStatus: false,
//    );

//    setUp(() {
//      profileAPI = _MockProfileApi();
//      storage = _MockStorage();
//      authGateway = _MockAuthGateway();

//      bloc = UserBloc(profileAPI, storage, authGateway);
//    });

//    tearDown(() {
//      bloc.close();
//    });

//    test('initial state should be blank', () {
//      expect(bloc.state, UserState());
//    });

//    blocTest(
//      'Should update to authenticated',
//      build: () {
//        return bloc;
//      },
//      act: (UserBloc bloc) {
//        bloc.add(AuthCompleted());
//      },
//      expect: () => [
//        UserState(authenticated: true),
//      ],
//    );

//    blocTest('Should call refreshuser and get user details',
//        build: () {
//          when(authGateway.refreshUser()).thenAnswer((_) async => 'xyz');

//          when(storage.getItem(key: CacheKeys.token))
//              .thenAnswer((_) async => 'abc');

//          when(profileAPI.getProfile(authToken: 'abc')).thenAnswer((_) async =>
//              Response(
//                  request: RequestOptions(path: ''), statusCode: 200, data: '''
//              {
//                "status": true,
//                "message": {
//                  "email": "mj@mj.mj",
//                  "tfa": false,
//                  "pin": false,
//                  "locked": false
//                }
//              }
//              '''));
//          return bloc;
//        },
//        act: (UserBloc bloc) {
//          bloc..add(AuthCompleted())..add(GetUser());
//        },
//        expect: () => [
//              UserState(authenticated: true),
//              UserState(authenticated: true, gettingUser: true),
//              UserState(authenticated: true, user: user),
//            ],
//        verify: (UserBloc bloc) {
//          verify(storage.getItem(key: CacheKeys.token)).called(1);
//          verify(storage.saveOrUpdateItem(key: CacheKeys.token, value: 'xyz'))
//              .called(1);
//          verify(authGateway.refreshUser()).called(1);
//        });

//    blocTest('Should log out if 403',
//        build: () {
//          when(authGateway.refreshUser()).thenAnswer((_) async => 'xyz');

//          when(storage.getItem(key: CacheKeys.token))
//              .thenAnswer((_) async => 'abc');

//          when(profileAPI.getProfile(authToken: 'abc')).thenAnswer((_) async =>
//              Response(request: RequestOptions(path: ''), statusCode: 403));
//          return bloc;
//        },
//        act: (UserBloc bloc) {
//          bloc..add(AuthCompleted())..add(GetUser());
//        },
//        expect: () => [
//              UserState(authenticated: true),
//              UserState(authenticated: true, gettingUser: true),
//              UserState(),
//            ],
//        verify: (UserBloc bloc) {
//          verify(storage.getItem(key: CacheKeys.token)).called(1);
//          verify(storage.saveOrUpdateItem(key: CacheKeys.token, value: 'xyz'))
//              .called(1);

//          verify(storage.deleteItem(key: CacheKeys.token)).called(1);
//          verify(storage.deleteItem(key: CacheKeys.hashedPin)).called(1);
//          verify(storage.deleteItem(key: CacheKeys.email)).called(1);

//          verify(authGateway.signOutt()).called(1);
//        });

//    blocTest('Should show error if unknown error occured on getprofile',
//        build: () {
//          when(authGateway.refreshUser()).thenAnswer((_) async => 'xyz');

//          when(storage.getItem(key: CacheKeys.token))
//              .thenAnswer((_) async => 'abc');

//          when(profileAPI.getProfile(authToken: 'abc')).thenAnswer((_) async =>
//              Response(request: RequestOptions(path: ''), statusCode: 500));

//          return bloc;
//        },
//        act: (UserBloc bloc) {
//          bloc..add(AuthCompleted())..add(GetUser());
//        },
//        expect: () => [
//              UserState(authenticated: true),
//              UserState(authenticated: true, gettingUser: true),
//              UserState(
//                  authenticated: true,
//                  errorOnGet: 'Error Occured. Please try again.')
//            ],
//        verify: (UserBloc bloc) {
//          verify(storage.getItem(key: CacheKeys.token)).called(1);
//          verify(storage.saveOrUpdateItem(key: CacheKeys.token, value: 'xyz'))
//              .called(1);
//          verify(authGateway.refreshUser()).called(1);
//        });

//    blocTest('should remove all storage and auth if log out called',
//        build: () {
//          return bloc;
//        },
//        act: (UserBloc bloc) {
//          bloc..add(AuthCompleted())..add(LogOut());
//        },
//        expect: () => [
//              UserState(authenticated: true),
//              UserState(),
//            ],
//        verify: (UserBloc bloc) {
//          verify(storage.deleteItem(key: CacheKeys.token)).called(1);
//          verify(storage.deleteItem(key: CacheKeys.hashedPin)).called(1);
//          verify(storage.deleteItem(key: CacheKeys.email)).called(1);

//          verify(authGateway.signOutt()).called(1);
//        });
//  });
//}
