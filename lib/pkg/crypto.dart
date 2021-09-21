import 'dart:convert';
import 'package:crypto/crypto.dart';

//abstract class ICrypto {
//  String hashEncrypt(String text);
//}

class Crypto {
  static String hashEncrypt(String text) {
    final bytes1 = utf8.encode(text);
    final digest1 = sha256.convert(bytes1);
    return digest1.toString();
  }
}
