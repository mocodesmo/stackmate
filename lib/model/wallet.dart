import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:sats/model/blockchain.dart';
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
    @HiveField(5) required int index,
    @HiveField(6) int? balance,
  }) = _Wallet;

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
}
