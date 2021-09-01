//import 'package:sats/pkg/storage.dart';
//import 'package:sats/view/authentication/_authentication.dart';
//import 'package:test/test.dart';
//import 'package:mockito/mockito.dart';
//import 'package:bloc_test/bloc_test.dart';

//class MockStorage extends Mock implements IStorage {}

//main() {
//  group('Auth Bloc', () {
//    IStorage storage;
//    AuthBloc authBloc;

//    setUp(() {
//      storage = MockStorage();
//      authBloc = AuthBloc(storage: storage);
//    });

//    tearDown(() {
//      authBloc.close();
//    });

//    test('initial state should be phone auth', () {
//      expect(authBloc.state, AuthState(loginType: LoginType.phone));
//    });

//    blocTest('should update to email auth',
//        build: () => authBloc,
//        act: (AuthBloc bloc) {
//          bloc.add(ChangeLoginType(LoginType.email));
//        },
//        expect: [
//          AuthState(loginType: LoginType.email),
//        ]);

//    blocTest('should update to authenticated when authentication completed',
//        build: () => authBloc,
//        act: (AuthBloc bloc) {
//          bloc.add(AuthCompleted());
//        },
//        expect: [
//          AuthState(loggedIn: true),
//        ]);

//    blocTest(
//      'should update to not logged in on log outand clear token from storage service',
//      build: () => authBloc,
//      act: (AuthBloc bloc) {
//        bloc.add(AuthCompleted());
//        bloc.add(LogOut());
//      },
//      expect: [
//        AuthState(loggedIn: true),
//        AuthState(loggedIn: false),
//      ],
//      verify: (AuthBloc bloc) {
//        verify(bloc.storage.deleteItem(
//          key: CacheKeys.token,
//        )).called(1);
//      },
//    );

//    blocTest(
//      'should reset all state',
//      build: () => authBloc,
//      act: (AuthBloc bloc) {
//        bloc.add(AuthCompleted());
//        bloc.add(ResetAuthBloc());
//      },
//      expect: [
//        AuthState(loggedIn: true),
//        AuthState(),
//      ],
//    );
//  });
//}
