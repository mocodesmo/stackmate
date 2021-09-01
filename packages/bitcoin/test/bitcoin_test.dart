import 'dart:convert';
import 'package:bitcoin/bitcoin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:ffi';
import 'package:ffi/ffi.dart';

void main() {
  late DynamicLibrary _lib;

  setUp(() {
    _lib = DynamicLibrary.open('libditto.dylib');
  });

  test('test generate_master ffi', () async {
    final func = _lib.lookupFunction<ffi_func3_master, ffi_func3_master>(
      'generate_master',
    );

    final response = func(
      '9'.toNativeUtf8(),
      ''.toNativeUtf8(),
      'tpanini'.toNativeUtf8(),
    );

    final mnemonic = jsonDecode(response.toDartString())['mnemonic'];

    expect(mnemonic.split(' ').length, 24);
  });
}
