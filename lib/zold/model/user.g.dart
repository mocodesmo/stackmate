// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      email: json['email'] as String? ?? '',
      locked: json['locked'] as bool? ?? false,
      pinStatus: json['pin'] as bool? ?? false,
      tfaStatus: json['tfa'] as bool? ?? false,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'email': instance.email,
      'locked': instance.locked,
      'pin': instance.pinStatus,
      'tfa': instance.tfaStatus,
    };
