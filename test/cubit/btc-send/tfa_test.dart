////
//import 'package:sats/pkg/clipboard.dart';
//import 'package:sats/cubit/btc-send/tfa.dart';
//import 'package:test/test.dart';
//import 'package:bloc_test/bloc_test.dart';
//import 'package:mockito/mockito.dart';

//class _MockClipboard extends Mock implements IClipBoard {}

//main() {
//  group('Btc send - tfa bloc', () {
//    IClipBoard clipboard;
//    BtcSendTfaBloc bloc;
//    setUp(() {
//      clipboard = _MockClipboard();
//      bloc = BtcSendTfaBloc(clipboard);
//    });

//    tearDown(() {
//      bloc.close();
//    });

//    test('Initial state should be blank', () {
//      expect(bloc.state, BtcSendTfaState());
//    });

//    blocTest('should paste tfa code',
//        build: () {
//          when(clipboard.pasteFromClipBoard())
//              .thenAnswer((_) async => '123456');
//          return bloc;
//        },
//        act: (BtcSendTfaBloc bloc) {
//          bloc.add(PasteClicked());
//        },
//        expect: () => [
//              BtcSendTfaState(code: '123456'),
//            ],
//        verify: (BtcSendTfaBloc bloc) {
//          verify(clipboard.pasteFromClipBoard()).called(1);
//        });

//    blocTest('should enter tfa code',
//        build: () => bloc,
//        act: (BtcSendTfaBloc bloc) {
//          bloc.add(TfaCodeChanged('123456'));
//        },
//        expect: () => [
//              BtcSendTfaState(code: '123456'),
//            ]);

//    blocTest('should enter invalid tfa code',
//        build: () => bloc,
//        act: (BtcSendTfaBloc bloc) {
//          bloc..add(TfaCodeChanged('123'))..add(CheckTfaCode());
//        },
//        expect: () => [
//              BtcSendTfaState(code: '123'),
//              BtcSendTfaState(code: '123', error: 'Enter valid 2-FA code'),
//            ]);

//    //blocTest(
//    //  'should succesfully verify tfa code',
//    //  build: () => null,
//    //  act: (cubit) {},
//    //  expect:()=> [],
//    //  verify: (cubit) {},
//    //);
//    //blocTest(
//    //  'should show invalid tfa code',
//    //  build: () => null,
//    //  act: (cubit) {},
//    //  expect:()=> [],
//    //  verify: (cubit) {},
//    //);
//    //blocTest(
//    //  'should show error while verifying',
//    //  build: () => null,
//    //  act: (cubit) {},
//    //  expect:()=> [],
//    //  verify: (cubit) {},
//    //);
//  });
//}
