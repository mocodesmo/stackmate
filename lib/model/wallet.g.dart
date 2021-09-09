// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalletClassAdaper extends TypeAdapter<_$_Wallet> {
  @override
  final int typeId = 1;

  @override
  _$_Wallet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Wallet(
      label: fields[0] as String,
      descriptor: fields[2] as String,
      blockchain: fields[3] as Blockchain,
      transactions: (fields[4] as List?)?.cast<Transaction>(),
      index: fields[5] as int,
      balance: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Wallet obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.descriptor)
      ..writeByte(3)
      ..write(obj.blockchain)
      ..writeByte(4)
      ..write(obj.transactions)
      ..writeByte(5)
      ..write(obj.index)
      ..writeByte(6)
      ..write(obj.balance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletClassAdaper &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Wallet _$$_WalletFromJson(Map<String, dynamic> json) => _$_Wallet(
      label: json['label'] as String,
      descriptor: json['descriptor'] as String,
      blockchain: _$enumDecode(_$BlockchainEnumMap, json['blockchain']),
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      index: json['index'] as int,
      balance: json['balance'] as int?,
    );

Map<String, dynamic> _$$_WalletToJson(_$_Wallet instance) => <String, dynamic>{
      'label': instance.label,
      'descriptor': instance.descriptor,
      'blockchain': _$BlockchainEnumMap[instance.blockchain],
      'transactions': instance.transactions,
      'index': instance.index,
      'balance': instance.balance,
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

const _$BlockchainEnumMap = {
  Blockchain.mainNet: 'mainNet',
  Blockchain.testNet: 'testNet',
};
