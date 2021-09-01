////
//import 'package:dio/dio.dart';
//import 'package:sats/api/wallet.dart';
//import 'package:sats/model/fee.dart';
//import 'package:sats/pkg/storage.dart';
//import 'package:sats/cubit/btc-send/traffic.dart';
//import 'package:test/test.dart';
//import 'package:bloc_test/bloc_test.dart';
//import 'package:mockito/mockito.dart';

//class _MockStorage extends Mock implements IStorage {}

//class _MockWalletAPI extends Mock implements IWalletAPI {}

//main() {
//  group('Btc send - traffic bloc', () {
//    IWalletAPI walletAPI;
//    IStorage storage;
//    TrafficBloc bloc;

//    final fee = TrafficFee(
//        traffic: 'high', mempool: 3170, slowSats: 876, normalSats: 24000);

//    setUp(() {
//      walletAPI = _MockWalletAPI();
//      storage = _MockStorage();
//      bloc = TrafficBloc(storage, walletAPI);
//    });

//    tearDown(() {
//      bloc.close();
//    });

//    test('Initial state should be blank', () {
//      expect(bloc.state, TrafficState());
//    });

//    blocTest('should fetch traffic details',
//        build: () {
//          when(storage.getItem(key: CacheKeys.token))
//              .thenAnswer((_) async => 'abc');

//          when(walletAPI.getFees(authToken: 'abc')).thenAnswer((_) async =>
//              Response(
//                  request: RequestOptions(path: ''), statusCode: 200, data: '''
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
//          return bloc;
//        },
//        act: (TrafficBloc bloc) {
//          bloc.add(FetchTraffic());
//        },
//        expect: () => [
//              TrafficState(loading: true),
//              TrafficState(fee: fee),
//            ],
//        verify: (TrafficBloc bloc) {
//          verify(storage.getItem(key: CacheKeys.token)).called(1);
//          verify(walletAPI.getFees(authToken: 'abc')).called(1);
//        });

//    blocTest('should show error',
//        build: () {
//          when(storage.getItem(key: CacheKeys.token))
//              .thenAnswer((_) async => 'abc');

//          when(walletAPI.getFees(authToken: 'abc')).thenAnswer((_) async =>
//              Response(request: RequestOptions(path: ''), statusCode: 500));

//          return bloc;
//        },
//        act: (TrafficBloc bloc) {
//          bloc.add(FetchTraffic());
//        },
//        expect: () => [
//              TrafficState(loading: true),
//              TrafficState(error: 'Error Occured. Please try again.'),
//            ],
//        verify: (TrafficBloc bloc) {
//          verify(storage.getItem(key: CacheKeys.token)).called(1);
//          verify(walletAPI.getFees(authToken: 'abc')).called(1);
//        });

//    blocTest('should update traffic details',
//        build: () => bloc,
//        act: (TrafficBloc bloc) {
//          bloc.add(UpdateTraffic(fee));
//        },
//        expect: () => [
//              TrafficState(fee: fee),
//            ]);
//  });
//}
