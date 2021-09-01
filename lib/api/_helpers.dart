import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:sats/state.dart';
export 'dart:io';
export 'dart:async';

//const SERVER_URL = 'https://play.satswala.com/';

String get SERVER_URL => testNetCubit.state.url();

const TIMEOUT = Duration(seconds: 40);

final client = Dio(BaseOptions(validateStatus: (status) => true));

Map<String, String> serializeToken(String authToken) {
  return {
    'Authorization': 'Bearer ' + authToken,
    'Content-Type': 'application/json',
    'Accept': '*/*',
  };
}

Map<String, String> serializeTokenAd2fa(String authToken, String tfaCode) {
  return {
    'Authorization': 'Bearer ' + authToken,
    'x-sats-totp': tfaCode,
    'Content-Type': 'application/json',
    'Accept': '*/*',
  };
}

Map<String, String> serializeTokenAndPin(String authToken, String hashedPin) {
  return {
    'Authorization': 'Bearer ' + authToken,
    'x-sats-pin': hashedPin,
    'Content-Type': 'application/json',
    'Accept': '*/*',
  };
}

Map<String, String> serializeTokenAndPinAnd2fa({
  required String authToken,
  required String hashedPin,
  required String tfaCode,
}) {
  return {
    'Authorization': 'Bearer ' + authToken,
    'x-sats-pin': hashedPin,
    'x-sats-totp': tfaCode,
    'Content-Type': 'application/json',
    'Accept': '*/*',
  };
}

Response parseResponse(Response res) {
  try {
    loggerCubit.logAPI(
      res.requestOptions.path,
      jsonEncode(res.data),
      res.statusCode!,
    );

    // if (res.statusCode == 401) userCubit.logOut();
  } catch (e, s) {
    loggerCubit.logException(e, 'api.logresponse', s);
  }

  return res;
}

final timeOut = Duration(seconds: 40);
