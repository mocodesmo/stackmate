////
//import 'package:sats/api/firebase.dart';
//import 'package:sats/pkg/storage.dart';
//import 'package:sats/view/email-login/bloc/bloc.dart';
//import 'package:test/test.dart';
//import 'package:bloc_test/bloc_test.dart';
//import 'package:mockito/mockito.dart';

//class _MockAuthGateway extends Mock implements IAuthGateway {}

//class _MockStorage extends Mock implements IStorage {}

//main() {
//  group('Email Bloc', () {
//    EmailBloc emailBloc;
//    IAuthGateway authGateway;
//    IStorage storage;

//    setUp(() {
//      authGateway = _MockAuthGateway();
//      storage = _MockStorage();
//      emailBloc = EmailBloc(
//        authGateway,
//        storage,
//      );
//    });

//    tearDown(() {
//      emailBloc.close();
//    });

//    test('initial state should be blank', () {
//      expect(emailBloc.state, EmailState());
//    });

//    blocTest('should update email while typing',
//        build: () => emailBloc,
//        act: (EmailBloc bloc) {
//          bloc.add(EmailChanged('mj@mj.mj'));
//          bloc.add(EmailChanged('abc'));
//          bloc.add(EmailChanged('xyz'));
//        },
//        expect: () => [
//              EmailState(email: 'mj@mj.mj'),
//              EmailState(email: 'abc'),
//              EmailState(email: 'xyz'),
//            ]);

//    blocTest('should check for incorrect email format when submitted',
//        build: () => emailBloc,
//        act: (EmailBloc bloc) {
//          bloc.add(EmailChanged('mj@@ee..'));
//          bloc.add(SendEmail());
//        },
//        expect: () => [
//              EmailState(email: 'mj@@ee..'),
//              EmailState(
//                email: 'mj@@ee..',
//                emailError: 'Please enter a valid email.',
//              )
//            ]);

//    blocTest(
//        'should send email to auth service and save email to storage service and show that email is sent',
//        build: () => emailBloc,
//        act: (EmailBloc bloc) {
//          bloc.add(EmailChanged('mj@mj.mj'));
//          bloc.add(SendEmail());
//        },
//        expect: () => [
//              EmailState(email: 'mj@mj.mj'),
//              EmailState(
//                email: 'mj@mj.mj',
//                sendingEmail: true,
//              ),
//              EmailState(
//                email: 'mj@mj.mj',
//                sendingEmail: false,
//                emailSent: true,
//              ),
//            ],
//        verify: (EmailBloc bloc) {
//          verify(
//            bloc.authGateway.signInWithEmailLink(email: 'mj@mj.mj'),
//          ).called(1);

//          verify(bloc.storage.saveOrUpdateItem(
//            key: CacheKeys.email,
//            value: 'mj@mj.mj',
//          )).called(1);
//        });

//    blocTest('should send email to auth service and get an error',
//        build: () {
//          when(emailBloc.authGateway.signInWithEmailLink(
//            email: 'mj@mj.mj',
//          )).thenThrow(Exception());

//          return emailBloc;
//        },
//        act: (EmailBloc bloc) {
//          bloc.add(EmailChanged('mj@mj.mj'));
//          bloc.add(SendEmail());
//        },
//        expect: () => [
//              EmailState(email: 'mj@mj.mj'),
//              EmailState(
//                email: 'mj@mj.mj',
//                sendingEmail: true,
//              ),
//              EmailState(
//                email: 'mj@mj.mj',
//                sendingEmail: false,
//                emailSent: false,
//                emailError: 'Something went wrong. Please try again later.',
//              ),
//            ],
//        verify: (EmailBloc bloc) {
//          verify(
//            bloc.authGateway.signInWithEmailLink(email: 'mj@mj.mj'),
//          ).called(1);
//        });

//    blocTest(
//        'should authenticate and save token to storage service when deep link is recieved',
//        build: () {
//          when(
//            emailBloc.authGateway
//                .signInAfterDeepLink(email: 'mj@mj.mj', link: 'abc.abc'),
//          ).thenAnswer((_) async => 'tok');

//          when(emailBloc.storage.getItem(key: CacheKeys.email))
//              .thenAnswer((_) async => 'mj@mj.mj');

//          return emailBloc;
//        },
//        act: (EmailBloc bloc) {
//          bloc.add(DeepLinkRecieved('abc.abc'));
//        },
//        expect: () => [
//              EmailState(),
//              EmailState(checkingLink: true),
//              EmailState(
//                checkingLink: false,
//                loggedIn: true,
//              )
//            ],
//        verify: (EmailBloc bloc) {
//          verify(bloc.storage
//                  .saveOrUpdateItem(key: CacheKeys.token, value: 'tok'))
//              .called(1);

//          verify(bloc.storage.getItem(key: CacheKeys.email)).called(1);

//          verify(
//            bloc.authGateway
//                .signInAfterDeepLink(email: 'mj@mj.mj', link: 'abc.abc'),
//          ).called(1);
//        });

//    blocTest('should show error when deep link is not accepted by auth service',
//        build: () {
//          when(emailBloc.authGateway.signInAfterDeepLink(
//            email: 'mj@mj.mj',
//            link: 'abc.abc',
//          )).thenThrow(Exception());

//          when(emailBloc.storage.getItem(key: CacheKeys.email)).thenAnswer(
//            (_) async => 'mj@mj.mj',
//          );

//          return emailBloc;
//        },
//        act: (EmailBloc bloc) {
//          bloc.add(DeepLinkRecieved('abc.abc'));
//        },
//        expect: () => [
//              EmailState(),
//              EmailState(checkingLink: true),
//              EmailState(
//                checkingLink: false,
//                loggedIn: false,
//                linkError: 'Invalid Link. Try sending the email again.',
//              )
//            ],
//        verify: (EmailBloc bloc) {
//          verify(bloc.storage.getItem(key: CacheKeys.email)).called(1);

//          verify(
//            bloc.authGateway
//                .signInAfterDeepLink(email: 'mj@mj.mj', link: 'abc.abc'),
//          ).called(1);
//        });

//    blocTest('Should reset bloc to initial state',
//        build: () => emailBloc,
//        act: (EmailBloc bloc) {
//          bloc.add(EmailChanged('mj@mj.mj'));
//          bloc.add(ResetEmailBloc());
//        },
//        expect: () => [
//              EmailState(email: 'mj@mj.mj'),
//              EmailState(),
//            ]);
//  });
//}
