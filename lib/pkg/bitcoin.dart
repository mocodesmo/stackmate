import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:bitcoin/bitcoin.dart';
import 'package:sats/model/transaction.dart';

abstract class IBitcoin {
  Future<Nmeu> generateMaster({
    required String mnemonic,
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

  Future<int> syncBalance({
    required String depositDesc,
    required String network,
  });

  int syncBalanceF({
    required String depositDesc,
    required String network,
  });

  Future<String> getAddress({
    required String depositDesc,
    required String network,
    required String index,
  });

  String getAddressF({
    required String depositDesc,
    required String network,
    required String index,
  });

  Future<List<Transaction>> getHistory({
    required String depositDesc,
    required String nodeAddress,
    required String network,
  });

  List<Transaction> getHistoryF({
    required String depositDesc,
    required String nodeAddress,
    required String network,
  });

  Future<double> getFees({
    required String targetSize,
    required String network,
  });

  Future<String> buildTransaction({
    required String depositDesc,
    required String network,
    required String toAddress,
    required String amount,
    required String feeRate,
  });

  Future<String> signTransaction({
    required String depositDesc,
    required String network,
    required String unsignedPSBT,
  });

  Future<String> broadcastTransaction({
    required String depositDesc,
    required String network,
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
    required String mnemonic,
    required String passphrase,
    required String network,
  }) async {
    final resp = await _bitcoin.generateMaster(
      mnemonic: mnemonic,
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
  Future<int> syncBalance({
    required String depositDesc,
    required String network,
  }) async {
    final resp = await _bitcoin.syncBalance(
      depositDesc: depositDesc,
      network: network,
    );
    final bal = jsonDecode(resp)['balance'];

    return bal as int;
  }

  @override
  Future<String> getAddress({
    required String depositDesc,
    required String network,
    required String index,
  }) async {
    final resp = await _bitcoin.getAddress(
      depositDesc: depositDesc,
      network: network,
      index: index,
    );
    return resp;
  }

  @override
  Future<List<Transaction>> getHistory({
    required String depositDesc,
    required String nodeAddress,
    required String network,
  }) async {
    final resp = await _bitcoin.getHistory(
      depositDesc: depositDesc,
      network: network,
    );
    final json = jsonDecode(resp);
    final List<Transaction> transactions = [];
    for (final t in json['history'] as List) {
      transactions.add(Transaction.fromJson(t as Map<String, dynamic>));
    }
    return transactions;
  }

  @override
  Future<double> getFees({
    required String targetSize,
    required String network,
  }) async {
    final resp = await _bitcoin.getFees(
      targetSize: targetSize,
      network: network,
    );
    final data = jsonDecode(resp);
    return data['fee'] as double;
  }

  @override
  Future<String> buildTransaction({
    required String depositDesc,
    required String network,
    required String toAddress,
    required String amount,
    required String feeRate,
  }) async {
    final resp = await _bitcoin.buildTransaction(
      depositDesc: depositDesc,
      network: network,
      toAddress: toAddress,
      amount: amount,
      feeRate: feeRate,
    );
    final data = jsonDecode(resp);
    return data['psbt'] as String;
  }

  @override
  Future<String> signTransaction({
    required String depositDesc,
    required String network,
    required String unsignedPSBT,
  }) async {
    final resp = await _bitcoin.signTransaction(
      depositDesc: depositDesc,
      network: network,
      unsignedPSBT: unsignedPSBT,
    );
    final data = jsonDecode(resp);
    return data['psbt'] as String;
  }

  @override
  Future<String> broadcastTransaction({
    required String depositDesc,
    required String network,
    required String signedPSBT,
  }) async {
    final resp = await _bitcoin.broadcastTransaction(
      depositDesc: depositDesc,
      network: network,
      signedPSBT: signedPSBT,
    );
    final data = jsonDecode(resp);
    return data['txid'] as String;
  }

  @override
  String getAddressF({
    required String depositDesc,
    required String network,
    required String index,
  }) {
    final resp = _bitcoin.getAddressF(
      depositDesc: depositDesc,
      network: network,
      index: index,
    );
    return resp;
  }

  @override
  List<Transaction> getHistoryF({
    required String depositDesc,
    required String nodeAddress,
    required String network,
  }) {
    final resp = _bitcoin.getHistoryF(
      depositDesc: depositDesc,
      network: network,
    );
    final json = jsonDecode(resp);
    final List<Transaction> transactions = [];
    for (final t in json['history'] as List) {
      transactions.add(Transaction.fromJson(t as Map<String, dynamic>));
    }
    return transactions;
  }

  @override
  int syncBalanceF({required String depositDesc, required String network}) {
    final resp = _bitcoin.syncBalanceF(
      depositDesc: depositDesc,
      network: network,
    );
    final bal = jsonDecode(resp)['balance'];

    return bal as int;
  }
}

class DummyBtc implements IBitcoin {
  @override
  Future<Compile> compile({
    required String policy,
    required String scriptType,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Derive> deriveHardened({
    required String masterXPriv,
    required String account,
    required String purpose,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Nmeu> generateMaster({
    required String mnemonic,
    required String passphrase,
    required String network,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<String> getAddress({
    required String depositDesc,
    required String network,
    required String index,
  }) async {
    return '1F1tAaz5x1HUXrCNLbtMDqcw6o5GNn4xqX';
  }

  @override
  Future<List<Transaction>> getHistory({
    required String depositDesc,
    required String nodeAddress,
    required String network,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return const [
      Transaction(
        timestamp: 9877766,
        height: 88,
        verified: true,
        txid:
            '32b942eeede3c6d51b79ac83e59436819d52b513cd43cabbb9731d3a004eee77',
        received: 50000,
        sent: 0,
        fee: 5000,
      ),
      Transaction(
        timestamp: 9877766,
        height: 88,
        verified: true,
        txid:
            '32b942eeede3c6d51b79ac83e59436819d52b513cd43cabbb9731d3a004eee77',
        received: 0,
        sent: 50000,
        fee: 5000,
      ),
      Transaction(
        timestamp: 9877766,
        height: 88,
        verified: true,
        txid:
            '32b942eeede3c6d51b79ac83e59436819d52b513cd43cabbb9731d3a004eee77',
        received: 50000,
        sent: 0,
        fee: 5000,
      ),
      Transaction(
        timestamp: 9877766,
        height: 88,
        verified: true,
        txid:
            '32b942eeede3c6d51b79ac83e59436819d52b513cd43cabbb9731d3a004eee77',
        received: 50000,
        sent: 0,
        fee: 5000,
      ),
      Transaction(
        timestamp: 9877766,
        height: 88,
        verified: true,
        txid:
            '32b942eeede3c6d51b79ac83e59436819d52b513cd43cabbb9731d3a004eee77',
        received: 50000,
        sent: 0,
        fee: 5000,
      ),
      Transaction(
        timestamp: 9877766,
        height: 88,
        verified: true,
        txid:
            '32b942eeede3c6d51b79ac83e59436819d52b513cd43cabbb9731d3a004eee77',
        received: 50000,
        sent: 0,
        fee: 5000,
      ),
      Transaction(
        timestamp: 9877766,
        height: 88,
        verified: true,
        txid:
            '32b942eeede3c6d51b79ac83e59436819d52b513cd43cabbb9731d3a004eee77',
        received: 50000,
        sent: 0,
        fee: 5000,
      ),
    ];
  }

  @override
  Future<Nmeu> importMaster({
    required String mnemonic,
    required String passphrase,
    required String network,
  }) {
    // TODO: implement importMaster
    throw UnimplementedError();
  }

  @override
  Future<int> syncBalance({
    required String depositDesc,
    required String network,
  }) {
    // TODO: implement syncBalance
    throw UnimplementedError();
  }

  @override
  Future<String> broadcastTransaction(
      {required String depositDesc,
      required String network,
      required String signedPSBT}) {
    // TODO: implement broadcastTransaction
    throw UnimplementedError();
  }

  @override
  Future<String> buildTransaction({
    required String depositDesc,
    required String network,
    required String toAddress,
    required String amount,
    required String feeRate,
  }) {
    // TODO: implement buildTransaction
    throw UnimplementedError();
  }

  @override
  Future<double> getFees(
      {required String targetSize, required String network}) {
    // TODO: implement getFees
    throw UnimplementedError();
  }

  @override
  Future<String> signTransaction(
      {required String depositDesc,
      required String network,
      required String unsignedPSBT}) {
    // TODO: implement signTransaction
    throw UnimplementedError();
  }

  @override
  String getAddressF(
      {required String depositDesc,
      required String network,
      required String index}) {
    // TODO: implement getAddressF
    throw UnimplementedError();
  }

  @override
  List<Transaction> getHistoryF(
      {required String depositDesc,
      required String nodeAddress,
      required String network}) {
    // TODO: implement getHistoryF
    throw UnimplementedError();
  }

  @override
  int syncBalanceF({required String depositDesc, required String network}) {
    // TODO: implement syncBalanceF
    throw UnimplementedError();
  }
}
