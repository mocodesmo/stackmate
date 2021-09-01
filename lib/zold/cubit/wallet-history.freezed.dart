// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wallet-history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$WalletHistoryStateTearOff {
  const _$WalletHistoryStateTearOff();

  _WalletHistoryState call(
      {List<Transaction> transactions = const [],
      bool loadingHistory = false,
      String errLoading = ''}) {
    return _WalletHistoryState(
      transactions: transactions,
      loadingHistory: loadingHistory,
      errLoading: errLoading,
    );
  }
}

/// @nodoc
const $WalletHistoryState = _$WalletHistoryStateTearOff();

/// @nodoc
mixin _$WalletHistoryState {
  List<Transaction> get transactions => throw _privateConstructorUsedError;
  bool get loadingHistory => throw _privateConstructorUsedError;
  String get errLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WalletHistoryStateCopyWith<WalletHistoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletHistoryStateCopyWith<$Res> {
  factory $WalletHistoryStateCopyWith(
          WalletHistoryState value, $Res Function(WalletHistoryState) then) =
      _$WalletHistoryStateCopyWithImpl<$Res>;
  $Res call(
      {List<Transaction> transactions, bool loadingHistory, String errLoading});
}

/// @nodoc
class _$WalletHistoryStateCopyWithImpl<$Res>
    implements $WalletHistoryStateCopyWith<$Res> {
  _$WalletHistoryStateCopyWithImpl(this._value, this._then);

  final WalletHistoryState _value;
  // ignore: unused_field
  final $Res Function(WalletHistoryState) _then;

  @override
  $Res call({
    Object? transactions = freezed,
    Object? loadingHistory = freezed,
    Object? errLoading = freezed,
  }) {
    return _then(_value.copyWith(
      transactions: transactions == freezed
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<Transaction>,
      loadingHistory: loadingHistory == freezed
          ? _value.loadingHistory
          : loadingHistory // ignore: cast_nullable_to_non_nullable
              as bool,
      errLoading: errLoading == freezed
          ? _value.errLoading
          : errLoading // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$WalletHistoryStateCopyWith<$Res>
    implements $WalletHistoryStateCopyWith<$Res> {
  factory _$WalletHistoryStateCopyWith(
          _WalletHistoryState value, $Res Function(_WalletHistoryState) then) =
      __$WalletHistoryStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Transaction> transactions, bool loadingHistory, String errLoading});
}

/// @nodoc
class __$WalletHistoryStateCopyWithImpl<$Res>
    extends _$WalletHistoryStateCopyWithImpl<$Res>
    implements _$WalletHistoryStateCopyWith<$Res> {
  __$WalletHistoryStateCopyWithImpl(
      _WalletHistoryState _value, $Res Function(_WalletHistoryState) _then)
      : super(_value, (v) => _then(v as _WalletHistoryState));

  @override
  _WalletHistoryState get _value => super._value as _WalletHistoryState;

  @override
  $Res call({
    Object? transactions = freezed,
    Object? loadingHistory = freezed,
    Object? errLoading = freezed,
  }) {
    return _then(_WalletHistoryState(
      transactions: transactions == freezed
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<Transaction>,
      loadingHistory: loadingHistory == freezed
          ? _value.loadingHistory
          : loadingHistory // ignore: cast_nullable_to_non_nullable
              as bool,
      errLoading: errLoading == freezed
          ? _value.errLoading
          : errLoading // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_WalletHistoryState
    with DiagnosticableTreeMixin
    implements _WalletHistoryState {
  const _$_WalletHistoryState(
      {this.transactions = const [],
      this.loadingHistory = false,
      this.errLoading = ''});

  @JsonKey(defaultValue: const [])
  @override
  final List<Transaction> transactions;
  @JsonKey(defaultValue: false)
  @override
  final bool loadingHistory;
  @JsonKey(defaultValue: '')
  @override
  final String errLoading;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletHistoryState(transactions: $transactions, loadingHistory: $loadingHistory, errLoading: $errLoading)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletHistoryState'))
      ..add(DiagnosticsProperty('transactions', transactions))
      ..add(DiagnosticsProperty('loadingHistory', loadingHistory))
      ..add(DiagnosticsProperty('errLoading', errLoading));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WalletHistoryState &&
            (identical(other.transactions, transactions) ||
                const DeepCollectionEquality()
                    .equals(other.transactions, transactions)) &&
            (identical(other.loadingHistory, loadingHistory) ||
                const DeepCollectionEquality()
                    .equals(other.loadingHistory, loadingHistory)) &&
            (identical(other.errLoading, errLoading) ||
                const DeepCollectionEquality()
                    .equals(other.errLoading, errLoading)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(transactions) ^
      const DeepCollectionEquality().hash(loadingHistory) ^
      const DeepCollectionEquality().hash(errLoading);

  @JsonKey(ignore: true)
  @override
  _$WalletHistoryStateCopyWith<_WalletHistoryState> get copyWith =>
      __$WalletHistoryStateCopyWithImpl<_WalletHistoryState>(this, _$identity);
}

abstract class _WalletHistoryState implements WalletHistoryState {
  const factory _WalletHistoryState(
      {List<Transaction> transactions,
      bool loadingHistory,
      String errLoading}) = _$_WalletHistoryState;

  @override
  List<Transaction> get transactions => throw _privateConstructorUsedError;
  @override
  bool get loadingHistory => throw _privateConstructorUsedError;
  @override
  String get errLoading => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$WalletHistoryStateCopyWith<_WalletHistoryState> get copyWith =>
      throw _privateConstructorUsedError;
}
