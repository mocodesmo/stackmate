////
//import 'package:dio/dio.dart';
//import 'package:mockito/mockito.dart';
//import 'package:sats/api/wallet.dart';
//import 'package:sats/model/btc-wallet.dart';
//import 'package:sats/model/wallet.dart';
//import 'package:sats/pkg/storage.dart';
//import 'package:sats/view/common/wallet-bloc/bloc.dart';
//import 'package:test/test.dart';
//import 'package:bloc_test/bloc_test.dart';

//class _MockStorage extends Mock implements IStorage {}

//class _MockWalletAPI extends Mock implements IWalletAPI {}

//main() {
//  group('Wallet Bloc', () {
//    WalletBloc bloc;
//    IWalletAPI walletAPI;
//    IStorage storage;

//    final wallet = Wallet(
//        btcWallet: BtcWallet(
//            p2sh: '', created: 1, satsBalance: 0, p2pkh: '', bech32: ''));

//    setUp(() {
//      walletAPI = _MockWalletAPI();
//      storage = _MockStorage();

//      bloc = WalletBloc(storage, walletAPI);
//    });

//    tearDown(() {
//      bloc.close();
//    });

//    test('initial state should  be  blank', () {
//      expect(bloc.state, WalletState());
//    });

//    blocTest('Should get unknown error on getwallet',
//        build: () {
//          when(storage.getItem(key: CacheKeys.token))
//              .thenAnswer((_) async => 'abc');

//          when(storage.getItem(key: CacheKeys.hashedPin))
//              .thenAnswer((_) async => 'abc');

//          when(walletAPI.getWallet(authToken: 'abc', hashedPin: 'abc'))
//              .thenAnswer((_) async =>
//                  Response(request: RequestOptions(path: ''), statusCode: 500));
//          return bloc;
//        },
//        act: (WalletBloc bloc) {
//          bloc.add(GetWallet());
//        },
//        expect: () => [
//              WalletState(loadingWallets: true),
//              WalletState(
//                  loadingWalletsError: 'Error Occured. Please try again.'),
//            ],
//        verify: (WalletBloc bloc) {
//          verify(storage.getItem(key: CacheKeys.token)).called(1);
//          verify(storage.getItem(key: CacheKeys.hashedPin)).called(1);
//          verify(walletAPI.getWallet(authToken: 'abc', hashedPin: 'abc'))
//              .called(1);
//        });

//    blocTest('should get wallet successfully',
//        build: () {
//          when(storage.getItem(key: CacheKeys.token))
//              .thenAnswer((_) async => 'abc');

//          when(storage.getItem(key: CacheKeys.hashedPin))
//              .thenAnswer((_) async => 'abc');

//          when(walletAPI.getWallet(authToken: 'abc', hashedPin: 'abc'))
//              .thenAnswer((_) async => Response(
//                  request: RequestOptions(path: ''),
//                  statusCode: 200,
//                  data: walletPayload));

//          return bloc;
//        },
//        act: (WalletBloc bloc) {
//          bloc.add(GetWallet());
//        },
//        expect: () => [
//              WalletState(loadingWallets: true),
//              WalletState(wallet: wallet),
//            ],
//        verify: (WalletBloc bloc) {
//          verify(storage.getItem(key: CacheKeys.token)).called(1);
//          verify(storage.getItem(key: CacheKeys.hashedPin)).called(1);
//          verify(walletAPI.getWallet(authToken: 'abc', hashedPin: 'abc'))
//              .called(1);
//        });

//    //blocTest('', build: () {
//    //  return bloc;
//    //}, act: (WalletBloc bloc) {
//    //  //bloc.add(WalletState());
//    //}, expect:()=> [
//    //  WalletState(),
//    //]);
//  });
//}

