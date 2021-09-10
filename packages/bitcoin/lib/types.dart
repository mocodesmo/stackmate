import 'dart:convert';

class Nmeu {
  Nmeu(this.mnemonic, this.fingerprint, this.xprv);

  final String mnemonic;
  final String fingerprint;
  final String xprv;

  factory Nmeu.fromJson(String data) {
    final json = jsonDecode(data);
    return Nmeu(
      json['mnemonic'] as String,
      json['fingerprint'] as String,
      json['xprv'] as String,
    );
  }

  List<String> get neuList => mnemonic.split(' ');
}

class Derive {
  Derive(this.fingerPrint, this.hardenedPath, this.xprv, this.xpub);

  final String fingerPrint;
  final String hardenedPath;
  final String xprv;
  final String xpub;

  factory Derive.fromJson(String data) {
    final json = jsonDecode(data);
    return Derive(
      json['fingerprint'] as String,
      json['hardened_path'] as String,
      json['xprv'] as String,
      json['xpub'] as String,
    );
  }

  String get policy => 'pk([$fingerPrint/$hardenedPath]$xprv/0/*)';
}

class Compile {
  Compile(this.policy, this.descriptor);

  final String policy;
  final String descriptor;

  factory Compile.fromJson(String data) {
    final json = jsonDecode(data);
    return Compile(
      json['policy'] as String,
      json['descriptor'] as String,
    );
  }
}
