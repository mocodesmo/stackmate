import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet-transaction.g.dart';
part 'wallet-transaction.freezed.dart';

@freezed
class Transaction with _$Transaction {
  const Transaction._();
  const factory Transaction({
    @JsonKey(name: 'involvesWatchonly') @Default(false) bool involvesWatchonly,
    @JsonKey(name: 'address') @Default('') String address,
    @JsonKey(name: 'category') @Default('') String category,
    @JsonKey(name: 'amount') @Default(0) int amount,
    @JsonKey(name: 'fee') @Default(0) int fee,
    @JsonKey(name: 'vout') @Default(0) int vout,
    @JsonKey(name: 'confirmations') @Default(0) int confirmations,
    @JsonKey(name: 'blockhash') @Default('') String blockhash,
    @JsonKey(name: 'blockheight') @Default(0) int blockheight,
    @JsonKey(name: 'blockindex') @Default(0) int blockindex,
    @JsonKey(name: 'blocktime') @Default(0) int blocktime,
    @JsonKey(name: 'txid') @Default('') String txid,
    @JsonKey(name: 'time') @Default(0) int time,
    @JsonKey(name: 'timereceived') @Default(0) int timereceived,
    @JsonKey(name: 'bip125-replaceable') @Default('') String bip125Replaceable,
    @JsonKey(name: 'comment') String? comment,
    //@JsonKey(name: 'counter_party') @Default('') String counterParty,
    //@JsonKey(name: 'type') @Default('') String type,
    //@JsonKey(name: 'confirmed') @Default(false) bool confirmed,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  String amountToBtc() => (amount / 10000000).toStringAsFixed(8);
  String feesToBtc() => (fee / 100000000).toStringAsFixed(8);

  bool received() => category == 'receive';

  String link() {
    String url = '';
    if (txid.startsWith('2') ||
        txid.startsWith('m') ||
        txid.startsWith('n') ||
        txid.startsWith('tb'))
      url = 'https://blockstream.info/testnet/tx/';
    else
      url = 'https://blockstream.info/tx/';
    url += txid;
    return url;
  }

  String txIdBlur() {
    return '****' + txid.substring(txid.length - 3, txid.length);
  }

  String timeStr() {
    String date = '';
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(time);

    //date += DateFormat.EEEE().format(dt) + ', ';

    date += dt.day.toString() +
        '-' +
        dt.month.toString() +
        '-' +
        dt.year.toString() +
        ' ';

    date += dt.hour.toString() + ':' + dt.minute.toString() + ' ';

    date += dt.hour < 12 ? 'AM' : 'PM';

    date += ' GMT';

    return date;
  }
}
