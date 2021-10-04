import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'address-book.freezed.dart';
part 'address-book.g.dart';

@freezed
class AddressBookUser with _$AddressBookUser {
  @HiveType(typeId: 5, adapterName: 'AddressBookUserClassAdaper')
  const factory AddressBookUser({
    @HiveField(0) required String name,
    @HiveField(1) List<AddressBookKey>? keys,
  }) = _AddressBookUser;

  factory AddressBookUser.fromJson(Map<String, dynamic> json) =>
      _$AddressBookUserFromJson(json);
}

@freezed
class AddressBookKey with _$AddressBookKey {
  @HiveType(typeId: 6, adapterName: 'AddressBookValueClassAdaper')
  const factory AddressBookKey({
    @HiveField(0) required String name,
    @HiveField(1) required String publicKey,
    @HiveField(2) required int createdAt,
  }) = _AddressBookKey;

  factory AddressBookKey.fromJson(Map<String, dynamic> json) =>
      _$AddressBookKeyFromJson(json);
}
