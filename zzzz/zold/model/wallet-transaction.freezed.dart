// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wallet-transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return _Transaction.fromJson(json);
}

/// @nodoc
class _$TransactionTearOff {
  const _$TransactionTearOff();

  _Transaction call(
      {@JsonKey(name: 'involvesWatchonly') bool involvesWatchonly = false,
      @JsonKey(name: 'address') String address = '',
      @JsonKey(name: 'category') String category = '',
      @JsonKey(name: 'amount') int amount = 0,
      @JsonKey(name: 'fee') int fee = 0,
      @JsonKey(name: 'vout') int vout = 0,
      @JsonKey(name: 'confirmations') int confirmations = 0,
      @JsonKey(name: 'blockhash') String blockhash = '',
      @JsonKey(name: 'blockheight') int blockheight = 0,
      @JsonKey(name: 'blockindex') int blockindex = 0,
      @JsonKey(name: 'blocktime') int blocktime = 0,
      @JsonKey(name: 'txid') String txid = '',
      @JsonKey(name: 'time') int time = 0,
      @JsonKey(name: 'timereceived') int timereceived = 0,
      @JsonKey(name: 'bip125-replaceable') String bip125Replaceable = '',
      @JsonKey(name: 'comment') String? comment}) {
    return _Transaction(
      involvesWatchonly: involvesWatchonly,
      address: address,
      category: category,
      amount: amount,
      fee: fee,
      vout: vout,
      confirmations: confirmations,
      blockhash: blockhash,
      blockheight: blockheight,
      blockindex: blockindex,
      blocktime: blocktime,
      txid: txid,
      time: time,
      timereceived: timereceived,
      bip125Replaceable: bip125Replaceable,
      comment: comment,
    );
  }

  Transaction fromJson(Map<String, Object> json) {
    return Transaction.fromJson(json);
  }
}

/// @nodoc
const $Transaction = _$TransactionTearOff();

