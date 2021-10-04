// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address-book.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddressBookUserClassAdaper extends TypeAdapter<_$_AddressBookUser> {
  @override
  final int typeId = 5;

  @override
  _$_AddressBookUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_AddressBookUser(
      id: fields[2] as int?,
      name: fields[0] as String,
      keys: (fields[1] as List?)?.cast<AddressBookKey>(),
    );
  }

  @override
  void write(BinaryWriter writer, _$_AddressBookUser obj) {
    writer
      ..writeByte(3)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.keys);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressBookUserClassAdaper &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AddressBookValueClassAdaper extends TypeAdapter<_$_AddressBookKey> {
  @override
  final int typeId = 6;

  @override
  _$_AddressBookKey read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_AddressBookKey(
      name: fields[0] as String,
      publicKey: fields[1] as String,
      createdAt: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, _$_AddressBookKey obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.publicKey)
      ..writeByte(2)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressBookValueClassAdaper &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AddressBookUser _$$_AddressBookUserFromJson(Map<String, dynamic> json) =>
    _$_AddressBookUser(
      id: json['id'] as int?,
      name: json['name'] as String,
      keys: (json['keys'] as List<dynamic>?)
          ?.map((e) => AddressBookKey.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_AddressBookUserToJson(_$_AddressBookUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'keys': instance.keys,
    };

_$_AddressBookKey _$$_AddressBookKeyFromJson(Map<String, dynamic> json) =>
    _$_AddressBookKey(
      name: json['name'] as String,
      publicKey: json['publicKey'] as String,
      createdAt: json['createdAt'] as int,
    );

Map<String, dynamic> _$$_AddressBookKeyToJson(_$_AddressBookKey instance) =>
    <String, dynamic>{
      'name': instance.name,
      'publicKey': instance.publicKey,
      'createdAt': instance.createdAt,
    };
