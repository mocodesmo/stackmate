////

//import 'package:sats/cubit/bloc.dart';
//import 'package:test/test.dart';
//import 'package:bloc_test/bloc_test.dart';

//main() {
//  group('Calculator Bloc', () {
//    CalculatorBloc bloc;

//    setUp(() {
//      bloc = CalculatorBloc();
//    });

//    tearDown(() {
//      bloc.close();
//    });

//    test('initial state should be blank', () {
//      expect(bloc.state, CalculatorState());
//    });

//    blocTest('should add numbers',
//        build: () => bloc,
//        act: (CalculatorBloc bloc) {
//          bloc
//            ..add(UpdateCurrentValue('(1+2) - (5*5)'))
//            ..add(CalcKeyPressed('='));
//        },
//        expect: () => [
//              CalculatorState(currentExpression: '(1+2) - (5*5)'),
//              CalculatorState(currentExpression: '-22')
//            ]);
//  });
//}
