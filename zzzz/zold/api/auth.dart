// import 'package:dio/dio.dart';
// import 'package:retry/retry.dart';
// import 'package:sats/zold/api/_helpers.dart';

// abstract class IAuthAPI {
//   Future<Response> postPin({
//     required String authToken,
//     required hashedPin,
//   });

//   Future<Response> getTfa({
//     required String authToken,
//     required String hashedPin,
//   });

//   Future<Response> postTfa({
//     required String authToken,
//     required hashedPin,
//     required String code,
//   });
// }

// class AuthAPI implements IAuthAPI {
//   @override
//   Future<Response> postPin({required String authToken, hashedPin}) async {
//     final path = SERVER_URL + 'auth/pin';

//     final response = await retry(
//         () => client
//             .post(path,
//                 options: Options(
//                   headers: serializeTokenAndPin(authToken, hashedPin),
//                 ))
//             .timeout(TIMEOUT),
//         retryIf: (e) => e is SocketException || e is TimeoutException,
//         maxAttempts: 5);

//     return parseResponse(response);
//   }

//   @override
//   Future<Response> getTfa(
//       {required String authToken, required hashedPin}) async {
//     final path = SERVER_URL + 'auth/tfa';

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

//   @override
//   Future<Response> postTfa(
//       {required String authToken, hashedPin, required code}) async {
//     final path = SERVER_URL + 'auth/tfa';

//     final response = await retry(
//         () => client
//             .post(path,
//                 options: Options(
//                   headers: serializeTokenAndPinAnd2fa(
//                       authToken: authToken,
//                       hashedPin: hashedPin,
//                       tfaCode: code),
//                 ))
//             .timeout(TIMEOUT),
//         retryIf: (e) => e is SocketException || e is TimeoutException,
//         maxAttempts: 5);

//     return parseResponse(response);
//   }
// }

// class DummyAuthAPI implements IAuthAPI {
//   @override
//   Future<Response> postPin({required String authToken, hashedPin}) async {
//     await Future.delayed(Duration(seconds: 3));
//     return Response(requestOptions: RequestOptions(path: ''), statusCode: 200);
//   }

//   @override
//   Future<Response> getTfa(
//       {required String authToken, required hashedPin}) async {
//     await Future.delayed(Duration(seconds: 3));
//     return Response(
//         requestOptions: RequestOptions(path: ''),
//         statusCode: 200,
//         data: {
//           "status": true,
//           "message": {
//             "secret": "NVPGWW3BPNRD4VB2NBGEWVK5OBBTMN35JZ3TOVTVOZBHSM3RJJBA"
//           }
//         });
//   }

//   @override
//   Future<Response> postTfa(
//       {required String authToken, hashedPin, required code}) async {
//     await Future.delayed(Duration(seconds: 3));
//     return Response(
//         requestOptions: RequestOptions(path: ''),
//         statusCode: 200,
//         data: {"status": true, "message": "Valid Token"});
//   }
// }
