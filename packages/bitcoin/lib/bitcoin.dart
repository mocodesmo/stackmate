import 'dart:ffi';

import 'package:bitcoin/ffi-types.dart';
import 'package:bitcoin/types.dart';
import 'package:ffi/ffi.dart';

export 'package:bitcoin/types.dart';

class BitcoinFFFI {
  BitcoinFFFI({required this.binary});

  final DynamicLibrary binary;

  Future<Nmeu> generateMaster({
    required String mnemonic,
    required String passphrase,
    required String network,
  }) async {
    final func = binary.lookupFunction<SeedT, SeedT>(
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
    final func = binary.lookupFunction<SeedT, SeedT>(
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
    final func = binary.lookupFunction<DeriveT, DeriveT>(
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
    final func = binary.lookupFunction<CompileT, CompileT>(
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
    required String network,
  }) async {
    final func = binary.lookupFunction<SyncT, SyncT>(
      'sync_balance',
    );
    final response = func(
      depositDesc.toNativeUtf8(),
      network.toNativeUtf8(),
    );
    return response.toDartString();
  }

  Future<String> getAddress({
    required String depositDesc,
    required String network,
    required String index,
  }) async {
    final func = binary.lookupFunction<AddressT, AddressT>(
      'get_address',
    );
    final resp = func(
      depositDesc.toNativeUtf8(),
      network.toNativeUtf8(),
      index.toNativeUtf8(),
    ).toDartString();
    if (resp.startsWith('Error')) throw resp;
    return resp;
  }

  Future<String> getHistory({
    required String depositDesc,
    required String network,
  }) async {
    final func = binary.lookupFunction<SyncT, SyncT>(
      'sync_history',
    );
    final resp = func(
      depositDesc.toNativeUtf8(),
      network.toNativeUtf8(),
    ).toDartString();
    if (resp.startsWith('Error')) throw resp;
    return resp;
  }
}
