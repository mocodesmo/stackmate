import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';
import 'package:sats/zold/api/_helpers.dart';

abstract class INetworkAPI {
  Future<Response> getValidation({
    required String authToken,
    required String address,
  });

  Future<Response> getInfo({
    required String authToken,
  });

  Future<Response> postDecode({
    required String authToken,
    required String psbt,
  });

  Future<Response> postBroadcast({
    required String authToken,
    required String psbt,
  });
}

class NetworkAPI implements INetworkAPI {
  @override
  Future<Response> getInfo({required String authToken}) async {
    final path = SERVER_URL + 'network/info';

    final response = await retry(
        () => client
            .get(
              path,
              options: Options(headers: serializeToken(authToken)),
            )
            .timeout(TIMEOUT),
        retryIf: (e) => e is SocketException || e is TimeoutException,
        maxAttempts: 5);

    return parseResponse(response);
  }

  @override
  Future<Response> getValidation(
      {required String authToken, required String address}) async {
    final path = SERVER_URL + 'network/validation?address=$address';

    final response = await retry(
        () => client
            .get(
              path,
              options: Options(headers: serializeToken(authToken)),
            )
            .timeout(TIMEOUT),
        retryIf: (e) => e is SocketException || e is TimeoutException,
        maxAttempts: 5);

    return parseResponse(response);
  }

  @override
  Future<Response> postBroadcast({
    required String authToken,
    required String psbt,
  }) async {
    final path = SERVER_URL + 'network/broadcast';

    final response = await retry(
      () => client
          .post(path,
              options: Options(headers: serializeToken(authToken)),
              data: jsonEncode({
                'psbt': psbt,
                'encoding': 'base64',
              }))
          .timeout(TIMEOUT),
      retryIf: (e) => e is SocketException || e is TimeoutException,
      maxAttempts: 5,
    );

    return parseResponse(response);
  }

  @override
  Future<Response> postDecode(
      {required String authToken, required String psbt}) async {
    final path = SERVER_URL + 'network/decode';

    final response = await retry(
      () => client
          .post(path,
              options: Options(headers: serializeToken(authToken)),
              data: jsonEncode({'psbt': psbt}))
          .timeout(TIMEOUT),
      retryIf: (e) => e is SocketException || e is TimeoutException,
      maxAttempts: 5,
    );

    return parseResponse(response);
  }
}

