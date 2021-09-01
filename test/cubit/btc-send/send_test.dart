////
//import 'package:dio/dio.dart';
//import 'package:sats/api/wallet.dart';
//import 'package:sats/pkg/storage.dart';
//import 'package:sats/cubit/btc-send/address.dart';
//import 'package:sats/cubit/btc-send/amount.dart';
//import 'package:sats/cubit/btc-send/send.dart';
//import 'package:sats/cubit/btc-send/tfa.dart';
//import 'package:test/test.dart';
//import 'package:bloc_test/bloc_test.dart';
//import 'package:mockito/mockito.dart';

//class _MockStorage extends Mock implements IStorage {}

//class _MockWalletAPI extends Mock implements IWalletAPI {}

//class _MockAddressBloc
//    extends MockBloc<BtcSendAddressEvent, BtcSendAddressState>
//    implements BtcSendAddressBloc {}

//class _MockAmountBloc extends MockBloc<BtcSendAmountEvent, BtcSendAmountState>
//    implements BtcSendAmountBloc {}

//class _MockTfaBloc extends MockBloc<BtcSendTfaEvent, BtcSendTfaState>
//    implements BtcSendTfaBloc {}

//main() {
//  group('BTC send - send bloc', () {
//    IStorage storage;
//    IWalletAPI walletAPI;
//    BtcSendAddressBloc addressBloc;
//    BtcSendAmountBloc amountBloc;
//    BtcSendTfaBloc tfaBloc;
//    BtcSendBloc bloc;

//    setUp(() {
//      storage = _MockStorage();
//      walletAPI = _MockWalletAPI();
//      addressBloc = _MockAddressBloc();
//      amountBloc = _MockAmountBloc();
//      tfaBloc = _MockTfaBloc();

//      bloc = BtcSendBloc(addressBloc, amountBloc, tfaBloc, storage, walletAPI);

//      when(storage.getItem(key: CacheKeys.token))
//          .thenAnswer((_) async => 'abc');

//      when(storage.getItem(key: CacheKeys.hashedPin))
//          .thenAnswer((_) async => 'abc');

//      when(tfaBloc.state).thenReturn(BtcSendTfaState());
//      when(amountBloc.state).thenReturn(BtcSendAmountState());
//      when(addressBloc.state).thenReturn(BtcSendAddressState());
//    });

//    tearDown(() {
//      bloc.close();
//      addressBloc.close();
//      amountBloc.close();
//      tfaBloc.close();
//    });

//    test('Initial state should be blank', () {
//      expect(bloc.state, BtcSendState());
//    });

//    blocTest('should update step when back clicked',
//        build: () {
//          return bloc;
//        },
//        seed: BtcSendState(step: BtcSendSteps.tfa),
//        act: (BtcSendBloc bloc) {
//          bloc..add(BackClicked())..add(BackClicked());
//        },
//        expect: () => [
//              BtcSendState(step: BtcSendSteps.amount),
//              BtcSendState(step: BtcSendSteps.address)
//            ]);

//    blocTest(
//      'should check address after first step',
//      build: () {
//        return bloc;
//      },
//      act: (BtcSendBloc bloc) {
//        bloc.add(NextClicked());
//      },
//      expect: () => [
//        BtcSendState(step: BtcSendSteps.amount),
//      ],
//      verify: (BtcSendBloc bloc) {
//        verify(addressBloc.add(CheckAddress()));
//        verify(amountBloc.add(FetchFee()));
//      },
//    );

//    blocTest(
//      'should check amount details after amount step',
//      build: () {
//        return bloc;
//      },
//      seed: BtcSendState(step: BtcSendSteps.amount),
//      act: (BtcSendBloc bloc) {
//        bloc.add(NextClicked());
//      },
//      expect: () => [
//        BtcSendState(step: BtcSendSteps.tfa),
//      ],
//      verify: (BtcSendBloc bloc) {
//        verify(amountBloc.add(CheckAmount()));
//      },
//    );

