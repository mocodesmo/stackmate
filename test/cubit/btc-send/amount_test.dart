////
//import 'package:dio/dio.dart';
//import 'package:sats/api/wallet.dart';
//import 'package:sats/model/btc-wallet.dart';
//import 'package:sats/model/fee.dart';
//import 'package:sats/model/wallet.dart';
//import 'package:sats/pkg/storage.dart';
//import 'package:sats/cubit/btc-send/amount.dart';
//import 'package:sats/cubit/btc-send/traffic.dart';
//import 'package:sats/view/common/wallet-bloc/bloc.dart';
//import 'package:test/test.dart';
//import 'package:bloc_test/bloc_test.dart';
//import 'package:mockito/mockito.dart';

//class _MockStorage extends Mock implements IStorage {}

//class _MockWalletAPI extends Mock implements IWalletAPI {}

//class _MockWalletBloc extends MockBloc<WalletEvent, WalletState>
//    implements WalletBloc {}

//class _MockTrafficBloc extends MockBloc<TrafficEvent, TrafficState>
//    implements TrafficBloc {}

//main() {
//  group('Btc send - Amount Bloc', () {
//    IStorage storage;
//    IWalletAPI walletAPI;
//    WalletBloc walletBloc;
//    TrafficBloc trafficBloc;
//    BtcSendAmountBloc bloc;

//    final fee = TrafficFee(
//        traffic: 'high', mempool: 3170, slowSats: 876, normalSats: 24000);

//    setUp(() {
//      storage = _MockStorage();
//      walletAPI = _MockWalletAPI();
//      walletBloc = _MockWalletBloc();
//      trafficBloc = _MockTrafficBloc();

//      bloc = BtcSendAmountBloc(walletBloc, trafficBloc, storage, walletAPI);

//      when(storage.getItem(key: CacheKeys.token))
//          .thenAnswer((_) async => 'abc');

//      when(walletAPI.getFees(authToken: 'abc')).thenAnswer((_) async =>
//          Response(request: RequestOptions(path: ''), statusCode: 200, data: '''
//        {
//          "status":true,
//          "message": {
//              "slow": 876,
//              "normal": 24000,
//              "traffic": "high",
//              "mempool_size": 3170
//          }
//        }
//        '''));
//    });

//    tearDown(() {
//      walletBloc.close();
//      trafficBloc.close();
//      bloc.close();
//    });

//    test('Initial state should be blank', () {
//      expect(bloc.state, BtcSendAmountState());
//    });

//    blocTest('should fetch fee',
//        build: () {
//          return bloc;
//        },
//        act: (BtcSendAmountBloc bloc) {
//          bloc.add(FetchFee());
//        },
//        expect: () => [
//              BtcSendAmountState(fetchingFee: true),
//              BtcSendAmountState(fee: fee),
//            ],
//        verify: (BtcSendAmountBloc bloc) {
//          verify(storage.getItem(key: CacheKeys.token)).called(1);
//          verify(walletAPI.getFees(authToken: 'abc')).called(1);
//          verify(trafficBloc.add(UpdateTraffic(fee)));
//        });

//    blocTest(
//      'show error while fetchig fee',
//      build: () {
//        when(walletAPI.getFees(authToken: 'abc')).thenAnswer((_) async =>
//            Response(request: RequestOptions(path: ''), statusCode: 500));

//        return bloc;
//      },
//      act: (BtcSendAmountBloc bloc) {
//        bloc.add(FetchFee());
//      },
//      expect: () => [
//        BtcSendAmountState(fetchingFee: true),
//        BtcSendAmountState(fetchFeeError: 'Error Occured. Please try again.'),
//      ],
//      verify: (BtcSendAmountBloc bloc) {
//        verify(storage.getItem(key: CacheKeys.token)).called(1);
//        verify(walletAPI.getFees(authToken: 'abc')).called(1);
//      },
//    );

//    blocTest('should pick % of amount',
//        build: () {
//          when(walletBloc.state).thenReturn(WalletState(
//              wallet: Wallet(
//                  btcWallet: BtcWallet(
//                      p2sh: '',
//                      p2pkh: '',
//                      bech32: '',
//                      created: 1,
//                      satsBalance: 100000))));

//          return bloc;
//        },
//        act: (BtcSendAmountBloc bloc) {
//          bloc..add(FetchFee())..add(PercentClicked(AmountPercent.fifty));
//        },
//        expect: () => [
//              BtcSendAmountState(fetchingFee: true),
//              BtcSendAmountState(fee: fee),
//              BtcSendAmountState(
//                fee: fee,
//                finalAmountD: 50000.0,
//                amountEnteredD: 50000.0 - fee.normalSats,
//                amountEntered: (50000.0 - fee.normalSats).toStringAsFixed(0),
//                amountEnteredSmall: ((50000.0 - fee.normalSats) / 100000000)
//                        .toStringAsFixed(8) +
//                    ' BTC',
//              )
//            ],
//        verify: (BtcSendAmountBloc bloc) {
//          verify(storage.getItem(key: CacheKeys.token)).called(1);
//          verify(walletAPI.getFees(authToken: 'abc')).called(1);
//          verify(trafficBloc.add(UpdateTraffic(fee)));
//        });

