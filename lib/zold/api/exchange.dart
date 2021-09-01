import 'package:dio/dio.dart';
import 'package:retry/retry.dart';
import 'package:sats/zold/api/_helpers.dart';

abstract class IExchangeAPI {
  Future<Response> getRates({required String authToken});
}

class ExchangeAPI implements IExchangeAPI {
  @override
  Future<Response> getRates({required String authToken}) async {
    final path = SERVER_URL + 'exchange/rates';
    final response = await retry(
        () => client
            .get(path,
                options: Options(
                  headers: serializeToken(authToken),
                ))
            .timeout(TIMEOUT),
        retryIf: (e) => e is SocketException || e is TimeoutException,
        maxAttempts: 5);
    return parseResponse(response);
  }
}

class DummyExchangeAPI implements IExchangeAPI {
  @override
  Future<Response> getRates({required String authToken}) async {
    await Future.delayed(Duration(seconds: 5));
    return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {
          "status": true,
          "message": [
            {"name": "Indian Ruppee", "symbol": "INR", "rate": 1544230.03},
            {"name": "Euro", "symbol": "EUR", "rate": 15931.3},
            {"name": "Australian Dollar", "symbol": "AUD", "rate": 25686.33},
            {"name": "U.S. Dollar", "symbol": "USD", "rate": 19302.88}
          ]
        });
  }
}
