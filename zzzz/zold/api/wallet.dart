// import 'dart:async';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:retry/retry.dart';
// import 'package:sats/zold/api/_helpers.dart';

// abstract class IWalletAPI {
//   Future<Response> getWalletOverview({
//     required String authToken,
//     required String hashedPin,
//   });
// }

// class WalletAPI implements IWalletAPI {
//   @override
//   Future<Response> getWalletOverview(
//       {required String authToken, required hashedPin}) async {
//     final path = SERVER_URL + 'wallet/overview';

//     final response = await retry(
//         () => client
//             .get(path,
//                 options: Options(
//                   headers: serializeTokenAndPin(authToken, hashedPin),
//                 ))
//             .timeout(TIMEOUT),
//         retryIf: (e) => e is SocketException || e is TimeoutException,
//         maxAttempts: 5);

//     return parseResponse(response);
//   }
// }

// class DummyWalletAPI implements IWalletAPI {
//   @override
//   Future<Response> getWalletOverview(
//       {required String authToken, required String hashedPin}) async {
//     await Future.delayed(Duration(seconds: 3));
//     return Response(
//         requestOptions: RequestOptions(path: ''),
//         statusCode: 200,
//         data: {
//           "status": true,
//           "message": {
//             "solo": [
//               {
//                 "genesis": 1620595788120,
//                 //'watch_only': false,
//                 "nickname": "My Vault",
//                 "fingerprint": "ecf2c469",
//                 "path": "84h/1h/0h",
//                 "xpub":
//                     "tpubDCfeuy7w6i7bRj9rXPwTyZ8sS5bNXnaUXcDJEbjqU5k3o7aicpcRaF7g1iAHRApsHGsCMwqpYsvMZLaiNBX6DKq3FHnV5zN4cAf6ugQ44u4",
//                 "address": "tb1q2hxh22qg4qcv3uwqtflavlg74ac4cgw6wv0klj",
//                 "label": "Sushi",
//                 "index": 42,
//                 "balances": {
//                   "confirmed": 939920,
//                   "unconfirmed": 0,
//                 }
//               },
//               {
//                 "genesis": 1620595788120,
//                 "nickname": "My Vault 2",
//                 //'watch_only': true,
//                 "fingerprint": "ecf2c469",
//                 "path": "84h/1h/0h",
//                 "xpub":
//                     "tpubDCfeuy7w6i7bRj9rXPwTyZ8sS5bNXnaUXcDJEbjqU5k3o7aicpcRaF7g1iAHRApsHGsCMwqpYsvMZLaiNBX6DKq3FHnV5zN4cAf6ugQ44u4",
//                 "address": "tb1q2hxh22qg4qcv3uwqtflavlg74ac4cgw6wv0klj",
//                 "label": "Sushii",
//                 "index": 42,
//                 "balances": {
//                   "confirmed": 333333,
//                   "unconfirmed": 0,
//                 }
//               },
//             ]
//           }
//         });
//   }
// }
