// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:ffi/ffi.dart';

export 'package:bitcoin/types.dart';

typedef SeedT = Pointer<Utf8> Function(
  Pointer<Utf8> mnemonic,
  Pointer<Utf8> passphrase,
  Pointer<Utf8> network,
);

typedef DeriveT = Pointer<Utf8> Function(
  Pointer<Utf8> master_xprv,
  Pointer<Utf8> purpose,
  Pointer<Utf8> account,
);

typedef CompileT = Pointer<Utf8> Function(
  Pointer<Utf8> policy,
  Pointer<Utf8> script_type,
);

typedef SyncT = Pointer<Utf8> Function(
  Pointer<Utf8> deposit_desc,
  Pointer<Utf8> network,
);

typedef AddressT = Pointer<Utf8> Function(
  Pointer<Utf8> deposit_desc,
  Pointer<Utf8> network,
  Pointer<Utf8> index,
);

typedef FeesT = Pointer<Utf8> Function(
  Pointer<Utf8> target_size,
  Pointer<Utf8> network,
);

typedef BuildT = Pointer<Utf8> Function(
  Pointer<Utf8> deposit_desc,
  Pointer<Utf8> network,
  Pointer<Utf8> to_address,
  Pointer<Utf8> amount,
  Pointer<Utf8> fee_rate,
);

typedef SignT = Pointer<Utf8> Function(
  Pointer<Utf8> deposit_desc,
  Pointer<Utf8> network,
  Pointer<Utf8> unsigned_psbt,
);

typedef BroadcastT = Pointer<Utf8> Function(
  Pointer<Utf8> deposit_desc,
  Pointer<Utf8> network,
  Pointer<Utf8> signed_psbt,
);