//const walletPayload = '''
//{
//  "status": true,
//  "message": {
//    "bitcoin": {
//      "genesis": 1601213969411,
//      "bech32": "bc1q8e4hp24acrd8eevg4w250fc6t2qyuevclylm9j",
//      "p2sh": "3MnP8FeyiN7XVmUw7tfxvuWFP6u7dYxvUK",
//      "legacy": "bc1q8e4hp24acrd8eevg4w250fc6t2qyuevclylm9j",
//      "history": [
//        {
//          "genesis": 1599983998,
//          "currency": "bitcoin",
//          "txid": "677a2f654cb09c97aa342f54f810e6679dcf36cb0d6245d61832f0c8e4edbdde",
//          "amount": 92,
//          "confirmed": true,
//          "type": "in",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1600002122,
//          "currency": "bitcoin",
//          "txid": "3afde499de02746826f69dc9ec372e32f5948fcc67c99d731afc2e7354a476f8",
//          "amount": 12000,
//          "confirmed": true,
//          "type": "in",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1600002122,
//          "currency": "bitcoin",
//          "txid": "54af497b78a5cda1b1540b3ac95444ad5a6a1be8ca4eae54d499ab90972ed484",
//          "amount": 12129,
//          "confirmed": true,
//          "type": "in",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1600002122,
//          "currency": "bitcoin",
//          "txid": "7bc816ba04290104415e0e1e9f56ba1fffdabdfdac34d73df96c64b666eb02f0",
//          "amount": 9635,
//          "confirmed": true,
//          "type": "in",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1600100403,
//          "currency": "bitcoin",
//          "txid": "97d8cfab23d5df032c2a17847fe6bc8584e0dbb72f2c6c7e0afc4c650f70ee6c",
//          "amount": 9636,
//          "confirmed": true,
//          "type": "in",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1600116927,
//          "currency": "bitcoin",
//          "txid": "beef084747c9e22a530cb358ce2a7e80739d4f181b78f30c7c6f2cce9e898ab8",
//          "amount": 9653,
//          "confirmed": true,
//          "type": "in",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1601221500,
//          "currency": "bitcoin",
//          "txid": "ddfae20b048a0196e9b4204b57d7ef67687b3d2c125ddc7d8268a103782b9fef",
//          "amount": 1253,
//          "confirmed": true,
//          "type": "in",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1601221500,
//          "currency": "bitcoin",
//          "txid": "d964684e62cb68a6015b640de65dcaaa13403ce15c6418d9463d85eb540fb774",
//          "amount": 4313,
//          "confirmed": true,
//          "type": "in",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1601221500,
//          "currency": "bitcoin",
//          "txid": "46ca7ff6d6f482537ffff851576bb9d469078c00f499774771593bf342856227",
//          "amount": 9568,
//          "confirmed": true,
//          "type": "in",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1601221500,
//          "currency": "bitcoin",
//          "txid": "fb68a8c0297a7e964c0e261f4ce210876f740d5ccfce6b4f8607c7fc4a66c3df",
//          "amount": 915,
//          "confirmed": true,
//          "type": "in",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1601221500,
//          "currency": "bitcoin",
//          "txid": "8b1257245a6e53c870956024833d2386547f050bdafac8f4a6def743bd60c95d",
//          "amount": 969,
//          "confirmed": true,
//          "type": "in",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1601228696,
//          "currency": "bitcoin",
//          "txid": "8eae5f116a6b922247cc47ce9242006419da6bbd2d07020432adfce7500be116",
//          "amount": 5653,
//          "confirmed": true,
//          "type": "in",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1601228696,
//          "currency": "bitcoin",
//          "txid": "071aa9ba8c5e1a8981f1f5cc589e8ca88ad5e05acfa36c9689efe58b6d2d2944",
//          "amount": 5652,
//          "confirmed": true,
//          "type": "in",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1601228696,
//          "currency": "bitcoin",
//          "txid": "41782afc8fd23737bdb61f5543b5db0742313d6d7bda2ea781b0e41c4a83a727",
//          "amount": 2325,
//          "confirmed": true,
//          "type": "in",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1601228696,
//          "currency": "bitcoin",
//          "txid": "e008afa1a5f9e1fcbe2d428d2830af3ed6f4a095e8619441a7411d51419fa424",
//          "amount": 1569,
//          "confirmed": true,
//          "type": "in",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1601228696,
//          "currency": "bitcoin",
//          "txid": "623401e07ee84f0d1197839b64e642eada310e2f5422f0f8f1474fdbd8001e48",
//          "amount": 2132,
//          "confirmed": true,
//          "type": "in",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1601228696,
//          "currency": "bitcoin",
//          "txid": "95f356679f4a10669af8e8629d57c24246aea5c843d03b71e0e904dc971f71b4",
//          "amount": 2369,
//          "confirmed": true,
//          "type": "in",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1601228696,
//          "currency": "bitcoin",
//          "txid": "57b42648f8a2b799626be1dc90a127b9fbae036115ff988a474edf5d304b62b1",
//          "amount": 6639,
//          "confirmed": true,
//          "type": "in",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1601231404,
//          "currency": "bitcoin",
//          "txid": "7bea37d2fb85fedc423ab20a08d99c580ce19a1cef84204e6a1449e414a870e5",
//          "amount": 1936,
//          "confirmed": true,
//          "type": "in",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1601284099744,
//          "currency": "bitcoin",
//          "txid": "c3e83370b462ed85b160001e4baa43303fbd1ba52d086b92b640a925f9024be7",
//          "amount": 300000,
//          "confirmed": true,
//          "type": "out",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1601284099768,
//          "currency": "bitcoin",
//          "txid": "af63be055ba071ff44758c37aa67862294ebd9c41ee070a514c989354e9bf3ae",
//          "amount": 300000,
//          "confirmed": true,
//          "type": "out",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1601289667869,
//          "currency": "bitcoin",
//          "txid": "8bac4dda8d47ad7c97973b11e2b95a7e92b9b05e3944acc6411ae26367985d4d",
//          "amount": -500,
//          "confirmed": true,
//          "type": "out",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1601291664095,
//          "currency": "bitcoin",
//          "txid": "4a64b7091b23e95fd8cce7c0cf1d95609b152dc7f4c70ab52c734bb4a7c86f37",
//          "amount": -300000,
//          "confirmed": false,
//          "type": "out",
//          "counter_party": "External"
//        },
//        {
//          "genesis": 1601291729628,
//          "currency": "bitcoin",
//          "txid": "a4dfe859913d6b61bdc9d7650621e09b6e1ca9e0a8e417e313e8283497fb6a03",
//          "amount": -0.00004846,
//          "confirmed": false,
//          "type": "out",
//          "counter_party": "External",
//          "comment": "yoyoyoyo"
//        },
//        {
//          "genesis": 1601298446183,
//          "currency": "bitcoin",
//          "txid": "abf2a7bcbabe67fb6e118566a5fe89717e4f909db82b2980a8835b3d56248497",
//          "amount": -3000,
//          "confirmed": false,
//          "type": "out",
//          "counter_party": "External",
//          "comment": "yoyoyoyo"
//        }
//      ],
//      "balance": 117000
//    },
//    "inr": {
//      "genesis": 1601213969411,
//      "bank": [
//        {
//          "aid": "s5acc7777-08d8-467a-be3b",
//          "status": "verification-pending",
//          "account_holder_name": "Bunmas Kachai",
//          "account_number": "9901287232123",
//          "ifsc_code": "SBIN000238283"
//        }
//      ],
//      "upi": [
//        {
//          "aid": "s5acc7777-08d8-467a-be2b",
//          "status": "verified",
//          "id": "bunmasmaan@ybl"
//        },
//        {
//          "aid": "s5acc7777-08d8-467a-be4b",
//          "status": "rejected",
//          "id": "bunnibro@ybl"
//        }
//      ],
//      "card": [
//        {
//          "aid": "s5acc7777-02d8-467a-be3b",
//          "status": "verification-pending",
//          "cardholder_name": "Bunmas Kachai",
//          "card_number": "7878679054653353",
//          "expiry": "12/22"
//        }
//      ],
//      "history": [
//        {
//          "genesis": 1599983998,
//          "currency": "inr",
//          "txid": "9c97aa342f5-4f810e-6679dcf36",
//          "amount": 10000,
//          "confirmed": true,
//          "type": "in",
//          "counter_party": "s5acc7777-08d8-467a-be2b"
//        }
//      ],
//      "balance": 10000
//    }
//  }
//}
//''';
