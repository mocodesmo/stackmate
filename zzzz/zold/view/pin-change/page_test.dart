////

//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_test/flutter_test.dart';
//import 'package:bloc_test/bloc_test.dart';
//import 'package:mockito/mockito.dart';
//import 'package:sats/pkg/tester.dart';
//import 'package:sats/zold/view/pin-change/bloc/bloc.dart';
//import 'package:sats/zold/view/pin-change/page.dart';

//class MockPinChangeBloc extends MockBloc<PinChangeEvent, PinChangeState>
//    implements PinChangeBloc {}

//void main() {
//  setupDeviceSize();

//  group('Pin Change', () {
//    PinChangeBloc bloc;

//    setUp(() {
//      bloc = MockPinChangeBloc();
//    });

//    tearDown(() {
//      bloc.close();
//    });

//    testWidgets('should show enter current pin', (WidgetTester tester) async {
//      when(bloc.state).thenReturn(PinChangeState());

//      await tester.pumpWidget(
//        BlocProvider.value(
//            value: bloc,
//            child: MaterialApp(
//              home: new PinChangePage(),
//            )),
//      );
//      await tester.pump();

//      expect(find.byKey(kPinChangeCurrentPinHeader), findsOneWidget);
//      expect(find.byKey(kPinChangeCurrentPinField), findsOneWidget);
//      expect(find.byKey(kPinChangeCurrentPinButton), findsOneWidget);
//      expect(find.byKey(kPinChangeCurrentPinKeyboard), findsOneWidget);
//    });

//    testWidgets('should show verifying pin', (WidgetTester tester) async {
//      when(bloc.state).thenReturn(PinChangeState(checkingCurrentPin: true));

//      await tester.pumpWidget(
//        BlocProvider.value(
//            value: bloc,
//            child: MaterialApp(
//              home: new PinChangePage(),
//            )),
//      );
//      await tester.pump();

//      expect(find.byKey(kPinChangeVerifyingLoader), findsOneWidget);
//    });

//    testWidgets('should show enter new pin', (WidgetTester tester) async {
//      when(bloc.state).thenReturn(PinChangeState(currentPinChecked: true));

//      await tester.pumpWidget(
//        BlocProvider.value(
//            value: bloc,
//            child: MaterialApp(
//              home: new PinChangePage(),
//            )),
//      );
//      await tester.pump();

//      expect(find.byKey(kPinChangeNewPinHeader), findsOneWidget);
//      expect(find.byKey(kPinChangeNewPinField), findsOneWidget);
//      expect(find.byKey(kPinChangeNewPinButton), findsOneWidget);
//      expect(find.byKey(kPinChangeNewPinKeyboard), findsOneWidget);
//    });

//    testWidgets('should show confirm new pin', (WidgetTester tester) async {
//      when(bloc.state).thenReturn(
//          PinChangeState(currentPinChecked: true, newPinComplete: true));

//      await tester.pumpWidget(
//        BlocProvider.value(
//            value: bloc,
//            child: MaterialApp(
//              home: new PinChangePage(),
//            )),
//      );
//      await tester.pump();

//      expect(find.byKey(kPinChangeConfirmPinHeader), findsOneWidget);
//      expect(find.byKey(kPinChangeConfirmPinField), findsOneWidget);
//      expect(find.byKey(kPinChangeConfirmPinButton), findsOneWidget);
//      expect(find.byKey(kPinChangeConfirmPinKeyboard), findsOneWidget);
//    });
//    testWidgets('should show saving new pin', (WidgetTester tester) async {
//      when(bloc.state).thenReturn(PinChangeState(
//        currentPinChecked: true,
//        newPinComplete: true,
//        savingNewPin: true,
//      ));

//      await tester.pumpWidget(
//        BlocProvider.value(
//            value: bloc,
//            child: MaterialApp(
//              home: new PinChangePage(),
//            )),
//      );
//      await tester.pump();

//      expect(find.byKey(kPinChangeSavingPinLoader), findsOneWidget);
//    });
//  });
//}
