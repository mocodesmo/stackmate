// import 'dart:async';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:retry/retry.dart';
// import 'package:sats/zold/api/_helpers.dart';

// abstract class IProfileAPI {
//   Future<Response> getProfile({
//     required String authToken,
//   });
// }

// class ProfileAPI implements IProfileAPI {
//   @override
//   Future<Response> getProfile({required String authToken}) async {
//     final path = SERVER_URL + 'profile/';

//     final response = await retry(
//         () => client
//             .get(
//               path,
//               options: Options(headers: serializeToken(authToken)),
//             )
//             .timeout(TIMEOUT),
//         retryIf: (e) => e is SocketException || e is TimeoutException,
//         maxAttempts: 5);

//     return parseResponse(response);
//   }
// }

// class DummyProfileAPI implements IProfileAPI {
//   @override
//   Future<Response> getProfile({required String authToken}) async {
//     await Future.delayed(Duration(seconds: 3));
//     return Response(
//         requestOptions: RequestOptions(path: ''),
//         statusCode: 200,
//         data: {
//           "status": true,
//           "message": {
//             "genesis": 1597187659327,
//             "email": "mj@mj.mj",
//             "tfa": true,
//             "pin": true,
//             "locked": false
//           }
//         });
//   }
// }
