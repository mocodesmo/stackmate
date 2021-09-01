////

//import 'dart:convert';

//import 'package:sats/api/exchange.dart';
//import 'package:sats/model/rate.dart';
//import 'package:sats/pkg/storage.dart';
//import 'package:sats/view/common/rates-bloc/bloc.dart';
//import 'package:sats/view/common/rates-bloc/state.dart';
//import 'package:test/test.dart';
//import 'package:bloc_test/bloc_test.dart';
//import 'package:dio/dio.dart';
//import 'package:mockito/mockito.dart';

//class _MockStorage extends Mock implements IStorage {}

//class _MockExchangeAPI extends Mock implements IExchangeAPI {}

//main() {
//  group('Rates Bloc', () {
//    RatesBloc bloc;
//    IExchangeAPI exchangeAPI;
//    IStorage storage;

//    List<Rate> rates = [];
//    final data = jsonDecode(_rates);
//    for (var rate in data['message']) rates.add(Rate.fromJson(rate));

//    setUp(() {
//      exchangeAPI = _MockExchangeAPI();
//      storage = _MockStorage();

//      bloc = RatesBloc(storage, exchangeAPI);
//    });

//    tearDown(() {
//      bloc.close();
//    });

//    test('initial state should  be  blank', () {
//      expect(bloc.state, RatesState());
//    });

//    blocTest('Should get unknown error on getrates',
//        build: () {
//          when(storage.getItem(key: CacheKeys.token))
//              .thenAnswer((_) async => 'abc');

//          when(exchangeAPI.getRates(authToken: 'abc')).thenAnswer((_) async =>
//              Response(request: RequestOptions(path: ''), statusCode: 500));
//          return bloc;
//        },
//        act: (RatesBloc bloc) {
//          bloc.add(GetRates());
//        },
//        expect: () => [
//              RatesState(loadingRates: true),
//              RatesState(ratesError: 'Error Occured. Please try again.'),
//            ],
//        verify: (RatesBloc bloc) {
//          verify(storage.getItem(key: CacheKeys.token)).called(1);
//          verify(exchangeAPI.getRates(authToken: 'abc')).called(1);
//        });

//    blocTest('should get rates successfully',
//        build: () {
//          when(storage.getItem(key: CacheKeys.token))
//              .thenAnswer((_) async => 'abc');

//          when(exchangeAPI.getRates(authToken: 'abc')).thenAnswer((_) async =>
//              Response(
//                  request: RequestOptions(path: ''),
//                  statusCode: 200,
//                  data: _rates);

//          return bloc;
//        },
//        act: (RatesBloc bloc) {
//          bloc.add(GetRates());
//        },
//        expect: () => [
//              RatesState(loadingRates: true),
//              RatesState(rates: rates),
//            ],
//        verify: (RatesBloc bloc) {
//          verify(storage.getItem(key: CacheKeys.token)).called(1);
//          verify(exchangeAPI.getRates(authToken: 'abc')).called(1);
//        });
//  });
//}

//const _rates = '''
//{
//  "status": true,
//  "message": [  ]
//}
//''';

////{
////  "name": "Euro",
////  "symbol": "EUR",
////  "rate": 15931.3
////},
////{
////  "name": "Indian Ruppee",
////  "symbol": "INR",
////  "rate": 1544230.03
////},
////{
////  "name": "Australian Dollar",
////  "symbol": "AUD",
////  "rate": 25686.33
////},
////{
////  "name": "U.S. Dollar",
////  "symbol": "USD",
////  "rate": 19302.88
////}
