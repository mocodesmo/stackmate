////
//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_test/flutter_test.dart';
//import 'package:bloc_test/bloc_test.dart';
//import 'package:mockito/mockito.dart';
//import 'package:sats/pkg/tester.dart';
//import 'package:sats/zold/view/pin-keyboard/bloc/bloc.dart';

//import 'package:sats/zold/view/pin-login/bloc/bloc.dart';
//import 'package:sats/zold/view/pin-login/page.dart';

//class MockPinLoginBloc extends MockBloc<PinLoginEvent, PinLoginState>
//    implements PinLoginBloc {}

//void main() {
//  setupDeviceSize();

//  group('Pin Login', () {
//    PinLoginBloc pinLoginBloc;
//    PinKeyboardBloc keyboardBloc;

//    setUp(() {
//      keyboardBloc = PinKeyboardBloc();
//      pinLoginBloc = MockPinLoginBloc();
//    });

//    tearDown(() {
//      keyboardBloc.close();
//      pinLoginBloc.close();
//    });

//    testWidgets('should render enter pin', (WidgetTester tester) async {
//      when(pinLoginBloc.state).thenReturn(PinLoginState());

//      await tester.pumpWidget(BlocProvider.value(
//          value: keyboardBloc,
//          child: BlocProvider.value(
//              value: pinLoginBloc,
//              child: MaterialApp(home: new PinLoginPage()))));
//      await tester.pump();

//      expect(find.byKey(kPinLoginTitle), findsOneWidget);
//      expect(find.byKey(kPinLoginPinField), findsOneWidget);
//      expect(find.byKey(kPinLoginButton), findsOneWidget);
//      expect(find.byKey(kPinLoginKeyboard), findsOneWidget);
//    });

//    testWidgets('should render confirm pin loader',
//        (WidgetTester tester) async {
//      when(pinLoginBloc.state).thenReturn(PinLoginState(
//        pin: 4,
//        confirmingPin: true,
//      ));

//      await tester.pumpWidget(BlocProvider.value(
//          value: keyboardBloc,
//          child: BlocProvider.value(
//              value: pinLoginBloc,
//              child: MaterialApp(home: new PinLoginPage()))));
//      await tester.pump();

//      expect(find.byKey(kPinLoginCheckingPinLoader), findsOneWidget);
//      expect(find.byKey(kPinLoginKeyboard), findsOneWidget);
//    });

//    testWidgets('should render failed pin with retries count',
//        (WidgetTester tester) async {
//      when(pinLoginBloc.state).thenReturn(
//          PinLoginState(error: 'Incorrect Pin Entered.', retryCount: 2));

//      await tester.pumpWidget(BlocProvider.value(
//          value: keyboardBloc,
//          child: BlocProvider.value(
//              value: pinLoginBloc,
//              child: MaterialApp(home: new PinLoginPage()))));
//      await tester.pump();

//      expect(find.byKey(kPinLoginShowError), findsOneWidget);
//    });

//    testWidgets('should render account locked', (WidgetTester tester) async {
//      when(pinLoginBloc.state).thenReturn(
//        PinLoginState(retryCount: 0),
//      );

//      await tester.pumpWidget(BlocProvider.value(
//          value: keyboardBloc,
//          child: BlocProvider.value(
//              value: pinLoginBloc,
//              child: MaterialApp(home: new PinLoginPage()))));
//      await tester.pump();

//      expect(find.byKey(kPinLoginAccountLocked), findsOneWidget);
//    });
//  });
//}
