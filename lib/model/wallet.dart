import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:sats/model/transaction.dart';

part 'wallet.g.dart';
part 'wallet.freezed.dart';

@freezed
class Wallet with _$Wallet {
  @HiveType(typeId: 1, adapterName: 'WalletClassAdaper')
  const factory Wallet({
    @HiveField(0) required String label,
    @HiveField(2) required String descriptor,
    @HiveField(3) required String blockchain,
    @HiveField(4) List<Transaction>? transactions,
    @HiveField(5) int? id,
    @HiveField(6) int? balance,
    // @Default(false) @HiveField(7) bool watchOnly,
  }) = _Wallet;
  const Wallet._();

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  String balanceToBtc() =>
      balance == null ? '0' : (balance! / 100000000).toStringAsFixed(8);
}
