import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:sats/state.dart';
export 'dart:io';
export 'dart:async';


const TIMEOUT = Duration(seconds: 40);

final client = Dio(BaseOptions(validateStatus: (status) => true));

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