//    blocTest(
//      'should successfully send payment on last step',
//      build: () {
//        when(walletAPI.payment(
//                authToken: "abc",
//                hashedPin: "abc",
//                tfaCode: "",
//                accType: 'bitcoin',
//                address: "",
//                amount: 0.0,
//                fees: "normal",
//                comment: ""))
//            .thenAnswer((_) async =>
//                Response(request: RequestOptions(path: ''), statusCode: 200));

//        return bloc;
//      },
//      seed: BtcSendState(step: BtcSendSteps.tfa),
//      act: (BtcSendBloc bloc) {
//        bloc.add(NextClicked());
//      },
//      expect: () => [
//        BtcSendState(submitting: true, step: BtcSendSteps.tfa),
//        BtcSendState(submitted: true, step: BtcSendSteps.tfa),
//      ],
//      verify: (BtcSendBloc bloc) {
//        verify(tfaBloc.add(CheckTfaCode()));

//        verify(storage.getItem(key: CacheKeys.token)).called(1);
//        verify(storage.getItem(key: CacheKeys.hashedPin)).called(1);

//        verify(walletAPI.payment(
//                authToken: "abc",
//                hashedPin: "abc",
//                tfaCode: "",
//                accType: 'bitcoin',
//                address: "",
//                amount: 0.0,
//                fees: "normal",
//                comment: ""))
//            .called(1);
//      },
//    );

//    blocTest(
//      'should show tfa invalid error last step',
//      build: () {
//        when(walletAPI.payment(
//                authToken: "abc",
//                hashedPin: "abc",
//                tfaCode: "",
//                accType: 'bitcoin',
//                address: "",
//                amount: 0.0,
//                fees: "normal",
//                comment: ""))
//            .thenAnswer((_) async =>
//                Response(request: RequestOptions(path: ''), statusCode: 403));

//        return bloc;
//      },
//      seed: BtcSendState(step: BtcSendSteps.tfa),
//      act: (BtcSendBloc bloc) {
//        bloc.add(NextClicked());
//      },
//      expect: () => [
//        BtcSendState(submitting: true, step: BtcSendSteps.tfa),
//        BtcSendState(step: BtcSendSteps.tfa),
//      ],
//      verify: (BtcSendBloc bloc) {
//        verify(tfaBloc.add(CheckTfaCode())).called(1);
//        verify(tfaBloc.add(AddTfaError('Invalid 2FA Code'))).called(1);

//        verify(storage.getItem(key: CacheKeys.token)).called(1);
//        verify(storage.getItem(key: CacheKeys.hashedPin)).called(1);

//        verify(walletAPI.payment(
//                authToken: "abc",
//                hashedPin: "abc",
//                tfaCode: "",
//                accType: 'bitcoin',
//                address: "",
//                amount: 0.0,
//                fees: "normal",
//                comment: ""))
//            .called(1);
//      },
//    );

//    blocTest(
//      'should show error last step',
//      build: () {
//        when(walletAPI.payment(
//                authToken: "abc",
//                hashedPin: "abc",
//                tfaCode: "",
//                accType: 'bitcoin',
//                address: "",
//                amount: 0.0,
//                fees: "normal",
//                comment: ""))
//            .thenAnswer((_) async =>
//                Response(request: RequestOptions(path: ''), statusCode: 500));

//        return bloc;
//      },
//      seed: BtcSendState(step: BtcSendSteps.tfa),
//      act: (BtcSendBloc bloc) {
//        bloc.add(NextClicked());
//      },
//      expect: () => [
//        BtcSendState(submitting: true, step: BtcSendSteps.tfa),
//        BtcSendState(step: BtcSendSteps.tfa),
//      ],
//      verify: (BtcSendBloc bloc) {
//        verify(tfaBloc.add(CheckTfaCode()));
//        verify(tfaBloc.add(AddTfaError('Error Occured. Please try again')))
//            .called(1);

//        verify(storage.getItem(key: CacheKeys.token)).called(1);
//        verify(storage.getItem(key: CacheKeys.hashedPin)).called(1);
//        verify(walletAPI.payment(
//                authToken: "abc",
//                hashedPin: "abc",
//                tfaCode: "",
//                accType: 'bitcoin',
//                address: "",
//                amount: 0.0,
//                fees: "normal",
//                comment: ""))
//            .called(1);
//      },
//    );
//  });
//}
