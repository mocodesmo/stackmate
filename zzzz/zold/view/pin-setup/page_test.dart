////

//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_test/flutter_test.dart';
//import 'package:bloc_test/bloc_test.dart';
//import 'package:mockito/mockito.dart';
//import 'package:sats/pkg/tester.dart';
//import 'package:sats/zold/view/pin-keyboard/bloc/bloc.dart';

//import 'package:sats/zold/view/pin-setup/bloc/bloc.dart';
//import 'package:sats/zold/view/pin-setup/page.dart';

//class MockPinSetupBloc extends MockBloc<PinSetupEvent, PinSetupState>
//    implements PinSetupBloc {}

//void main() {
//  setupDeviceSize();

//  group('Pin Setup', () {
//    PinSetupBloc pinSetupBloc;
//    PinKeyboardBloc keyboardBloc;

//    setUp(() {
//      keyboardBloc = PinKeyboardBloc();
//      pinSetupBloc = MockPinSetupBloc();
//    });

//    tearDown(() {
//      keyboardBloc.close();
//      pinSetupBloc.close();
//    });

//    testWidgets(
//      'should render enter pin',
//      (WidgetTester tester) async {
//        when(pinSetupBloc.state).thenReturn(PinSetupState());

//        await tester.pumpWidget(BlocProvider.value(
//            value: keyboardBloc,
//            child: BlocProvider.value(
//                value: pinSetupBloc,
//                child: MaterialApp(home: new PinSetupPage()))));
//        await tester.pump();

//        expect(find.byKey(kSetupPinTitle1), findsOneWidget);
//        expect(find.byKey(kSetupPinField1), findsOneWidget);
//        expect(find.byKey(kSetupPinButton1), findsOneWidget);
//        expect(find.byKey(kSetupPinKeyboard), findsOneWidget);
//      },
//    );

//    testWidgets(
//      'should render confirm pin on enter pin confirmed',
//      (WidgetTester tester) async {
//        when(pinSetupBloc.state).thenReturn(
//          PinSetupState(pinEntered: true, pin: 4, pinHash: 'abc'),
//        );

//        await tester.pumpWidget(BlocProvider.value(
//            value: keyboardBloc,
//            child: BlocProvider.value(
//                value: pinSetupBloc,
//                child: MaterialApp(home: new PinSetupPage()))));
//        await tester.pump();

//        expect(find.byKey(kSetupPinTitle2), findsOneWidget);
//        expect(find.byKey(kSetupPinField2), findsOneWidget);
//        expect(find.byKey(kSetupPinButton2), findsOneWidget);
//        expect(find.byKey(kSetupPinKeyboard), findsOneWidget);
//      },
//    );

//    testWidgets(
//      'should render confirming loader',
//      (WidgetTester tester) async {
//        when(pinSetupBloc.state).thenReturn(PinSetupState(
//            pinEntered: true, pin: 4, confirmPin: 4, savingPin: true));

//        await tester.pumpWidget(BlocProvider.value(
//            value: keyboardBloc,
//            child: BlocProvider.value(
//                value: pinSetupBloc,
//                child: MaterialApp(home: new PinSetupPage()))));
//        await tester.pump();

//        expect(find.byKey(kSetupPinTitle2), findsOneWidget);
//        expect(find.byKey(kSavingPinLoader), findsOneWidget);
//      },
//    );
//  });
//}
