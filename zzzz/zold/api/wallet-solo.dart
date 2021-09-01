import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:retry/retry.dart';
import 'package:sats/zold/api/_helpers.dart';

abstract class ISoloWalletAPI {
  Future<Response> postGenesis({
    required String authToken,
    required String nickname,
    required String fingerprint,
    required String pathh,
    required String xpub,
    required bool rescan,
    required int start,
    required int end,
  });

  Future<Response> getAddress({
    required String authToken,
    required String nickname,
    required String format,
  });

  Future<Response> getUtxo({
    required String authToken,
    required String nickname,
    required int skip,
    required int limit,
  });

  Future<Response> getHistory({
    required String authToken,
    required String nickname,
    required int skip,
    required int limit,
  });

  Future<Response> postPayment({
    required String authToken,
    required String hashedPin,
    String? tfaCode,
    required String nickname,
    required String address,
    required int amount,
    required int fees,
    required String comment,
  });
}

class SoloWalletAPI implements ISoloWalletAPI {
  @override
  Future<Response> postGenesis(
      {required String authToken,
      required String nickname,
      required String fingerprint,
      required String pathh,
      required String xpub,
      required bool rescan,
      required int start,
      required int end}) async {
    final path = SERVER_URL + 'wallet/solo/$nickname/genesis';
    final response = await retry(
      () => client
          .post(path,
              options: Options(headers: serializeToken(authToken)),
              data: jsonEncode({
                "fingerprint": fingerprint,
                "path": pathh,
                "xpub": xpub,
                "rescan": rescan,
                "start": start,
                "end": end,
              }))
          .timeout(TIMEOUT),
      retryIf: (e) => e is SocketException || e is TimeoutException,
      maxAttempts: 5,
    );

    return parseResponse(response);
  }

