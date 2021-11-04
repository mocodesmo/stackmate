// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';
import 'package:bitcoin/bitcoin.dart';
import 'package:ffi/ffi.dart';

typedef GenerateT = Pointer<Utf8> Function(
  Pointer<Utf8> network,
  Pointer<Utf8> length,
  Pointer<Utf8> passphrase,
);

typedef ImportT = Pointer<Utf8> Function(
  Pointer<Utf8> network,
  Pointer<Utf8> mnemonic,
  Pointer<Utf8> passphrase,
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
  Pointer<Utf8> node_address,
);

typedef AddressT = Pointer<Utf8> Function(
  Pointer<Utf8> deposit_desc,
  Pointer<Utf8> node_address,
  Pointer<Utf8> index,
);

typedef BuildT = Pointer<Utf8> Function(
  Pointer<Utf8> deposit_desc,
  Pointer<Utf8> node_address,
  Pointer<Utf8> to_address,
  Pointer<Utf8> amount,
  Pointer<Utf8> fee_rate,
  Pointer<Utf8> sweep,
);

typedef DecodeT = Pointer<Utf8> Function(
  Pointer<Utf8> network,
  Pointer<Utf8> upsbt,
);

typedef SignT = Pointer<Utf8> Function(
  Pointer<Utf8> deposit_desc,
  Pointer<Utf8> node_address,
  Pointer<Utf8> unsigned_psbt,
);

typedef BroadcastT = Pointer<Utf8> Function(
  Pointer<Utf8> deposit_desc,
  Pointer<Utf8> node_address,
  Pointer<Utf8> signed_psbt,
);

typedef EstimateFeeT = Pointer<Utf8> Function(
  Pointer<Utf8> network,
  Pointer<Utf8> node_address,
  Pointer<Utf8> target_size,
);

typedef WeightT = Pointer<Utf8> Function(
  Pointer<Utf8> deposit_desc,
  Pointer<Utf8> psbt,
);

typedef AbsoluteFeeT = Pointer<Utf8> Function(
  Pointer<Utf8> fee_rate,
  Pointer<Utf8> weight,
);
