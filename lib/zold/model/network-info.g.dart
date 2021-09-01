// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network-info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NetworkInfo _$$_NetworkInfoFromJson(Map<String, dynamic> json) =>
    _$_NetworkInfo(
      traffic: json['traffic'] as String? ?? '',
      fees: json['fees'] == null
          ? const Fee()
          : Fee.fromJson(json['fees'] as Map<String, dynamic>),
      mempool_size: json['mempool_size'] as int? ?? 0,
      chain: json['chain'] as String? ?? '',
      blocks: json['blocks'] as int? ?? 0,
    );

Map<String, dynamic> _$$_NetworkInfoToJson(_$_NetworkInfo instance) =>
    <String, dynamic>{
      'traffic': instance.traffic,
      'fees': instance.fees,
      'mempool_size': instance.mempool_size,
      'chain': instance.chain,
      'blocks': instance.blocks,
    };

_$_Fee _$$_FeeFromJson(Map<String, dynamic> json) => _$_Fee(
      slow: json['low'] as int? ?? 0,
      medium: json['medium'] as int? ?? 0,
      high: json['high'] as int? ?? 0,
    );

Map<String, dynamic> _$$_FeeToJson(_$_Fee instance) => <String, dynamic>{
      'low': instance.slow,
      'medium': instance.medium,
      'high': instance.high,
    };
