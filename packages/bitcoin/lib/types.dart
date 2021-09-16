import 'dart:convert';

class Nmeu {
  const Nmeu(this.mnemonic, this.fingerprint, this.xprv);
  factory Nmeu.fromJson(String data) {
    final json = jsonDecode(data);
    return Nmeu(
      json['mnemonic'] as String,
      json['fingerprint'] as String,
      json['xprv'] as String,
    );
  }
  final String mnemonic;
  final String fingerprint;
  final String xprv;

  List<String> get neuList => mnemonic.split(' ');
}

class Derive {
  const Derive(this.fingerPrint, this.hardenedPath, this.xprv, this.xpub);
  factory Derive.fromJson(String data) {
    final json = jsonDecode(data);
    return Derive(
      json['fingerprint'] as String,
      json['hardened_path'] as String,
      json['xprv'] as String,
      json['xpub'] as String,
    );
  }
  final String fingerPrint;
  final String hardenedPath;
  final String xprv;
  final String xpub;

  String get policy =>
      'pk([$fingerPrint/$hardenedPath]$xprv/0/*)'.replaceFirst('/m', '');
}

class Compile {
  const Compile(this.policy, this.descriptor);
  factory Compile.fromJson(String data) {
    final json = jsonDecode(data);
    return Compile(
      json['policy'] as String,
      json['descriptor'] as String,
    );
  }

  final String policy;
  final String descriptor;
}
