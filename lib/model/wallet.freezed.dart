// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wallet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Wallet _$WalletFromJson(Map<String, dynamic> json) {
  return _Wallet.fromJson(json);
}

/// @nodoc
class _$WalletTearOff {
  const _$WalletTearOff();

  _Wallet call(
      {@HiveField(0) required String label,
      @HiveField(2) required String descriptor,
      @HiveField(3) required String blockchain,
      @HiveField(4) List<Transaction>? transactions,
      @HiveField(5) int? id,
      @HiveField(6) int? balance}) {
    return _Wallet(
      label: label,
      descriptor: descriptor,
      blockchain: blockchain,
      transactions: transactions,
      id: id,
      balance: balance,
    );
  }

  Wallet fromJson(Map<String, Object> json) {
    return Wallet.fromJson(json);
  }
}

/// @nodoc
const $Wallet = _$WalletTearOff();

/// @nodoc
mixin _$Wallet {
  @HiveField(0)
  String get label => throw _privateConstructorUsedError;
  @HiveField(2)
  String get descriptor => throw _privateConstructorUsedError;
  @HiveField(3)
  String get blockchain => throw _privateConstructorUsedError;
  @HiveField(4)
  List<Transaction>? get transactions => throw _privateConstructorUsedError;
  @HiveField(5)
  int? get id => throw _privateConstructorUsedError;
  @HiveField(6)
  int? get balance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WalletCopyWith<Wallet> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletCopyWith<$Res> {
  factory $WalletCopyWith(Wallet value, $Res Function(Wallet) then) =
      _$WalletCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) String label,
      @HiveField(2) String descriptor,
      @HiveField(3) String blockchain,
      @HiveField(4) List<Transaction>? transactions,
      @HiveField(5) int? id,
      @HiveField(6) int? balance});
}

/// @nodoc
class _$WalletCopyWithImpl<$Res> implements $WalletCopyWith<$Res> {
  _$WalletCopyWithImpl(this._value, this._then);

  final Wallet _value;
  // ignore: unused_field
  final $Res Function(Wallet) _then;

  @override
  $Res call({
    Object? label = freezed,
    Object? descriptor = freezed,
    Object? blockchain = freezed,
    Object? transactions = freezed,
    Object? id = freezed,
    Object? balance = freezed,
  }) {
    return _then(_value.copyWith(
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      descriptor: descriptor == freezed
          ? _value.descriptor
          : descriptor // ignore: cast_nullable_to_non_nullable
              as String,
      blockchain: blockchain == freezed
          ? _value.blockchain
          : blockchain // ignore: cast_nullable_to_non_nullable
              as String,
      transactions: transactions == freezed
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<Transaction>?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      balance: balance == freezed
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$WalletCopyWith<$Res> implements $WalletCopyWith<$Res> {
  factory _$WalletCopyWith(_Wallet value, $Res Function(_Wallet) then) =
      __$WalletCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) String label,
      @HiveField(2) String descriptor,
      @HiveField(3) String blockchain,
      @HiveField(4) List<Transaction>? transactions,
      @HiveField(5) int? id,
      @HiveField(6) int? balance});
}

/// @nodoc
class __$WalletCopyWithImpl<$Res> extends _$WalletCopyWithImpl<$Res>
    implements _$WalletCopyWith<$Res> {
  __$WalletCopyWithImpl(_Wallet _value, $Res Function(_Wallet) _then)
      : super(_value, (v) => _then(v as _Wallet));

  @override
  _Wallet get _value => super._value as _Wallet;

  @override
  $Res call({
    Object? label = freezed,
    Object? descriptor = freezed,
    Object? blockchain = freezed,
    Object? transactions = freezed,
    Object? id = freezed,
    Object? balance = freezed,
  }) {
    return _then(_Wallet(
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      descriptor: descriptor == freezed
          ? _value.descriptor
          : descriptor // ignore: cast_nullable_to_non_nullable
              as String,
      blockchain: blockchain == freezed
          ? _value.blockchain
          : blockchain // ignore: cast_nullable_to_non_nullable
              as String,
      transactions: transactions == freezed
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<Transaction>?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      balance: balance == freezed
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 1, adapterName: 'WalletClassAdaper')
class _$_Wallet extends _Wallet {
  const _$_Wallet(
      {@HiveField(0) required this.label,
      @HiveField(2) required this.descriptor,
      @HiveField(3) required this.blockchain,
      @HiveField(4) this.transactions,
      @HiveField(5) this.id,
      @HiveField(6) this.balance})
      : super._();

  factory _$_Wallet.fromJson(Map<String, dynamic> json) =>
      _$$_WalletFromJson(json);

  @override
  @HiveField(0)
  final String label;
  @override
  @HiveField(2)
  final String descriptor;
  @override
  @HiveField(3)
  final String blockchain;
  @override
  @HiveField(4)
  final List<Transaction>? transactions;
  @override
  @HiveField(5)
  final int? id;
  @override
  @HiveField(6)
  final int? balance;

  @override
  String toString() {
    return 'Wallet(label: $label, descriptor: $descriptor, blockchain: $blockchain, transactions: $transactions, id: $id, balance: $balance)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Wallet &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.descriptor, descriptor) ||
                const DeepCollectionEquality()
                    .equals(other.descriptor, descriptor)) &&
            (identical(other.blockchain, blockchain) ||
                const DeepCollectionEquality()
                    .equals(other.blockchain, blockchain)) &&
            (identical(other.transactions, transactions) ||
                const DeepCollectionEquality()
                    .equals(other.transactions, transactions)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.balance, balance) ||
                const DeepCollectionEquality().equals(other.balance, balance)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(descriptor) ^
      const DeepCollectionEquality().hash(blockchain) ^
      const DeepCollectionEquality().hash(transactions) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(balance);

  @JsonKey(ignore: true)
  @override
  _$WalletCopyWith<_Wallet> get copyWith =>
      __$WalletCopyWithImpl<_Wallet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WalletToJson(this);
  }
}

abstract class _Wallet extends Wallet {
  const factory _Wallet(
      {@HiveField(0) required String label,
      @HiveField(2) required String descriptor,
      @HiveField(3) required String blockchain,
      @HiveField(4) List<Transaction>? transactions,
      @HiveField(5) int? id,
      @HiveField(6) int? balance}) = _$_Wallet;
  const _Wallet._() : super._();

  factory _Wallet.fromJson(Map<String, dynamic> json) = _$_Wallet.fromJson;

  @override
  @HiveField(0)
  String get label => throw _privateConstructorUsedError;
  @override
  @HiveField(2)
  String get descriptor => throw _privateConstructorUsedError;
  @override
  @HiveField(3)
  String get blockchain => throw _privateConstructorUsedError;
  @override
  @HiveField(4)
  List<Transaction>? get transactions => throw _privateConstructorUsedError;
  @override
  @HiveField(5)
  int? get id => throw _privateConstructorUsedError;
  @override
  @HiveField(6)
  int? get balance => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$WalletCopyWith<_Wallet> get copyWith => throw _privateConstructorUsedError;
}
