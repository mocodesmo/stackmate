import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'wallet.g.dart';
part 'wallet.freezed.dart';

@freezed
class Wallet with _$Wallet {
  @HiveType(typeId: 1, adapterName: 'WalletClassAdaper')
  const factory Wallet({
    @HiveField(0) @Default('') String label,
    // @HiveField(1) @Default('') String policy,
    @HiveField(2) @Default('') String descriptor,
  }) = _Wallet;

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
}
