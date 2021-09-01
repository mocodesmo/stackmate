////
//import 'package:sats/pkg/clipboard.dart';
//import 'package:sats/cubit/btc-send/address.dart';
//import 'package:test/test.dart';
//import 'package:bloc_test/bloc_test.dart';
//import 'package:mockito/mockito.dart';

//class _MockClipboard extends Mock implements IClipBoard {}

//main() {
//  group('Btc send - Address Bloc', () {
//    IClipBoard clipBoard;
//    BtcSendAddressBloc bloc;

//    const longAddress =
//        '11addressffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff';
//    const properAddress = '1F1tAaz5x1HUXrCNLbtMDqcw6o5GNn4xqX';
//    const longComment = 'commenttttttttttttttttttttttttttt';

//    setUp(() {
//      clipBoard = _MockClipboard();
//      bloc = BtcSendAddressBloc(clipBoard);
//    });

//    tearDown(() {
//      bloc.close();
//    });

//    test('Initial state should be blank', () {
//      expect(bloc.state, BtcSendAddressState());
//    });

//    blocTest('should open camera and close camera',
//        build: () => bloc,
//        act: (BtcSendAddressBloc bloc) {
//          bloc..add(ToggleCamera())..add(ToggleCamera());
//        },
//        expect: () =>
//            [BtcSendAddressState(cameraOpened: true), BtcSendAddressState()]);

//    blocTest('should paste address',
//        build: () {
//          when(clipBoard.pasteFromClipBoard()).thenAnswer((_) async => 'abc');
//          return bloc;
//        },
//        act: (BtcSendAddressBloc bloc) {
//          bloc..add(PasteAddress());
//        },
//        expect: () => [
//              BtcSendAddressState(address: 'abc'),
//            ],
//        verify: (BtcSendAddressBloc bloc) {
//          verify(clipBoard.pasteFromClipBoard()).called(1);
//        });

//    blocTest('should show error on incorrect address format',
//        build: () => bloc,
//        act: (BtcSendAddressBloc bloc) {
//          bloc..add(AddressChanged('address'))..add(CheckAddress());
//        },
//        expect: () => [
//              BtcSendAddressState(address: 'address'),
//              BtcSendAddressState(
//                  address: 'address', addressError: 'Invalid Wallet Address'),
//            ]);

//    blocTest('should show error on too long address',
//        build: () => bloc,
//        act: (BtcSendAddressBloc bloc) {
//          bloc..add(AddressChanged(longAddress))..add(CheckAddress());
//        },
//        expect: () => [
//              BtcSendAddressState(address: longAddress),
//              BtcSendAddressState(
//                  address: longAddress, addressError: 'Invalid Wallet Address'),
//            ]);

//    blocTest('should enter and verify address format',
//        build: () => bloc,
//        act: (BtcSendAddressBloc bloc) {
//          bloc..add(AddressChanged(properAddress))..add(CheckAddress());
//        },
//        expect: () => [BtcSendAddressState(address: properAddress)]);

//    blocTest('should add comment',
//        build: () => bloc,
//        act: (BtcSendAddressBloc bloc) {
//          bloc.add(CommentChanged('comment'));
//        },
//        expect: () => [
//              BtcSendAddressState(comment: 'comment'),
//            ]);

//    blocTest('should show error on comment to long',
//        build: () => bloc,
//        act: (BtcSendAddressBloc bloc) {
//          bloc
//            ..add(AddressChanged(properAddress))
//            ..add(CommentChanged(longComment))
//            ..add(CheckAddress());
//        },
//        expect: () => [
//              BtcSendAddressState(address: properAddress),
//              BtcSendAddressState(address: properAddress, comment: longComment),
//              BtcSendAddressState(
//                  address: properAddress,
//                  comment: longComment,
//                  commentError: 'Comment too long.')
//            ]);
//  });
//}
