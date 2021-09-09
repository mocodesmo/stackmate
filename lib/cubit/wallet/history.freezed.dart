// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$HistoryStateTearOff {
  const _$HistoryStateTearOff();

  _HistoryState call(
      {bool loadingTransactions = false,
      String errLoadingTransactions = '',
      List<Transaction>? transactions}) {
    return _HistoryState(
      loadingTransactions: loadingTransactions,
      errLoadingTransactions: errLoadingTransactions,
      transactions: transactions,
    );
  }
}

/// @nodoc
const $HistoryState = _$HistoryStateTearOff();

/// @nodoc
mixin _$HistoryState {
  bool get loadingTransactions => throw _privateConstructorUsedError;
  String get errLoadingTransactions => throw _privateConstructorUsedError;
  List<Transaction>? get transactions => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HistoryStateCopyWith<HistoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryStateCopyWith<$Res> {
  factory $HistoryStateCopyWith(
          HistoryState value, $Res Function(HistoryState) then) =
      _$HistoryStateCopyWithImpl<$Res>;
  $Res call(
      {bool loadingTransactions,
      String errLoadingTransactions,
      List<Transaction>? transactions});
}

/// @nodoc
class _$HistoryStateCopyWithImpl<$Res> implements $HistoryStateCopyWith<$Res> {
  _$HistoryStateCopyWithImpl(this._value, this._then);

  final HistoryState _value;
  // ignore: unused_field
  final $Res Function(HistoryState) _then;

  @override
  $Res call({
    Object? loadingTransactions = freezed,
    Object? errLoadingTransactions = freezed,
    Object? transactions = freezed,
  }) {
    return _then(_value.copyWith(
      loadingTransactions: loadingTransactions == freezed
          ? _value.loadingTransactions
          : loadingTransactions // ignore: cast_nullable_to_non_nullable
              as bool,
      errLoadingTransactions: errLoadingTransactions == freezed
          ? _value.errLoadingTransactions
          : errLoadingTransactions // ignore: cast_nullable_to_non_nullable
              as String,
      transactions: transactions == freezed
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<Transaction>?,
    ));
  }
}

/// @nodoc
abstract class _$HistoryStateCopyWith<$Res>
    implements $HistoryStateCopyWith<$Res> {
  factory _$HistoryStateCopyWith(
          _HistoryState value, $Res Function(_HistoryState) then) =
      __$HistoryStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool loadingTransactions,
      String errLoadingTransactions,
      List<Transaction>? transactions});
}

/// @nodoc
class __$HistoryStateCopyWithImpl<$Res> extends _$HistoryStateCopyWithImpl<$Res>
    implements _$HistoryStateCopyWith<$Res> {
  __$HistoryStateCopyWithImpl(
      _HistoryState _value, $Res Function(_HistoryState) _then)
      : super(_value, (v) => _then(v as _HistoryState));

  @override
  _HistoryState get _value => super._value as _HistoryState;

  @override
  $Res call({
    Object? loadingTransactions = freezed,
    Object? errLoadingTransactions = freezed,
    Object? transactions = freezed,
  }) {
    return _then(_HistoryState(
      loadingTransactions: loadingTransactions == freezed
          ? _value.loadingTransactions
          : loadingTransactions // ignore: cast_nullable_to_non_nullable
              as bool,
      errLoadingTransactions: errLoadingTransactions == freezed
          ? _value.errLoadingTransactions
          : errLoadingTransactions // ignore: cast_nullable_to_non_nullable
              as String,
      transactions: transactions == freezed
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<Transaction>?,
    ));
  }
}

/// @nodoc

class _$_HistoryState implements _HistoryState {
  const _$_HistoryState(
      {this.loadingTransactions = false,
      this.errLoadingTransactions = '',
      this.transactions});

  @JsonKey(defaultValue: false)
  @override
  final bool loadingTransactions;
  @JsonKey(defaultValue: '')
  @override
  final String errLoadingTransactions;
  @override
  final List<Transaction>? transactions;

  @override
  String toString() {
    return 'HistoryState(loadingTransactions: $loadingTransactions, errLoadingTransactions: $errLoadingTransactions, transactions: $transactions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HistoryState &&
            (identical(other.loadingTransactions, loadingTransactions) ||
                const DeepCollectionEquality()
                    .equals(other.loadingTransactions, loadingTransactions)) &&
            (identical(other.errLoadingTransactions, errLoadingTransactions) ||
                const DeepCollectionEquality().equals(
                    other.errLoadingTransactions, errLoadingTransactions)) &&
            (identical(other.transactions, transactions) ||
                const DeepCollectionEquality()
                    .equals(other.transactions, transactions)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(loadingTransactions) ^
      const DeepCollectionEquality().hash(errLoadingTransactions) ^
      const DeepCollectionEquality().hash(transactions);

  @JsonKey(ignore: true)
  @override
  _$HistoryStateCopyWith<_HistoryState> get copyWith =>
      __$HistoryStateCopyWithImpl<_HistoryState>(this, _$identity);
}

abstract class _HistoryState implements HistoryState {
  const factory _HistoryState(
      {bool loadingTransactions,
      String errLoadingTransactions,
      List<Transaction>? transactions}) = _$_HistoryState;

  @override
  bool get loadingTransactions => throw _privateConstructorUsedError;
  @override
  String get errLoadingTransactions => throw _privateConstructorUsedError;
  @override
  List<Transaction>? get transactions => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$HistoryStateCopyWith<_HistoryState> get copyWith =>
      throw _privateConstructorUsedError;
}
