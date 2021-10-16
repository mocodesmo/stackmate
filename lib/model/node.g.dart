// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NodeTypeClassAdaper extends TypeAdapter<NodeType> {
  @override
  final int typeId = 22;

  @override
  NodeType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NodeType.electrum;
      case 1:
        return NodeType.bitcoincore;
      default:
        return NodeType.electrum;
    }
  }

  @override
  void write(BinaryWriter writer, NodeType obj) {
    switch (obj) {
      case NodeType.electrum:
        writer.writeByte(0);
        break;
      case NodeType.bitcoincore:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NodeTypeClassAdaper &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NodeClassAdaper extends TypeAdapter<_$_Node> {
  @override
  final int typeId = 5;

  @override
  _$_Node read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Node(
      nodeType: fields[0] as NodeType,
      address: fields[1] as String,
      port: fields[2] as String,
      username: fields[3] as String,
      password: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Node obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.nodeType)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.port)
      ..writeByte(3)
      ..write(obj.username)
      ..writeByte(4)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NodeClassAdaper &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Node _$$_NodeFromJson(Map<String, dynamic> json) => _$_Node(
      nodeType: _$enumDecode(_$NodeTypeEnumMap, json['nodeType']),
      address: json['address'] as String,
      port: json['port'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$_NodeToJson(_$_Node instance) => <String, dynamic>{
      'nodeType': _$NodeTypeEnumMap[instance.nodeType],
      'address': instance.address,
      'port': instance.port,
      'username': instance.username,
      'password': instance.password,
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

const _$NodeTypeEnumMap = {
  NodeType.electrum: 'electrum',
  NodeType.bitcoincore: 'bitcoincore',
};