class DummyNetworkAPI implements INetworkAPI {
  @override
  Future<Response> getInfo({required String authToken}) async {
    await Future.delayed(Duration(seconds: 2));
    return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {
          "status": true,
          "message": {
            "traffic": "low",
            "fees": {
              "low": 1000,
              "medium": 1000,
              "high": 1000,
            },
            "mempool_size": 17,
            "chain": "test",
            "blocks": 2005905
          }
        });
  }

  @override
  Future<Response> getValidation(
      {required String authToken, required String address}) async {
    await Future.delayed(Duration(seconds: 2));
    return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {"status": true, "message": true});
  }

  @override
  Future<Response> postBroadcast({
    required String authToken,
    required String psbt,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {"status": false, "message": "TX decode failed"});
  }

  @override
  Future<Response> postDecode(
      {required String authToken, required String psbt}) async {
    await Future.delayed(Duration(seconds: 2));
    return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {
          "status": true,
          "message": {
            "tx": {
              "txid":
                  "0c983690c844d0b69d5dfadc23bf501cc5a666933039e544caf3f4a9f550f6a6",
              "hash":
                  "0c983690c844d0b69d5dfadc23bf501cc5a666933039e544caf3f4a9f550f6a6",
              "version": 2,
              "size": 114,
              "vsize": 114,
              "weight": 456,
              "locktime": 0,
              "vin": [
                {
                  "txid":
                      "8f9ae4c89fd4efe1383d05b728b724142eed9126f44bd55351fd699dfd78aa8a",
                  "vout": 0,
                  "scriptSig": {"asm": "", "hex": ""},
                  "sequence": 4294967293
                }
              ],
              "vout": [
                {
                  "value": 0.0003,
                  "n": 0,
                  "scriptPubKey": {
                    "asm":
                        "OP_HASH160 76b8513d0dbab449ce72f285cf566dcfc7479cf5 OP_EQUAL",
                    "hex": "a91476b8513d0dbab449ce72f285cf566dcfc7479cf587",
                    "reqSigs": 1,
                    "type": "scripthash",
                    "addresses": ["2N44xXWiHo4q9RjKo3hqfDKYpvyi7AppKe4"]
                  }
                },
                {
                  "value": 0.00908701,
                  "n": 1,
                  "scriptPubKey": {
                    "asm": "0 92ede5257a93ae93d6f18a4a503fa4f5eedb868c",
                    "hex": "001492ede5257a93ae93d6f18a4a503fa4f5eedb868c",
                    "reqSigs": 1,
                    "type": "witness_v0_keyhash",
                    "addresses": ["tb1qjtk72ft6jwhf84h33f99q0ay7hhdhp5vnapwtg"]
                  }
                }
              ]
            },
            "unknown": {},
            "inputs": [
              {
                "witness_utxo": {
                  "amount": 0.0093897,
                  "scriptPubKey": {
                    "asm": "0 1eb82dd88988472f39ccb805092e993a050ea2c0",
                    "hex": "00141eb82dd88988472f39ccb805092e993a050ea2c0",
                    "type": "witness_v0_keyhash",
                    "address": "tb1qr6uzmkyf3prj7wwvhqzsjt5e8gzsagkqvsh68a"
                  }
                },
                "non_witness_utxo": {
                  "txid":
                      "8f9ae4c89fd4efe1383d05b728b724142eed9126f44bd55351fd699dfd78aa8a",
                  "hash":
                      "8f9ae4c89fd4efe1383d05b728b724142eed9126f44bd55351fd699dfd78aa8a",
                  "version": 2,
                  "size": 114,
                  "vsize": 114,
                  "weight": 456,
                  "locktime": 0,
                  "vin": [
                    {
                      "txid":
                          "815e3c313b9f0d136e28270cfc2cd8bf472befa646a89a35e02941bcb4ce7426",
                      "vout": 1,
                      "scriptSig": {"asm": "", "hex": ""},
                      "sequence": 4294967293
                    }
                  ],
                  "vout": [
                    {
                      "value": 0.0093897,
                      "n": 0,
                      "scriptPubKey": {
                        "asm": "0 1eb82dd88988472f39ccb805092e993a050ea2c0",
                        "hex": "00141eb82dd88988472f39ccb805092e993a050ea2c0",
                        "reqSigs": 1,
                        "type": "witness_v0_keyhash",
                        "addresses": [
                          "tb1qr6uzmkyf3prj7wwvhqzsjt5e8gzsagkqvsh68a"
                        ]
                      }
                    },
                    {
                      "value": 0.006,
                      "n": 1,
                      "scriptPubKey": {
                        "asm":
                            "OP_HASH160 76b8513d0dbab449ce72f285cf566dcfc7479cf5 OP_EQUAL",
                        "hex": "a91476b8513d0dbab449ce72f285cf566dcfc7479cf587",
                        "reqSigs": 1,
                        "type": "scripthash",
                        "addresses": ["2N44xXWiHo4q9RjKo3hqfDKYpvyi7AppKe4"]
                      }
                    }
                  ]
                },
                "bip32_derivs": [
                  {
                    "pubkey":
                        "0302d1a9f39e83adc8e0d32c34893e93b06398b20b42a19eea10d24b6266108bfe",
                    "master_fingerprint": "ecf2c469",
                    "path": "m/84'/1'/0'/1/16"
                  }
                ]
              }
            ],
            "outputs": [
              {},
              {
                "bip32_derivs": [
                  {
                    "pubkey":
                        "03f2643af160b7f971034576657a3da0fe7b5b606bb246bd506dc3c7920fb3075b",
                    "master_fingerprint": "ecf2c469",
                    "path": "m/84'/1'/0'/1/17"
                  }
                ]
              }
            ],
            "fee": 0.00000269
          }
        });
  }
}
