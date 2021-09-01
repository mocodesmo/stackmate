// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'confirm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$BtcSendTfaStateTearOff {
  const _$BtcSendTfaStateTearOff();

  _BtcSendTfaState call({String code = '', String error = ''}) {
    return _BtcSendTfaState(
      code: code,
      error: error,
    );
  }
}

/// @nodoc
const $BtcSendTfaState = _$BtcSendTfaStateTearOff();

/// @nodoc
mixin _$BtcSendTfaState {
  String get code => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BtcSendTfaStateCopyWith<BtcSendTfaState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BtcSendTfaStateCopyWith<$Res> {
  factory $BtcSendTfaStateCopyWith(
          BtcSendTfaState value, $Res Function(BtcSendTfaState) then) =
      _$BtcSendTfaStateCopyWithImpl<$Res>;
  $Res call({String code, String error});
}

/// @nodoc
class _$BtcSendTfaStateCopyWithImpl<$Res>
    implements $BtcSendTfaStateCopyWith<$Res> {
  _$BtcSendTfaStateCopyWithImpl(this._value, this._then);

  final BtcSendTfaState _value;
  // ignore: unused_field
  final $Res Function(BtcSendTfaState) _then;

  @override
  $Res call({
    Object? code = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$BtcSendTfaStateCopyWith<$Res>
    implements $BtcSendTfaStateCopyWith<$Res> {
  factory _$BtcSendTfaStateCopyWith(
          _BtcSendTfaState value, $Res Function(_BtcSendTfaState) then) =
      __$BtcSendTfaStateCopyWithImpl<$Res>;
  @override
  $Res call({String code, String error});
}

/// @nodoc
class __$BtcSendTfaStateCopyWithImpl<$Res>
    extends _$BtcSendTfaStateCopyWithImpl<$Res>
    implements _$BtcSendTfaStateCopyWith<$Res> {
  __$BtcSendTfaStateCopyWithImpl(
      _BtcSendTfaState _value, $Res Function(_BtcSendTfaState) _then)
      : super(_value, (v) => _then(v as _BtcSendTfaState));

  @override
  _BtcSendTfaState get _value => super._value as _BtcSendTfaState;

  @override
  $Res call({
    Object? code = freezed,
    Object? error = freezed,
  }) {
    return _then(_BtcSendTfaState(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_BtcSendTfaState implements _BtcSendTfaState {
  const _$_BtcSendTfaState({this.code = '', this.error = ''});

  @JsonKey(defaultValue: '')
  @override
  final String code;
  @JsonKey(defaultValue: '')
  @override
  final String error;

  @override
  String toString() {
    return 'BtcSendTfaState(code: $code, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BtcSendTfaState &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  _$BtcSendTfaStateCopyWith<_BtcSendTfaState> get copyWith =>
      __$BtcSendTfaStateCopyWithImpl<_BtcSendTfaState>(this, _$identity);
}

abstract class _BtcSendTfaState implements BtcSendTfaState {
  const factory _BtcSendTfaState({String code, String error}) =
      _$_BtcSendTfaState;

  @override
  String get code => throw _privateConstructorUsedError;
  @override
  String get error => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BtcSendTfaStateCopyWith<_BtcSendTfaState> get copyWith =>
      throw _privateConstructorUsedError;
}
