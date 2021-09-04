import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

typedef ffi_func3_master = Pointer<Utf8> Function(
  Pointer<Utf8> mnemonic,
  Pointer<Utf8> passphrase,
  Pointer<Utf8> network,
);
typedef ffi_func3_derive = Pointer<Utf8> Function(
  Pointer<Utf8> master_xprv,
  Pointer<Utf8> purpose,
  Pointer<Utf8> account,
);

typedef ffi_func2_compile = Pointer<Utf8> Function(
  Pointer<Utf8> policy,
  Pointer<Utf8> script_type,
);

typedef ffi_func3_sync = Pointer<Utf8> Function(
  Pointer<Utf8> deposit_desc,
  Pointer<Utf8> change_desc,
  Pointer<Utf8> network,
);

typedef ffi_func4_address = Pointer<Utf8> Function(
  Pointer<Utf8> deposit_desc,
  Pointer<Utf8> change_desc,
  Pointer<Utf8> network,
  Pointer<Utf8> index,
);

class BitcoinFFFI {
  final DynamicLibrary _lib = Platform.isAndroid
      ? DynamicLibrary.open('libditto.so')
      : DynamicLibrary.process();

  Future<String> generateMaster({
    required String mnemonic,
    required String passphrase,
    required String network,
  }) async {
    final func = _lib.lookupFunction<ffi_func3_master, ffi_func3_master>(
      'generate_master',
    );
    final response = func(
      mnemonic.toNativeUtf8(),
      passphrase.toNativeUtf8(),
      network.toNativeUtf8(),
    );
    return response.toDartString();
  }

  Future<String> importMaster({
    required String mnemonic,
    required String passphrase,
    required String network,
  }) async {
    final func = _lib.lookupFunction<ffi_func3_master, ffi_func3_master>(
      'import_master',
    );
    final response = func(
      mnemonic.toNativeUtf8(),
      passphrase.toNativeUtf8(),
      network.toNativeUtf8(),
    );
    return response.toDartString();
  }

  Future<String> deriveHardened({
    required String masterXPriv,
    required String account,
    required String purpose,
  }) async {
    final func = _lib.lookupFunction<ffi_func3_derive, ffi_func3_derive>(
      'derive_hardened',
    );
    final response = func(
      masterXPriv.toNativeUtf8(),
      purpose.toNativeUtf8(),
      account.toNativeUtf8(),
    );
    return response.toDartString();
  }

  Future<String> compile({
    required String policy,
    required String scriptType,
  }) async {
    final func = _lib.lookupFunction<ffi_func2_compile, ffi_func2_compile>(
      'compile',
    );
    final response = func(
      policy.toNativeUtf8(),
      scriptType.toNativeUtf8(),
    );
    return response.toDartString();
  }

  Future<String> syncBalance({
    required String depositDesc,
    required String changeDesc,
    required String network,
  }) async {
    final func = _lib.lookupFunction<ffi_func3_sync, ffi_func3_sync>(
      'sync_balance',
    );
    final response = func(
      depositDesc.toNativeUtf8(),
      changeDesc.toNativeUtf8(),
      network.toNativeUtf8(),
    );
    return response.toDartString();
  }

  Future<String> getAddress(
      {required String depositDesc,
      required String changeDesc,
      required String network,
      required String index}) async {
    final func = _lib.lookupFunction<ffi_func4_address, ffi_func4_address>(
      'get_address',
    );
    final response = func(
      depositDesc.toNativeUtf8(),
      changeDesc.toNativeUtf8(),
      network.toNativeUtf8(),
      index.toNativeUtf8(),
    );
    return response.toDartString();
  }
}