/// @nodoc
mixin _$Transaction {
  @JsonKey(name: 'involvesWatchonly')
  bool get involvesWatchonly => throw _privateConstructorUsedError;
  @JsonKey(name: 'address')
  String get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'category')
  String get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'amount')
  int get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'fee')
  int get fee => throw _privateConstructorUsedError;
  @JsonKey(name: 'vout')
  int get vout => throw _privateConstructorUsedError;
  @JsonKey(name: 'confirmations')
  int get confirmations => throw _privateConstructorUsedError;
  @JsonKey(name: 'blockhash')
  String get blockhash => throw _privateConstructorUsedError;
  @JsonKey(name: 'blockheight')
  int get blockheight => throw _privateConstructorUsedError;
  @JsonKey(name: 'blockindex')
  int get blockindex => throw _privateConstructorUsedError;
  @JsonKey(name: 'blocktime')
  int get blocktime => throw _privateConstructorUsedError;
  @JsonKey(name: 'txid')
  String get txid => throw _privateConstructorUsedError;
  @JsonKey(name: 'time')
  int get time => throw _privateConstructorUsedError;
  @JsonKey(name: 'timereceived')
  int get timereceived => throw _privateConstructorUsedError;
  @JsonKey(name: 'bip125-replaceable')
  String get bip125Replaceable => throw _privateConstructorUsedError;
  @JsonKey(name: 'comment')
  String? get comment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
          Transaction value, $Res Function(Transaction) then) =
      _$TransactionCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'involvesWatchonly') bool involvesWatchonly,
      @JsonKey(name: 'address') String address,
      @JsonKey(name: 'category') String category,
      @JsonKey(name: 'amount') int amount,
      @JsonKey(name: 'fee') int fee,
      @JsonKey(name: 'vout') int vout,
      @JsonKey(name: 'confirmations') int confirmations,
      @JsonKey(name: 'blockhash') String blockhash,
      @JsonKey(name: 'blockheight') int blockheight,
      @JsonKey(name: 'blockindex') int blockindex,
      @JsonKey(name: 'blocktime') int blocktime,
      @JsonKey(name: 'txid') String txid,
      @JsonKey(name: 'time') int time,
      @JsonKey(name: 'timereceived') int timereceived,
      @JsonKey(name: 'bip125-replaceable') String bip125Replaceable,
      @JsonKey(name: 'comment') String? comment});
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res> implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  final Transaction _value;
  // ignore: unused_field
  final $Res Function(Transaction) _then;

  @override
  $Res call({
    Object? involvesWatchonly = freezed,
    Object? address = freezed,
    Object? category = freezed,
    Object? amount = freezed,
    Object? fee = freezed,
    Object? vout = freezed,
    Object? confirmations = freezed,
    Object? blockhash = freezed,
    Object? blockheight = freezed,
    Object? blockindex = freezed,
    Object? blocktime = freezed,
    Object? txid = freezed,
    Object? time = freezed,
    Object? timereceived = freezed,
    Object? bip125Replaceable = freezed,
    Object? comment = freezed,
  }) {
    return _then(_value.copyWith(
      involvesWatchonly: involvesWatchonly == freezed
          ? _value.involvesWatchonly
          : involvesWatchonly // ignore: cast_nullable_to_non_nullable
              as bool,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      fee: fee == freezed
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
      vout: vout == freezed
          ? _value.vout
          : vout // ignore: cast_nullable_to_non_nullable
              as int,
      confirmations: confirmations == freezed
          ? _value.confirmations
          : confirmations // ignore: cast_nullable_to_non_nullable
              as int,
      blockhash: blockhash == freezed
          ? _value.blockhash
          : blockhash // ignore: cast_nullable_to_non_nullable
              as String,
      blockheight: blockheight == freezed
          ? _value.blockheight
          : blockheight // ignore: cast_nullable_to_non_nullable
              as int,
      blockindex: blockindex == freezed
          ? _value.blockindex
          : blockindex // ignore: cast_nullable_to_non_nullable
              as int,
      blocktime: blocktime == freezed
          ? _value.blocktime
          : blocktime // ignore: cast_nullable_to_non_nullable
              as int,
      txid: txid == freezed
          ? _value.txid
          : txid // ignore: cast_nullable_to_non_nullable
              as String,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      timereceived: timereceived == freezed
          ? _value.timereceived
          : timereceived // ignore: cast_nullable_to_non_nullable
              as int,
      bip125Replaceable: bip125Replaceable == freezed
          ? _value.bip125Replaceable
          : bip125Replaceable // ignore: cast_nullable_to_non_nullable
              as String,
      comment: comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$TransactionCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$TransactionCopyWith(
          _Transaction value, $Res Function(_Transaction) then) =
      __$TransactionCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'involvesWatchonly') bool involvesWatchonly,
      @JsonKey(name: 'address') String address,
      @JsonKey(name: 'category') String category,
      @JsonKey(name: 'amount') int amount,
      @JsonKey(name: 'fee') int fee,
      @JsonKey(name: 'vout') int vout,
      @JsonKey(name: 'confirmations') int confirmations,
      @JsonKey(name: 'blockhash') String blockhash,
      @JsonKey(name: 'blockheight') int blockheight,
      @JsonKey(name: 'blockindex') int blockindex,
      @JsonKey(name: 'blocktime') int blocktime,
      @JsonKey(name: 'txid') String txid,
      @JsonKey(name: 'time') int time,
      @JsonKey(name: 'timereceived') int timereceived,
      @JsonKey(name: 'bip125-replaceable') String bip125Replaceable,
      @JsonKey(name: 'comment') String? comment});
}

