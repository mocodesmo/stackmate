import 'dart:async';
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';
import 'package:sats/api/_helpers.dart';

abstract class IRedditAPI {
  Future<Response> fetchPosts(String topic);
}

class RedditAPI implements IRedditAPI {
  Future<Response> fetchPosts(String topic) async {
    String _url = 'https://www.reddit.com';

    final path = "$_url/r/$topic/hot.json";

    final response = await retry(
      () => client
          .get(path,
              options: Options(
                validateStatus: (status) => true,
              ))
          .timeout(TIMEOUT),
      retryIf: (e) => e is SocketException || e is TimeoutException,
      maxAttempts: 5,
    );

    return parseResponse(response);
  }
}
