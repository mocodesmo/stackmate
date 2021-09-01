// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet-transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Transaction _$$_TransactionFromJson(Map<String, dynamic> json) =>
    _$_Transaction(
      involvesWatchonly: json['involvesWatchonly'] as bool? ?? false,
      address: json['address'] as String? ?? '',
      category: json['category'] as String? ?? '',
      amount: json['amount'] as int? ?? 0,
      fee: json['fee'] as int? ?? 0,
      vout: json['vout'] as int? ?? 0,
      confirmations: json['confirmations'] as int? ?? 0,
      blockhash: json['blockhash'] as String? ?? '',
      blockheight: json['blockheight'] as int? ?? 0,
      blockindex: json['blockindex'] as int? ?? 0,
      blocktime: json['blocktime'] as int? ?? 0,
      txid: json['txid'] as String? ?? '',
      time: json['time'] as int? ?? 0,
      timereceived: json['timereceived'] as int? ?? 0,
      bip125Replaceable: json['bip125-replaceable'] as String? ?? '',
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$$_TransactionToJson(_$_Transaction instance) =>
    <String, dynamic>{
      'involvesWatchonly': instance.involvesWatchonly,
      'address': instance.address,
      'category': instance.category,
      'amount': instance.amount,
      'fee': instance.fee,
      'vout': instance.vout,
      'confirmations': instance.confirmations,
      'blockhash': instance.blockhash,
      'blockheight': instance.blockheight,
      'blockindex': instance.blockindex,
      'blocktime': instance.blocktime,
      'txid': instance.txid,
      'time': instance.time,
      'timereceived': instance.timereceived,
      'bip125-replaceable': instance.bip125Replaceable,
      'comment': instance.comment,
    };
