// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Log _$$_LogFromJson(Map<String, dynamic> json) => _$_Log(
      type: _$enumDecode(_$LogTypeEnumMap, json['type']),
      path: json['path'] as String?,
      response: json['response'] as String?,
      statusCode: json['statusCode'] as String?,
      bloc: json['bloc'] as String?,
      event: json['event'] as String?,
      exceptionType: json['exceptionType'] as String?,
      exceptionSource: json['exceptionSource'] as String?,
      stackTrace: json['stackTrace'] as String?,
    );

Map<String, dynamic> _$$_LogToJson(_$_Log instance) => <String, dynamic>{
      'type': _$LogTypeEnumMap[instance.type],
      'path': instance.path,
      'response': instance.response,
      'statusCode': instance.statusCode,
      'bloc': instance.bloc,
      'event': instance.event,
      'exceptionType': instance.exceptionType,
      'exceptionSource': instance.exceptionSource,
      'stackTrace': instance.stackTrace,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$LogTypeEnumMap = {
  LogType.api: 'api',
  LogType.event: 'event',
  LogType.exception: 'exception',
};
