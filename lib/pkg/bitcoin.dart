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

  Future<String> syncBalance({
    required String depositDesc,
    required String network,
  });

  Future<String> getAddress({
    required String depositDesc,
    required String network,
    required String index,
  });

  Future<List<Transaction>> getHistory({
    required String depositDesc,
    required String nodeAddress,
    required String network,
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
  Future<String> syncBalance({
    required String depositDesc,
    required String network,
  }) async {
    final resp = await _bitcoin.syncBalance(
      depositDesc: depositDesc,
      network: network,
    );
    return resp;
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
    for (final t in json['history'] as List<Map<String, dynamic>>) {
      transactions.add(Transaction.fromJson(t));
    }
    return transactions;
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
  Future<String> syncBalance({
    required String depositDesc,
    required String network,
  }) {
    // TODO: implement syncBalance
    throw UnimplementedError();
  }
}
