import 'dart:io';

import 'package:test/test.dart';
import 'package:wasm/wasm.dart';

void main() {
  group('WASM', () {
    test('Loading wasm', () {
      final data = File('/Users/mj/code/stackmate/test/stackmate.wasm').readAsBytesSync();
      final mod = WasmModule(data);
      print(mod.describe());
      final inst = mod.builder().build();
      final func = inst.lookupFunction('generate_master');
      print(func('','12',''));
    });
  });
}
