////

//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_test/flutter_test.dart';
//import 'package:sats/pkg/tester.dart';
//import 'package:sats/zold/view/email-login/bloc/bloc.dart';
//import 'package:sats/zold/view/email-login/page.dart';
//import 'package:bloc_test/bloc_test.dart';
//import 'package:mockito/mockito.dart';

//class MockEmailBloc extends MockBloc<EmailEvent, EmailState>
//    implements EmailBloc {}

//void main() {
//  setupDeviceSize();

//  group('Email Login', () {
//    EmailBloc emailBloc;
//    setUp(() {
//      emailBloc = MockEmailBloc();
//    });

//    tearDown(() {
//      emailBloc.close();
//    });

//    testWidgets('should render enter email properly',
//        (WidgetTester tester) async {
//      when(emailBloc.state).thenReturn(EmailState());

//      await tester.pumpWidget(
//        BlocProvider.value(
//            value: emailBloc,
//            child: MaterialApp(
//              home: new EmailLoginPage(),
//            )),
//      );
//      await tester.pump();

//      expect(find.byKey(kSendEmailTitle), findsOneWidget);
//      expect(find.byKey(kEmailField), findsOneWidget);
//      expect(find.byKey(kSendOtpButton), findsOneWidget);
//    });

//    testWidgets('should show loading when email sending',
//        (WidgetTester tester) async {
//      when(emailBloc.state)
//          .thenReturn(EmailState(sendingEmail: true, email: 'mj@mj.mj'));

//      await tester.pumpWidget(
//        BlocProvider.value(
//            value: emailBloc,
//            child: MaterialApp(
//              home: new EmailLoginPage(),
//            )),
//      );
//      await tester.pump();

//      expect(find.byKey(kSendingLoader), findsOneWidget);
//    });

//    testWidgets('should show email sent after link sent',
//        (WidgetTester tester) async {
//      when(emailBloc.state)
//          .thenReturn(EmailState(emailSent: true, email: 'mj@mj.mj'));

//      await tester.pumpWidget(
//        BlocProvider.value(
//            value: emailBloc,
//            child: MaterialApp(
//              home: new EmailLoginPage(),
//            )),
//      );
//      await tester.pump();

//      expect(find.byKey(kLinkSentText), findsOneWidget);
//      expect(find.byKey(kOpenEmailButton), findsOneWidget);
//    });

//    testWidgets('should show verifying when link is being verified',
//        (WidgetTester tester) async {
//      when(emailBloc.state)
//          .thenReturn(EmailState(checkingLink: true, email: 'mj@mj.mj'));

//      await tester.pumpWidget(BlocProvider.value(
//          value: emailBloc,
//          child: MaterialApp(
//            home: new EmailLoginPage(),
//          )));
//      await tester.pump();

//      expect(find.byKey(kVerifyingLoader), findsOneWidget);
//    });
//  });
//}