//    blocTest(
//      'show amount updated',
//      build: () {
//        return bloc;
//      },
//      act: (BtcSendAmountBloc bloc) {
//        bloc..add(FetchFee())..add(AmountEntered('50000'));
//      },
//      expect: () => [
//        BtcSendAmountState(fetchingFee: true),
//        BtcSendAmountState(fee: fee),
//        BtcSendAmountState(
//          fee: fee,
//          amountEntered: '50000',
//          amountEnteredD: 50000.0,
//          finalAmountD: 50000.0 + fee.normalSats,
//          percent: AmountPercent.none,
//          amountEnteredSmall: (50000 / 100000000).toStringAsFixed(8) + ' BTC',
//        )
//      ],
//      verify: (BtcSendAmountBloc bloc) {
//        verify(storage.getItem(key: CacheKeys.token)).called(1);
//        verify(walletAPI.getFees(authToken: 'abc')).called(1);
//        verify(trafficBloc.add(UpdateTraffic(fee)));
//      },
//    );

//    blocTest(
//      'should select fee and update amount',
//      build: () {
//        when(walletBloc.state).thenReturn(WalletState(
//            wallet: Wallet(
//                btcWallet: BtcWallet(
//                    p2sh: '',
//                    p2pkh: '',
//                    bech32: '',
//                    created: 1,
//                    satsBalance: 100000))));

//        return bloc;
//      },
//      act: (BtcSendAmountBloc bloc) {
//        bloc
//          ..add(FetchFee())
//          ..add(AmountEntered('50000'))
//          ..add(ChangeFee(Traffic.slow));
//      },
//      expect: () => [
//        BtcSendAmountState(fetchingFee: true),
//        BtcSendAmountState(fee: fee),
//        BtcSendAmountState(
//          fee: fee,
//          amountEntered: '50000',
//          amountEnteredD: 50000.0,
//          finalAmountD: 50000.0 + fee.normalSats,
//          percent: AmountPercent.none,
//          amountEnteredSmall: (50000 / 100000000).toStringAsFixed(8) + ' BTC',
//        ),
//        BtcSendAmountState(
//          fee: fee,
//          amountEntered: '50000',
//          amountEnteredD: 50000.0,
//          finalAmountD: 50000.0 + fee.slowSats,
//          percent: AmountPercent.none,
//          amountEnteredSmall: (50000 / 100000000).toStringAsFixed(8) + ' BTC',
//          feeSelected: Traffic.slow,
//        ),
//      ],
//      verify: (BtcSendAmountBloc bloc) {
//        verify(storage.getItem(key: CacheKeys.token)).called(1);
//        verify(walletAPI.getFees(authToken: 'abc')).called(1);
//        verify(trafficBloc.add(UpdateTraffic(fee)));
//      },
//    );

//    blocTest(
//      'should show valid amount entered',
//      build: () {
//        when(walletBloc.state).thenReturn(WalletState(
//            wallet: Wallet(
//                btcWallet: BtcWallet(
//                    p2sh: '',
//                    p2pkh: '',
//                    bech32: '',
//                    created: 1,
//                    satsBalance: 100000))));

//        return bloc;
//      },
//      act: (BtcSendAmountBloc bloc) {
//        bloc..add(FetchFee())..add(AmountEntered('50000'))..add(CheckAmount());
//      },
//      expect: () => [
//        BtcSendAmountState(fetchingFee: true),
//        BtcSendAmountState(fee: fee),
//        BtcSendAmountState(
//            fee: fee,
//            amountEntered: '50000',
//            amountEnteredD: 50000.0,
//            finalAmountD: 50000.0 + fee.normalSats,
//            percent: AmountPercent.none,
//            amountEnteredSmall: (50000 / 100000000).toStringAsFixed(8) + ' BTC')
//      ],
//      verify: (BtcSendAmountBloc bloc) {
//        verify(storage.getItem(key: CacheKeys.token)).called(1);
//        verify(walletAPI.getFees(authToken: 'abc')).called(1);
//        verify(trafficBloc.add(UpdateTraffic(fee)));
//      },
//    );

//    blocTest('should show invalid amount entered',
//        build: () {
//          when(walletBloc.state).thenReturn(WalletState(
//              wallet: Wallet(
//                  btcWallet: BtcWallet(
//                      p2sh: '',
//                      p2pkh: '',
//                      bech32: '',
//                      created: 1,
//                      satsBalance: 100000))));

//          return bloc;
//        },
//        act: (BtcSendAmountBloc bloc) {
//          bloc
//            ..add(FetchFee())
//            ..add(AmountEntered('500000'))
//            ..add(CheckAmount());
//        },
//        expect: () => [
//              BtcSendAmountState(fetchingFee: true),
//              BtcSendAmountState(fee: fee),
//              BtcSendAmountState(
//                  fee: fee,
//                  amountEntered: '500000',
//                  amountEnteredD: 500000.0,
//                  finalAmountD: 500000.0 + fee.normalSats,
//                  percent: AmountPercent.none,
//                  amountEnteredSmall:
//                      (500000 / 100000000).toStringAsFixed(8) + ' BTC'),
//              BtcSendAmountState(
//                  fee: fee,
//                  amountEntered: '500000',
//                  amountEnteredD: 500000.0,
//                  finalAmountD: 500000.0 + fee.normalSats,
//                  percent: AmountPercent.none,
//                  amountEnteredSmall:
//                      (500000 / 100000000).toStringAsFixed(8) + ' BTC',
//                  amountError: 'Please enter valid amount')
//            ],
//        verify: (BtcSendAmountBloc bloc) {
//          verify(storage.getItem(key: CacheKeys.token)).called(1);
//          verify(walletAPI.getFees(authToken: 'abc')).called(1);
//          verify(trafficBloc.add(UpdateTraffic(fee)));
//        });
//  });
//}