  @override
  Future<Response> getAddress(
      {required String authToken,
      required String nickname,
      required String format}) async {
    final path =
        SERVER_URL + 'wallet/solo/$nickname/address/$format?label=test';

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

  @override
  Future<Response> getHistory(
      {required String authToken,
      required nickname,
      required int skip,
      required int limit}) async {
    final path =
        SERVER_URL + 'wallet/solo/$nickname/history?skip=$skip&limit=$limit';

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

  @override
  Future<Response> getUtxo(
      {required String authToken,
      required String nickname,
      required int skip,
      required int limit}) async {
    final path =
        SERVER_URL + 'wallet/solo/$nickname/utxo?skip=$skip&limit=$limit';

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

  @override
  Future<Response> postPayment(
      {required String authToken,
      required String hashedPin,
      String? tfaCode,
      required String nickname,
      required String address,
      required int amount,
      required int fees,
      required String comment}) async {
    final path = SERVER_URL + 'wallet/solo/$nickname/payment';

    final response = await retry(
      () => client
          .post(path,
              options: Options(
                  headers: tfaCode != null
                      ? serializeTokenAndPinAnd2fa(
                          authToken: authToken,
                          hashedPin: hashedPin,
                          tfaCode: tfaCode)
                      : serializeTokenAndPin(authToken, hashedPin)),
              data: jsonEncode({
                "address": address,
                "amount": amount,
                "fees": fees,
                "comment": comment,
              }))
          .timeout(TIMEOUT),
      retryIf: (e) => e is SocketException || e is TimeoutException,
      maxAttempts: 5,
    );

    return parseResponse(response);
  }
}

class DummySoloWalletAPI implements ISoloWalletAPI {
  @override
  Future<Response> getAddress(
      {required String authToken,
      required String nickname,
      required String format}) async {
    await Future.delayed(Duration(seconds: 2));
    return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {
          "status": true,
          "message": "44:test:tb1q9msfx6e7yk6567pga02mn8mc4580re23kjqcz9"
        });
  }

  @override
  Future<Response> getHistory(
      {required String authToken,
      required String nickname,
      required int skip,
      required int limit}) async {
    await Future.delayed(Duration(seconds: 2));
    return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {
          "status": true,
          "message": [
            {
              "involvesWatchonly": true,
              "address": "tb1qqvf963xu9cgkw7e8twydgkkjyyghwm8kgh0w0p",
              "category": "receive",
              "amount": 900,
              "fee": 0,
              "label": "",
              "vout": 1,
              "confirmations": 811,
              "blockhash":
                  "0000000000000019d15b0e9144067e66ea064533579b31fdca748a0310b801c1",
              "blockheight": 1974022,
              "blockindex": 20,
              "blocktime": 1620007568000,
              "txid":
                  "54eb0f6771e74a5835123f80a362caaeac2fcc1902f405249965d8e6c754bd18",
              "time": 1620007568000,
              "timereceived": 1620593983000,
              "bip125-replaceable": "no",
              "confirmed": true,
            },
            {
              "involvesWatchonly": true,
              "address": "2N44xXWiHo4q9RjKo3hqfDKYpvyi7AppKe4",
              "category": "send",
              "amount": -600,
              "fee": -300,
              "vout": 0,
              "confirmations": 782,
              "blockhash":
                  "000000000000001974969f4f052b380c94837eb9c571037a1cbc3311144fbd7f",
              "blockheight": 1974051,
              "blockindex": 10,
              "blocktime": 1620012858000,
              "txid":
                  "501336d5276e9301937b03c689197f4cc48546bed43ca5dcf5ccc9de14a30197",
              "time": 1620012858000,
              "timereceived": 1620593983000,
              "bip125-replaceable": "no",
              "confirmed": true,
            },
            {
              "involvesWatchonly": true,
              "address": "tb1qahfts8fl0n3q7gccr8ly2x7qu6uzdqmexvdt9t",
              "category": "receive",
              "amount": 1539239,
              "fee": 0,
              "label": "",
              "vout": 1,
              "confirmations": 609,
              "blockhash":
                  "000000000ebbea3cf4398ced8db52cba49cc42071b63e0509952e76230c434ca",
              "blockheight": 1974224,
              "blockindex": 3,
              "blocktime": 1620055815000,
              "txid":
                  "815e3c313b9f0d136e28270cfc2cd8bf472befa646a89a35e02941bcb4ce7426",
              "time": 1620055815000,
              "timereceived": 1620593983000,
              "bip125-replaceable": "no",
              "confirmed": true,
            },
            {
              "involvesWatchonly": true,
              "address": "2N44xXWiHo4q9RjKo3hqfDKYpvyi7AppKe4",
              "category": "send",
              "amount": -600000,
              "fee": -269,
              "vout": 1,
              "confirmations": 603,
              "blockhash":
                  "0000000000000004c83e81a04f65448f4b584f862f823affd17769fead76c85f",
              "blockheight": 1974230,
              "blockindex": 12,
              "blocktime": 1620059401000,
              "txid":
                  "8f9ae4c89fd4efe1383d05b728b724142eed9126f44bd55351fd699dfd78aa8a",
              "time": 1620059401000,
              "timereceived": 1620593983000,
              "bip125-replaceable": "no",
              "confirmed": true,
            },
            {
              "involvesWatchonly": true,
              "address": "2MupVyQaQH3FnrBzgktga6ek41sXRh4pW5j",
              "category": "receive",
              "amount": 950,
              "fee": 0,
              "vout": 0,
              "confirmations": 602,
              "blockhash":
                  "00000000000000015e5b0c5beb70f03cf02ace1bf8bbe9c8e0ae1a19336dcc8e",
              "blockheight": 1974231,
              "blockindex": 31,
              "blocktime": 1620060501000,
              "txid":
                  "32b942eeede3c6d51b79ac83e59436819d52b513cd43cabbb9731d3a004eee77",
              "time": 1620060501000,
              "timereceived": 1620593984000,
              "bip125-replaceable": "no",
              "confirmed": true
            }
          ]
        });
  }

  @override
  Future<Response> getUtxo(
      {required String authToken,
      required String nickname,
      required int skip,
      required int limit}) async {
    await Future.delayed(Duration(seconds: 2));
    return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {
          "status": true,
          "message": [
            {
              "address": "2MupVyQaQH3FnrBzgktga6ek41sXRh4pW5j",
              "amount": 950,
              "vout": 0,
              "confirmations": 602,
              "txid":
                  "32b942eeede3c6d51b79ac83e59436819d52b513cd43cabbb9731d3a004eee77",
              "redeemScript": "0014a1f92438288095c9b42417abe843166241666047",
              "witnessScript": "none",
              "scriptPubKey": "a9141c3b526296ad980095609929ee2c5138a883197a87",
              "spendable": false,
              "solvable": true,
              "desc":
                  "sh(wpkh([ecf2c469/84h/1h/0h/0/41]02ab7aab7aedc51fe7130c54063b6449e57d0bf10e2340bdfabafa0c4a182a041e))#khe70lxx",
              "safe": true
            },
            {
              "address": "tb1qr6uzmkyf3prj7wwvhqzsjt5e8gzsagkqvsh68a",
              "amount": 938970,
              "vout": 0,
              "confirmations": 603,
              "txid":
                  "8f9ae4c89fd4efe1383d05b728b724142eed9126f44bd55351fd699dfd78aa8a",
              "redeemScript": "none",
              "witnessScript": "none",
              "scriptPubKey": "00141eb82dd88988472f39ccb805092e993a050ea2c0",
              "spendable": false,
              "solvable": true,
              "desc":
                  "wpkh([ecf2c469/84h/1h/0h/1/16]0302d1a9f39e83adc8e0d32c34893e93b06398b20b42a19eea10d24b6266108bfe)#nzt3xmnw",
              "safe": true
            }
          ]
        });
  }

