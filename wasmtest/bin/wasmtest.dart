import 'dart:io';

import 'package:wasm/wasm.dart';

void main(List<String> arguments) {
  final data =
      File('/Users/mj/code/stackmate/wasmtest/stackmate.wasm').readAsBytesSync();
  final mod = WasmModule(data);
  // print(mod.describe());
  final inst = mod.builder().build();
  final func = inst.lookupFunction('generate_master');
  print(func('', '12', ''));
}
