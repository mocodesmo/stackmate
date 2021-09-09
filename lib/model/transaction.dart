import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'transaction.g.dart';
part 'transaction.freezed.dart';

@freezed
class Transaction with _$Transaction {
  @HiveType(typeId: 4, adapterName: 'TransactionClassAdaper')
  const factory Transaction({
    @HiveField(0) required int timestamp,
    @HiveField(1) required int height,
    @HiveField(2) required bool verified,
    @HiveField(3) required String txid,
    @HiveField(4) required int received,
    @HiveField(5) required int sent,
    @HiveField(6) required int fee,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