  @override
  Future<Response> postGenesis(
      {required String authToken,
      required String nickname,
      required String fingerprint,
      required String pathh,
      required String xpub,
      required bool rescan,
      required int start,
      required int end}) async {
    await Future.delayed(Duration(seconds: 2));
    return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {"status": true, "message": true});
  }

  @override
  Future<Response> postPayment(
      {required String authToken,
      required String hashedPin,
      String? tfaCode,
      required String nickname,
      required String address,
      required int amount,
      required int fees,
      required String comment}) async {
    await Future.delayed(Duration(seconds: 2));
    return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {
          "status": true,
          "message": {
            "txid": {
              "psbt":
                  "cHNidP8BAHECAAAAAYqqeP2daf1RU9VL9CaR7S4UJLcotwU9OOHv1J/I5JqPAAAAAAD9////AlEkDgAAAAAAFgAUku3lJXqTrpPW8YpKUD+k9e7bhozgLgAAAAAAABYAFPW2V9U6dYMP9JndWLwL7P1t4R84AAAAAAABAHICAAAAASZ0zrS8QSngNZqoRqbvK0e/2Cz8DCcobhMNnzsxPF6BAQAAAAD9////AtpTDgAAAAAAFgAUHrgt2ImIRy85zLgFCS6ZOgUOosDAJwkAAAAAABepFHa4UT0NurRJznLyhc9Wbc/HR5z1hwAAAAABAR/aUw4AAAAAABYAFB64LdiJiEcvOcy4BQkumToFDqLAIgYDAtGp856Drcjg0yw0iT6TsGOYsgtCoZ7qENJLYmYQi/4Y7PLEaVQAAIABAACAAAAAgAEAAAAQAAAAACICA/JkOvFgt/lxA0V2ZXo9oP57W2Brska9UG3Dx5IPswdbGOzyxGlUAACAAQAAgAAAAIABAAAAEQAAAAAA",
              "fee": 5000,
              //"amount": 50000,
            }
          }
        });
  }
}
