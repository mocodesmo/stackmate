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
    );
  }

  @override
  void write(BinaryWriter writer, _$_Wallet obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.descriptor);
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
      label: json['label'] as String? ?? '',
      descriptor: json['descriptor'] as String? ?? '',
    );

Map<String, dynamic> _$$_WalletToJson(_$_Wallet instance) => <String, dynamic>{
      'label': instance.label,
      'descriptor': instance.descriptor,
    };
