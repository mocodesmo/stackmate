////
//import 'package:sats/view/pin-keyboard/bloc/bloc.dart';
//import 'package:test/test.dart';
//import 'package:bloc_test/bloc_test.dart';

//main() {
//  group('PinKeyboard Bloc', () {
//    PinKeyboardBloc bloc;

//    setUp(() {
//      bloc = PinKeyboardBloc();
//    });

//    tearDown(() {
//      bloc.close();
//    });

//    test('initial state should be blank', () {
//      expect(bloc.state, PinKeyboardState());
//    });

//    blocTest(
//      'should shuffle keys',
//      build: () => bloc,
//      act: (PinKeyboardBloc bloc) {
//        bloc.add(ShuffleKeys());
//      },
//      verify: (PinKeyboardBloc bloc) {
//        final state = PinKeyboardState();
//        expect(bloc.state.numberList, isNot(state.numberList));
//      },
//    );

//    blocTest('should add keys',
//        build: () => bloc,
//        act: (PinKeyboardBloc bloc) {
//          bloc
//            ..add(KeyPressed('1'))
//            ..add(KeyPressed('2'))
//            ..add(KeyPressed('3'))
//            ..add(KeyPressed('4'));
//        },
//        expect: () => [
//              PinKeyboardState(numbersEntered: ['1']),
//              PinKeyboardState(numbersEntered: ['1', '2']),
//              PinKeyboardState(numbersEntered: ['1', '2', '3']),
//              PinKeyboardState(numbersEntered: ['1', '2', '3', '4']),
//            ]);

//    blocTest('should add max 4 keys',
//        build: () => bloc,
//        act: (PinKeyboardBloc bloc) {
//          bloc
//            ..add(KeyPressed('1'))
//            ..add(KeyPressed('2'))
//            ..add(KeyPressed('3'))
//            ..add(KeyPressed('4'))
//            ..add(KeyPressed('1'))
//            ..add(KeyPressed('2'));
//        },
//        expect: () => [
//              PinKeyboardState(numbersEntered: ['1']),
//              PinKeyboardState(numbersEntered: ['1', '2']),
//              PinKeyboardState(numbersEntered: ['1', '2', '3']),
//              PinKeyboardState(numbersEntered: ['1', '2', '3', '4']),
//            ]);

//    blocTest('should clear entered keys',
//        build: () => bloc,
//        act: (PinKeyboardBloc bloc) {
//          bloc
//            ..add(KeyPressed('1'))
//            ..add(KeyPressed('2'))
//            ..add(KeyPressed('3'))
//            ..add(KeyPressed('4'))
//            ..add(ClearKeys());
//        },
//        expect: () => [
//              PinKeyboardState(numbersEntered: ['1']),
//              PinKeyboardState(numbersEntered: ['1', '2']),
//              PinKeyboardState(numbersEntered: ['1', '2', '3']),
//              PinKeyboardState(numbersEntered: ['1', '2', '3', '4']),
//              PinKeyboardState(numbersEntered: []),
//            ]);
//  });
//}
