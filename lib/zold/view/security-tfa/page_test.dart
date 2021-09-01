////

//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_test/flutter_test.dart';
//import 'package:sats/pkg/tester.dart';
//import 'package:sats/zold/view/security-tfa/cubit/cubit.dart';
//import 'package:bloc_test/bloc_test.dart';
//import 'package:mockito/mockito.dart';
//import 'package:sats/zold/view/security-tfa/page.dart';

//class MockSecurityTfaBloc extends MockBloc<SecurityTfaEvent, SecurityTfaState>
//    implements SecurityTfaBloc {}

//void main() {
//  setupDeviceSize();

//  group('Security TFA', () {
//    SecurityTfaBloc bloc;

//    setUp(() {
//      bloc = MockSecurityTfaBloc();
//    });

//    tearDown(() {
//      bloc.close();
//    });

//    testWidgets(
//      'should render setup tfa info properly',
//      (WidgetTester tester) async {
//        when(bloc.state).thenReturn(SecurityTfaState());

//        await tester.pumpWidget(BlocProvider.value(
//            value: bloc, child: MaterialApp(home: new SecurityTfaPage())));
//        await tester.pump();

//        expect(find.byKey(kSecurityTfaInfoHeader), findsOneWidget);
//        await tester.scrollUntilVisible(
//            find.byKey(kSecurityTfaGenerateButton), 50);
//        await tester.pump();

//        expect(find.byKey(kSecurityTfaGenerateButton), findsOneWidget);
//      },
//    );

//    testWidgets(
//      'should show generating private key',
//      (WidgetTester tester) async {
//        when(bloc.state).thenReturn(SecurityTfaState(generatingKey: true));

//        await tester.pumpWidget(BlocProvider.value(
//            value: bloc, child: MaterialApp(home: new SecurityTfaPage())));
//        await tester.pump();

//        await tester.scrollUntilVisible(
//            find.byKey(kSecurityTfaGeneratingLoader), 50);
//        await tester.pump();

//        expect(find.byKey(kSecurityTfaGeneratingLoader), findsOneWidget);
//      },
//    );

//    testWidgets(
//      'should show private key page',
//      (WidgetTester tester) async {
//        when(bloc.state)
//            .thenReturn(SecurityTfaState(key: 'abc', keyGenerated: true));

//        await tester.pumpWidget(BlocProvider.value(
//            value: bloc, child: MaterialApp(home: new SecurityTfaPage())));
//        await tester.pump();

//        expect(find.byKey(kSecurityTfaCopyHeader), findsOneWidget);
//        expect(find.byKey(kSecurityTfaShowKey), findsOneWidget);
//        expect(find.byKey(kSecurityTfaPinField), findsOneWidget);
//      },
//    );

//    testWidgets(
//      'should show verifying key',
//      (WidgetTester tester) async {
//        when(bloc.state).thenReturn(
//            SecurityTfaState(verifyingPin: true, keyGenerated: true));

//        await tester.pumpWidget(BlocProvider.value(
//            value: bloc, child: MaterialApp(home: new SecurityTfaPage())));
//        await tester.pump();

//        expect(find.byKey(kSecurityTfaVerifyLoader), findsOneWidget);
//      },
//    );
//  });
//}
