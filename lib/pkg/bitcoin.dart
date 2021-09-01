import 'package:bitcoin/bitcoin.dart';

abstract class IBitcoin {
  Future<String> generateMaster({
    required String mnemonic,
    required String passphrase,
    required String network,
  });

  Future<String> importMaster({
    required String mnemonic,
    required String passphrase,
    required String network,
  });

  Future<String> deriveHardened({
    required String masterXPriv,
    required String account,
    required String purpose,
  });

  Future<String> syncBalance({
    required String depositDesc,
    required String changeDesc,
    required String network,
  });

  Future<String> getAddress({
    required String depositDesc,
    required String changeDesc,
    required String network,
    required String index,
  });
}

class BitcoinFFI implements IBitcoin {
  final _bitcoin = BitcoinFFFI();

  @override
  Future<String> generateMaster(
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
  Future<String> importMaster(
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
  Future<String> deriveHardened({
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
  Future<String> syncBalance(
      {required String depositDesc,
      required String changeDesc,
      required String network}) async {
    final resp = await _bitcoin.syncBalance(
      depositDesc: depositDesc,
      changeDesc: changeDesc,
      network: network,
    );
    return resp;
  }

  @override
  Future<String> getAddress(
      {required String depositDesc,
      required String changeDesc,
      required String network,
      required String index}) async {
    final resp = await _bitcoin.getAddress(
      depositDesc: depositDesc,
      changeDesc: changeDesc,
      network: network,
      index: index,
    );
    return resp;
  }
}

class DummyBitcoin implements IBitcoin {
  List<String> _w = [
    'Donkey',
    'Monkey',
    'Dog',
    'Cat',
    'Tiger',
    'Lion',
    'Human',
    'Bird',
    'Insect',
    'Ant',
    'Lizard',
    'Fish',
  ];

  @override
  Future<String> generateMaster(
      {required String mnemonic,
      required String passphrase,
      required String network}) async {
    return 'abc';
  }

  @override
  Future<String> signPsbt(
      {required String fingerprint,
      required String accountIndex,
      required String xprv,
      required String psbt}) async {
    return '';
  }

  @override
  Future<String> deriveHardened(
      {required String masterXPriv,
      required String account,
      required String purpose}) {
    throw UnimplementedError();
  }

  @override
  Future<String> getAddress(
      {required String depositDesc,
      required String changeDesc,
      required String network,
      required String index}) {
    throw UnimplementedError();
  }

  @override
  Future<String> importMaster(
      {required String mnemonic,
      required String passphrase,
      required String network}) {
    throw UnimplementedError();
  }

  @override
  Future<String> syncBalance(
      {required String depositDesc,
      required String changeDesc,
      required String network}) {
    throw UnimplementedError();
  }
}
