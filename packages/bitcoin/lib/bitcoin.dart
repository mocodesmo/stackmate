import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:bitcoin/ffi-types.dart';
import 'package:bitcoin/types.dart';
import 'package:ffi/ffi.dart';
// import 'package:isolate/ports.dart';

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

  String syncBalance({
    required String depositDesc,
    required String network,
  }) {
    final func = binary.lookupFunction<SyncT, SyncT>(
      'sync_balance',
    );
    final response = func(
      depositDesc.toNativeUtf8(),
      network.toNativeUtf8(),
    );
    return response.toDartString();
  }

  String getAddress({
    required String depositDesc,
    required String network,
    required String index,
  }) {
    final func = binary.lookupFunction<AddressT, AddressT>(
      'get_address',
      // isLeaf: true,
    );
    final resp = func(
      depositDesc.toNativeUtf8(),
      network.toNativeUtf8(),
      index.toNativeUtf8(),
    ).toDartString();
    if (resp.startsWith('Error')) throw resp;
    final obj = jsonDecode(resp);

    return obj['address'] as String;
  }

  String getHistory({
    required String depositDesc,
    required String network,
  }) {
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

  String getFees({
    required String targetSize,
    required String network,
  }) {
    final func = binary.lookupFunction<SyncT, SyncT>(
      'get_fees',
    );
    final resp = func(
      targetSize.toNativeUtf8(),
      network.toNativeUtf8(),
    ).toDartString();
    if (resp.startsWith('Error')) throw resp;
    return resp;
  }

  String buildTransaction({
    required String depositDesc,
    required String network,
    required String toAddress,
    required String amount,
    required String feeRate,
  }) {
    final func = binary.lookupFunction<BuildT, BuildT>(
      'build_tx',
    );
    final resp = func(
      depositDesc.toNativeUtf8(),
      network.toNativeUtf8(),
      toAddress.toNativeUtf8(),
      amount.toNativeUtf8(),
      feeRate.toNativeUtf8(),
    ).toDartString();
    if (resp.startsWith('Error')) throw resp;
    return resp;
  }

  String signTransaction({
    required String depositDesc,
    required String network,
    required String unsignedPSBT,
  }) {
    final func = binary.lookupFunction<SignT, SignT>(
      'sign_tx',
    );
    final resp = func(
      depositDesc.toNativeUtf8(),
      network.toNativeUtf8(),
      unsignedPSBT.toNativeUtf8(),
    ).toDartString();
    if (resp.startsWith('Error')) throw resp;
    return resp;
  }

  String broadcastTransaction({
    required String depositDesc,
    required String network,
    required String signedPSBT,
  }) {
    final func = binary.lookupFunction<BroadcastT, BroadcastT>(
      'broadcast_tx',
    );
    final resp = func(
      depositDesc.toNativeUtf8(),
      network.toNativeUtf8(),
      signedPSBT.toNativeUtf8(),
    ).toDartString();
    if (resp.startsWith('Error')) throw resp;
    return resp;
  }
}
