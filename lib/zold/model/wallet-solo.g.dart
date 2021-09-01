// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet-solo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SoloWallet _$$_SoloWalletFromJson(Map<String, dynamic> json) =>
    _$_SoloWallet(
      genesis: json['genesis'] as int? ?? 0,
      nickname: json['nickname'] as String? ?? '',
      fingerprint: json['fingerprint'] as String? ?? '',
      path: json['path'] as String? ?? '',
      xpub: json['xpub'] as String? ?? '',
      address: json['address'] as String? ?? '',
      label: json['label'] as String? ?? '',
      index: json['index'] as int? ?? 0,
      watchOnly: json['watchOnly'] as bool? ?? true,
      balances: json['balances'] == null
          ? const WalletBalances()
          : WalletBalances.fromJson(json['balances'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SoloWalletToJson(_$_SoloWallet instance) =>
    <String, dynamic>{
      'genesis': instance.genesis,
      'nickname': instance.nickname,
      'fingerprint': instance.fingerprint,
      'path': instance.path,
      'xpub': instance.xpub,
      'address': instance.address,
      'label': instance.label,
      'index': instance.index,
      'watchOnly': instance.watchOnly,
      'balances': instance.balances,
    };

_$_WalletBalances _$$_WalletBalancesFromJson(Map<String, dynamic> json) =>
    _$_WalletBalances(
      confirmed: json['confirmed'] as int? ?? 0,
      unconfirmed: json['unconfirmed'] as int? ?? 0,
    );

Map<String, dynamic> _$$_WalletBalancesToJson(_$_WalletBalances instance) =>
    <String, dynamic>{
      'confirmed': instance.confirmed,
      'unconfirmed': instance.unconfirmed,
    };