/// @nodoc
class __$TransactionCopyWithImpl<$Res> extends _$TransactionCopyWithImpl<$Res>
    implements _$TransactionCopyWith<$Res> {
  __$TransactionCopyWithImpl(
      _Transaction _value, $Res Function(_Transaction) _then)
      : super(_value, (v) => _then(v as _Transaction));

  @override
  _Transaction get _value => super._value as _Transaction;

  @override
  $Res call({
    Object? involvesWatchonly = freezed,
    Object? address = freezed,
    Object? category = freezed,
    Object? amount = freezed,
    Object? fee = freezed,
    Object? vout = freezed,
    Object? confirmations = freezed,
    Object? blockhash = freezed,
    Object? blockheight = freezed,
    Object? blockindex = freezed,
    Object? blocktime = freezed,
    Object? txid = freezed,
    Object? time = freezed,
    Object? timereceived = freezed,
    Object? bip125Replaceable = freezed,
    Object? comment = freezed,
  }) {
    return _then(_Transaction(
      involvesWatchonly: involvesWatchonly == freezed
          ? _value.involvesWatchonly
          : involvesWatchonly // ignore: cast_nullable_to_non_nullable
              as bool,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      fee: fee == freezed
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
      vout: vout == freezed
          ? _value.vout
          : vout // ignore: cast_nullable_to_non_nullable
              as int,
      confirmations: confirmations == freezed
          ? _value.confirmations
          : confirmations // ignore: cast_nullable_to_non_nullable
              as int,
      blockhash: blockhash == freezed
          ? _value.blockhash
          : blockhash // ignore: cast_nullable_to_non_nullable
              as String,
      blockheight: blockheight == freezed
          ? _value.blockheight
          : blockheight // ignore: cast_nullable_to_non_nullable
              as int,
      blockindex: blockindex == freezed
          ? _value.blockindex
          : blockindex // ignore: cast_nullable_to_non_nullable
              as int,
      blocktime: blocktime == freezed
          ? _value.blocktime
          : blocktime // ignore: cast_nullable_to_non_nullable
              as int,
      txid: txid == freezed
          ? _value.txid
          : txid // ignore: cast_nullable_to_non_nullable
              as String,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      timereceived: timereceived == freezed
          ? _value.timereceived
          : timereceived // ignore: cast_nullable_to_non_nullable
              as int,
      bip125Replaceable: bip125Replaceable == freezed
          ? _value.bip125Replaceable
          : bip125Replaceable // ignore: cast_nullable_to_non_nullable
              as String,
      comment: comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Transaction extends _Transaction {
  const _$_Transaction(
      {@JsonKey(name: 'involvesWatchonly') this.involvesWatchonly = false,
      @JsonKey(name: 'address') this.address = '',
      @JsonKey(name: 'category') this.category = '',
      @JsonKey(name: 'amount') this.amount = 0,
      @JsonKey(name: 'fee') this.fee = 0,
      @JsonKey(name: 'vout') this.vout = 0,
      @JsonKey(name: 'confirmations') this.confirmations = 0,
      @JsonKey(name: 'blockhash') this.blockhash = '',
      @JsonKey(name: 'blockheight') this.blockheight = 0,
      @JsonKey(name: 'blockindex') this.blockindex = 0,
      @JsonKey(name: 'blocktime') this.blocktime = 0,
      @JsonKey(name: 'txid') this.txid = '',
      @JsonKey(name: 'time') this.time = 0,
      @JsonKey(name: 'timereceived') this.timereceived = 0,
      @JsonKey(name: 'bip125-replaceable') this.bip125Replaceable = '',
      @JsonKey(name: 'comment') this.comment})
      : super._();

  factory _$_Transaction.fromJson(Map<String, dynamic> json) =>
      _$$_TransactionFromJson(json);

  @override
  @JsonKey(name: 'involvesWatchonly')
  final bool involvesWatchonly;
  @override
  @JsonKey(name: 'address')
  final String address;
  @override
  @JsonKey(name: 'category')
  final String category;
  @override
  @JsonKey(name: 'amount')
  final int amount;
  @override
  @JsonKey(name: 'fee')
  final int fee;
  @override
  @JsonKey(name: 'vout')
  final int vout;
  @override
  @JsonKey(name: 'confirmations')
  final int confirmations;
  @override
  @JsonKey(name: 'blockhash')
  final String blockhash;
  @override
  @JsonKey(name: 'blockheight')
  final int blockheight;
  @override
  @JsonKey(name: 'blockindex')
  final int blockindex;
  @override
  @JsonKey(name: 'blocktime')
  final int blocktime;
  @override
  @JsonKey(name: 'txid')
  final String txid;
  @override
  @JsonKey(name: 'time')
  final int time;
  @override
  @JsonKey(name: 'timereceived')
  final int timereceived;
  @override
  @JsonKey(name: 'bip125-replaceable')
  final String bip125Replaceable;
  @override
  @JsonKey(name: 'comment')
  final String? comment;

  @override
  String toString() {
    return 'Transaction(involvesWatchonly: $involvesWatchonly, address: $address, category: $category, amount: $amount, fee: $fee, vout: $vout, confirmations: $confirmations, blockhash: $blockhash, blockheight: $blockheight, blockindex: $blockindex, blocktime: $blocktime, txid: $txid, time: $time, timereceived: $timereceived, bip125Replaceable: $bip125Replaceable, comment: $comment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Transaction &&
            (identical(other.involvesWatchonly, involvesWatchonly) ||
                const DeepCollectionEquality()
                    .equals(other.involvesWatchonly, involvesWatchonly)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.fee, fee) ||
                const DeepCollectionEquality().equals(other.fee, fee)) &&
            (identical(other.vout, vout) ||
                const DeepCollectionEquality().equals(other.vout, vout)) &&
            (identical(other.confirmations, confirmations) ||
                const DeepCollectionEquality()
                    .equals(other.confirmations, confirmations)) &&
            (identical(other.blockhash, blockhash) ||
                const DeepCollectionEquality()
                    .equals(other.blockhash, blockhash)) &&
            (identical(other.blockheight, blockheight) ||
                const DeepCollectionEquality()
                    .equals(other.blockheight, blockheight)) &&
            (identical(other.blockindex, blockindex) ||
                const DeepCollectionEquality()
                    .equals(other.blockindex, blockindex)) &&
            (identical(other.blocktime, blocktime) ||
                const DeepCollectionEquality()
                    .equals(other.blocktime, blocktime)) &&
            (identical(other.txid, txid) ||
                const DeepCollectionEquality().equals(other.txid, txid)) &&
            (identical(other.time, time) ||
                const DeepCollectionEquality().equals(other.time, time)) &&
            (identical(other.timereceived, timereceived) ||
                const DeepCollectionEquality()
                    .equals(other.timereceived, timereceived)) &&
            (identical(other.bip125Replaceable, bip125Replaceable) ||
                const DeepCollectionEquality()
                    .equals(other.bip125Replaceable, bip125Replaceable)) &&
            (identical(other.comment, comment) ||
                const DeepCollectionEquality().equals(other.comment, comment)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(involvesWatchonly) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(fee) ^
      const DeepCollectionEquality().hash(vout) ^
      const DeepCollectionEquality().hash(confirmations) ^
      const DeepCollectionEquality().hash(blockhash) ^
      const DeepCollectionEquality().hash(blockheight) ^
      const DeepCollectionEquality().hash(blockindex) ^
      const DeepCollectionEquality().hash(blocktime) ^
      const DeepCollectionEquality().hash(txid) ^
      const DeepCollectionEquality().hash(time) ^
      const DeepCollectionEquality().hash(timereceived) ^
      const DeepCollectionEquality().hash(bip125Replaceable) ^
      const DeepCollectionEquality().hash(comment);

  @JsonKey(ignore: true)
  @override
  _$TransactionCopyWith<_Transaction> get copyWith =>
      __$TransactionCopyWithImpl<_Transaction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransactionToJson(this);
  }
}

abstract class _Transaction extends Transaction {
  const factory _Transaction(
      {@JsonKey(name: 'involvesWatchonly') bool involvesWatchonly,
      @JsonKey(name: 'address') String address,
      @JsonKey(name: 'category') String category,
      @JsonKey(name: 'amount') int amount,
      @JsonKey(name: 'fee') int fee,
      @JsonKey(name: 'vout') int vout,
      @JsonKey(name: 'confirmations') int confirmations,
      @JsonKey(name: 'blockhash') String blockhash,
      @JsonKey(name: 'blockheight') int blockheight,
      @JsonKey(name: 'blockindex') int blockindex,
      @JsonKey(name: 'blocktime') int blocktime,
      @JsonKey(name: 'txid') String txid,
      @JsonKey(name: 'time') int time,
      @JsonKey(name: 'timereceived') int timereceived,
      @JsonKey(name: 'bip125-replaceable') String bip125Replaceable,
      @JsonKey(name: 'comment') String? comment}) = _$_Transaction;
  const _Transaction._() : super._();

  factory _Transaction.fromJson(Map<String, dynamic> json) =
      _$_Transaction.fromJson;

  @override
  @JsonKey(name: 'involvesWatchonly')
  bool get involvesWatchonly => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'address')
  String get address => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'category')
  String get category => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'amount')
  int get amount => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'fee')
  int get fee => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'vout')
  int get vout => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'confirmations')
  int get confirmations => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'blockhash')
  String get blockhash => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'blockheight')
  int get blockheight => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'blockindex')
  int get blockindex => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'blocktime')
  int get blocktime => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'txid')
  String get txid => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'time')
  int get time => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'timereceived')
  int get timereceived => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'bip125-replaceable')
  String get bip125Replaceable => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'comment')
  String? get comment => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TransactionCopyWith<_Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}
