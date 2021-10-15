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
    required String network,
    required String length,
    required String passphrase,
  }) async {
    final func = binary.lookupFunction<GenerateT, GenerateT>('generate_master');
    final resp = func(
      network.toNativeUtf8(),
      length.toNativeUtf8(),
      passphrase.toNativeUtf8(),
    ).toDartString();
    if (resp.startsWith('Error')) throw resp;
    return Nmeu.fromJson(resp);
  }

  Future<Nmeu> importMaster({
    required String network,
    required String mnemonic,
    required String passphrase,
  }) async {
    final func = binary.lookupFunction<ImportT, ImportT>('import_master');
    final resp = func(
      network.toNativeUtf8(),
      mnemonic.toNativeUtf8(),
      passphrase.toNativeUtf8(),
    ).toDartString();
    if (resp.startsWith('Error')) throw resp;
    return Nmeu.fromJson(resp);
  }

  Future<Derive> deriveHardened({
    required String masterXPriv,
    required String account,
    required String purpose,
  }) async {
    final func = binary.lookupFunction<DeriveT, DeriveT>('derive_hardened');
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
    final func = binary.lookupFunction<CompileT, CompileT>('compile');
    final resp = func(
      policy.toNativeUtf8(),
      scriptType.toNativeUtf8(),
    ).toDartString();
    if (resp.startsWith('Error')) throw resp;
    return Compile.fromJson(resp);
  }

  String getFees({
    required String network,
    required String nodeAddress,
    required String targetSize,
  }) {
    final func = binary.lookupFunction<FeesT, FeesT>('get_fees');
    final resp = func(
      network.toNativeUtf8(),
      nodeAddress.toNativeUtf8(),
      targetSize.toNativeUtf8(),
    ).toDartString();
    if (resp.startsWith('Error')) throw resp;
    return resp;
  }

  String syncBalance({
    required String depositDesc,
    required String nodeAddress,
  }) {
    final func = binary.lookupFunction<SyncT, SyncT>('sync_balance');
    final response = func(
      depositDesc.toNativeUtf8(),
      nodeAddress.toNativeUtf8(),
    );
    return response.toDartString();
  }

  String getHistory({
    required String depositDesc,
    required String nodeAddress,
  }) {
    final func = binary.lookupFunction<SyncT, SyncT>('sync_history');
    final resp = func(
      depositDesc.toNativeUtf8(),
      nodeAddress.toNativeUtf8(),
    ).toDartString();
    if (resp.startsWith('Error')) throw resp;
    return resp;
  }

  String getAddress({
    required String depositDesc,
    required String nodeAddress,
    required String index,
  }) {
    final func = binary.lookupFunction<AddressT, AddressT>('get_address');
    final resp = func(
      depositDesc.toNativeUtf8(),
      nodeAddress.toNativeUtf8(),
      index.toNativeUtf8(),
    ).toDartString();
    if (resp.startsWith('Error')) throw resp;
    final obj = jsonDecode(resp);

    return obj['address'] as String;
  }

  String buildTransaction({
    required String depositDesc,
    required String nodeAddress,
    required String toAddress,
    required String amount,
    required String feeRate,
  }) {
    final func = binary.lookupFunction<BuildT, BuildT>('build_tx');
    final resp = func(
      depositDesc.toNativeUtf8(),
      nodeAddress.toNativeUtf8(),
      toAddress.toNativeUtf8(),
      amount.toNativeUtf8(),
      feeRate.toNativeUtf8(),
    ).toDartString();
    if (resp.startsWith('Error')) throw resp;
    return resp;
  }

  String signTransaction({
    required String depositDesc,
    required String nodeAddress,
    required String unsignedPSBT,
  }) {
    final func = binary.lookupFunction<SignT, SignT>('sign_tx');
    final resp = func(
      depositDesc.toNativeUtf8(),
      nodeAddress.toNativeUtf8(),
      unsignedPSBT.toNativeUtf8(),
    ).toDartString();
    if (resp.startsWith('Error')) throw resp;
    return resp;
  }

  String broadcastTransaction({
    required String depositDesc,
    required String nodeAddress,
    required String signedPSBT,
  }) {
    final func = binary.lookupFunction<BroadcastT, BroadcastT>(
      'broadcast_tx',
    );
    final resp = func(
      depositDesc.toNativeUtf8(),
      nodeAddress.toNativeUtf8(),
      signedPSBT.toNativeUtf8(),
    ).toDartString();
    if (resp.startsWith('Error')) throw resp;
    return resp;
  }
}
