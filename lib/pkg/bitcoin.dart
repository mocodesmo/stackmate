import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:bitcoin/bitcoin.dart';
import 'package:sats/model/transaction.dart';

abstract class IBitcoin {
  Future<Nmeu> generateMaster({
    required String length,
    required String passphrase,
    required String network,
  });

  Future<Nmeu> importMaster({
    required String mnemonic,
    required String passphrase,
    required String network,
  });

  Future<Derive> deriveHardened({
    required String masterXPriv,
    required String account,
    required String purpose,
  });

  Future<Compile> compile({
    required String policy,
    required String scriptType,
  });

  double getFees({
    required String targetSize,
    required String network,
    required String nodeAddress,
  });

  int syncBalance({
    required String depositDesc,
    required String nodeAddress,
  });

  List<Transaction> getHistory({
    required String depositDesc,
    required String nodeAddress,
  });

  String getAddress({
    required String depositDesc,
    required String nodeAddress,
    required String index,
  });

  String buildTransaction({
    required String depositDesc,
    required String nodeAddress,
    required String toAddress,
    required String amount,
    required String feeRate,
  });

  String signTransaction({
    required String depositDesc,
    required String nodeAddress,
    required String unsignedPSBT,
  });

  String broadcastTransaction({
    required String depositDesc,
    required String nodeAddress,
    required String signedPSBT,
  });
}

class BitcoinFFI implements IBitcoin {
  final _bitcoin = BitcoinFFFI(
    binary: Platform.isAndroid
        ? DynamicLibrary.open('libditto.so')
        : DynamicLibrary.process(),
  );

  @override
  Future<Nmeu> generateMaster({
    required String length,
    required String passphrase,
    required String network,
  }) async {
    final resp = await _bitcoin.generateMaster(
      length: length,
      passphrase: passphrase,
      network: network,
    );
    return resp;
  }

  @override
  Future<Nmeu> importMaster({
    required String mnemonic,
    required String passphrase,
    required String network,
  }) async {
    final resp = await _bitcoin.importMaster(
      mnemonic: mnemonic,
      passphrase: passphrase,
      network: network,
    );
    return resp;
  }

  @override
  Future<Derive> deriveHardened({
    required String masterXPriv,
    required String account,
    required String purpose,
  }) async {
    final resp = await _bitcoin.deriveHardened(
      masterXPriv: masterXPriv,
      account: account,
      purpose: purpose,
    );
    return resp;
  }

  @override
  Future<Compile> compile({
    required String policy,
    required String scriptType,
  }) async {
    final resp = await _bitcoin.compile(
      policy: policy,
      scriptType: scriptType,
    );
    return resp;
  }

  @override
  int syncBalance({
    required String depositDesc,
    required String nodeAddress,
  }) {
    final resp = _bitcoin.syncBalance(
      depositDesc: depositDesc,
      nodeAddress: nodeAddress,
    );
    final bal = jsonDecode(resp)['balance'];

    return bal as int;
  }

  @override
  String getAddress({
    required String depositDesc,
    required String nodeAddress,
    required String index,
  }) {
    final resp = _bitcoin.getAddress(
      depositDesc: depositDesc,
      nodeAddress: nodeAddress,
      index: index,
    );
    return resp;
  }

  @override
  List<Transaction> getHistory({
    required String depositDesc,
    required String nodeAddress,
  }) {
    final resp = _bitcoin.getHistory(
      depositDesc: depositDesc,
      nodeAddress: nodeAddress,
    );
    final json = jsonDecode(resp);
    final List<Transaction> transactions = [];
    for (final t in json['history'] as List) {
      transactions.add(Transaction.fromJson(t as Map<String, dynamic>));
    }
    return transactions;
  }

  @override
  double getFees({
    required String targetSize,
    required String network,
    required String nodeAddress,
  }) {
    final resp = _bitcoin.getFees(
      targetSize: targetSize,
      network: network,
      nodeAddress: nodeAddress,
    );
    final data = jsonDecode(resp);
    return data['fee'] as double;
  }

  @override
  String buildTransaction({
    required String depositDesc,
    required String nodeAddress,
    required String toAddress,
    required String amount,
    required String feeRate,
  }) {
    final resp = _bitcoin.buildTransaction(
      depositDesc: depositDesc,
      nodeAddress: nodeAddress,
      toAddress: toAddress,
      amount: amount,
      feeRate: feeRate,
    );
    final data = jsonDecode(resp);
    return data['psbt'] as String;
  }

  @override
  String signTransaction({
    required String depositDesc,
    required String nodeAddress,
    required String unsignedPSBT,
  }) {
    final resp = _bitcoin.signTransaction(
      depositDesc: depositDesc,
      nodeAddress: nodeAddress,
      unsignedPSBT: unsignedPSBT,
    );
    final data = jsonDecode(resp);
    return data['psbt'] as String;
  }

  @override
  String broadcastTransaction({
    required String depositDesc,
    required String nodeAddress,
    required String signedPSBT,
  }) {
    final resp = _bitcoin.broadcastTransaction(
      depositDesc: depositDesc,
      nodeAddress: nodeAddress,
      signedPSBT: signedPSBT,
    );
    final data = jsonDecode(resp);
    return data['txid'] as String;
  }
}
