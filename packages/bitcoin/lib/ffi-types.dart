import 'dart:ffi';
export 'package:bitcoin/types.dart';
import 'package:ffi/ffi.dart';


typedef seedT = Pointer<Utf8> Function(
  Pointer<Utf8> mnemonic,
  Pointer<Utf8> passphrase,
  Pointer<Utf8> network,
);

typedef deriveT = Pointer<Utf8> Function(
  Pointer<Utf8> master_xprv,
  Pointer<Utf8> purpose,
  Pointer<Utf8> account,
);

typedef compileT = Pointer<Utf8> Function(
  Pointer<Utf8> policy,
  Pointer<Utf8> script_type,
);

typedef syncT = Pointer<Utf8> Function(
  Pointer<Utf8> deposit_desc,
  Pointer<Utf8> change_desc,
  Pointer<Utf8> network,
);

typedef addressT = Pointer<Utf8> Function(
  Pointer<Utf8> deposit_desc,
  Pointer<Utf8> change_desc,
  Pointer<Utf8> network,
  Pointer<Utf8> index,
);