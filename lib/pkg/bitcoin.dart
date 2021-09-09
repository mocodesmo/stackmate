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
  Future<Nmeu> generateMaster(
      {required String mnemonic,
      required String passphrase,
      required String network}) async {
    final resp = await _bitcoin.generateMaster(
      mnemonic: mnemonic,
      passphrase: passphrase,
      network: network,
    );
    return resp;
  }

  @override
  Future<Nmeu> importMaster(
      {required String mnemonic,
      required String passphrase,
      required String network}) async {
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
  Future<Compile> compile(
      {required String policy, required String scriptType}) async {
    final resp = await _bitcoin.compile(
      policy: policy,
      scriptType: scriptType,
    );
    return resp;
  }

  @override
  Future<String> syncBalance(
      {required String depositDesc, required String network}) async {
    final resp = await _bitcoin.syncBalance(
      depositDesc: depositDesc,
      network: network,
    );
    return resp;
  }

  @override
  Future<String> getAddress(
      {required String depositDesc,
      required String network,
      required String index}) async {
    final resp = await _bitcoin.getAddress(
      depositDesc: depositDesc,
      network: network,
      index: index,
    );
    return resp;
  }

  @override
  Future<List<Transaction>> getHistory(
      {required String depositDesc,
      required String nodeAddress,
      required String network}) {
    // TODO: implement getHistory
    throw UnimplementedError();
  }
}

// class DummyBitcoin implements IBitcoin {
//   List<String> _w = [
//     'Donkey',
//     'Monkey',
//     'Dog',
//     'Cat',
//     'Tiger',
//     'Lion',
//     'Human',
//     'Bird',
//     'Insect',
//     'Ant',
//     'Lizard',
//     'Fish',
//   ];

//   @override
//   Future<String> generateMaster(
//       {required String mnemonic,
//       required String passphrase,
//       required String network}) async {
//     return 'abc';
//   }

//   @override
//   Future<String> signPsbt(
//       {required String fingerprint,
//       required String accountIndex,
//       required String xprv,
//       required String psbt}) async {
//     return '';
//   }

//   @override
//   Future<String> deriveHardened(
//       {required String masterXPriv,
//       required String account,
//       required String purpose}) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<String> getAddress(
//       {required String depositDesc,
//       required String changeDesc,
//       required String network,
//       required String index}) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<String> importMaster(
//       {required String mnemonic,
//       required String passphrase,
//       required String network}) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<String> syncBalance(
//       {required String depositDesc,
//       required String changeDesc,
//       required String network}) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<String> compile(
//       {required String policy, required String scriptType}) async {
//     return '';
//   }
// }
