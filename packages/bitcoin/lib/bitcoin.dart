import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:bitcoin/ffi-types.dart';
import 'package:bitcoin/types.dart';
export 'package:bitcoin/types.dart';

class BitcoinFFFI {
  BitcoinFFFI({required this.binary});

  final DynamicLibrary binary;

  Future<Nmeu> generateMaster({
    required String mnemonic,
    required String passphrase,
    required String network,
  }) async {
    final func = binary.lookupFunction<seedT, seedT>(
      'generate_master',
    );
    final resp = func(
      mnemonic.toNativeUtf8(),
      passphrase.toNativeUtf8(),
      network.toNativeUtf8(),
    ).toDartString();
    if (resp.startsWith('Error')) throw resp;
    return Nmeu.fromJson(resp);
  }

  Future<Nmeu> importMaster({
    required String mnemonic,
    required String passphrase,
    required String network,
  }) async {
    final func = binary.lookupFunction<seedT, seedT>(
      'import_master',
    );
    final resp = func(
      mnemonic.toNativeUtf8(),
      passphrase.toNativeUtf8(),
      network.toNativeUtf8(),
    ).toDartString();
    if (resp.startsWith('Error')) throw resp;
    return Nmeu.fromJson(resp);
  }

  Future<Derive> deriveHardened({
    required String masterXPriv,
    required String account,
    required String purpose,
  }) async {
    final func = binary.lookupFunction<deriveT, deriveT>(
      'derive_hardened',
    );
    final resp = func(
      masterXPriv.toNativeUtf8(),
      purpose.toNativeUtf8(),
      account.toNativeUtf8(),
    ).toDartString();
    if (resp.startsWith('Error')) throw resp;
    return Derive.fromJson(resp);
  }

  Future<Compile> compile({
    required String policy,
    required String scriptType,
  }) async {
    final func = binary.lookupFunction<compileT, compileT>(
      'compile',
    );
    final resp = func(
      policy.toNativeUtf8(),
      scriptType.toNativeUtf8(),
    ).toDartString();
    if (resp.startsWith('Error')) throw resp;
    return Compile.fromJson(resp);
  }

  Future<String> syncBalance({
    required String depositDesc,
    required String changeDesc,
    required String network,
  }) async {
    final func = binary.lookupFunction<syncT, syncT>(
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
    final func = binary.lookupFunction<addressT, addressT>(
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
