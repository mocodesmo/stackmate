// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'pin-login.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PinLoginStateTearOff {
  const _$PinLoginStateTearOff();

  _PinLoginState call(
      {int pin = 0,
      String error = '',
      bool confirmingPin = false,
      int retryCount = -1,
      bool verified = false}) {
    return _PinLoginState(
      pin: pin,
      error: error,
      confirmingPin: confirmingPin,
      retryCount: retryCount,
      verified: verified,
    );
  }
}

/// @nodoc
const $PinLoginState = _$PinLoginStateTearOff();

/// @nodoc
mixin _$PinLoginState {
  int get pin => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  bool get confirmingPin => throw _privateConstructorUsedError;
  int get retryCount => throw _privateConstructorUsedError;
  bool get verified => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PinLoginStateCopyWith<PinLoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PinLoginStateCopyWith<$Res> {
  factory $PinLoginStateCopyWith(
          PinLoginState value, $Res Function(PinLoginState) then) =
      _$PinLoginStateCopyWithImpl<$Res>;
  $Res call(
      {int pin,
      String error,
      bool confirmingPin,
      int retryCount,
      bool verified});
}

/// @nodoc
class _$PinLoginStateCopyWithImpl<$Res>
    implements $PinLoginStateCopyWith<$Res> {
  _$PinLoginStateCopyWithImpl(this._value, this._then);

  final PinLoginState _value;
  // ignore: unused_field
  final $Res Function(PinLoginState) _then;

  @override
  $Res call({
    Object? pin = freezed,
    Object? error = freezed,
    Object? confirmingPin = freezed,
    Object? retryCount = freezed,
    Object? verified = freezed,
  }) {
    return _then(_value.copyWith(
      pin: pin == freezed
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as int,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      confirmingPin: confirmingPin == freezed
          ? _value.confirmingPin
          : confirmingPin // ignore: cast_nullable_to_non_nullable
              as bool,
      retryCount: retryCount == freezed
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      verified: verified == freezed
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$PinLoginStateCopyWith<$Res>
    implements $PinLoginStateCopyWith<$Res> {
  factory _$PinLoginStateCopyWith(
          _PinLoginState value, $Res Function(_PinLoginState) then) =
      __$PinLoginStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {int pin,
      String error,
      bool confirmingPin,
      int retryCount,
      bool verified});
}

/// @nodoc
class __$PinLoginStateCopyWithImpl<$Res>
    extends _$PinLoginStateCopyWithImpl<$Res>
    implements _$PinLoginStateCopyWith<$Res> {
  __$PinLoginStateCopyWithImpl(
      _PinLoginState _value, $Res Function(_PinLoginState) _then)
      : super(_value, (v) => _then(v as _PinLoginState));

  @override
  _PinLoginState get _value => super._value as _PinLoginState;

  @override
  $Res call({
    Object? pin = freezed,
    Object? error = freezed,
    Object? confirmingPin = freezed,
    Object? retryCount = freezed,
    Object? verified = freezed,
  }) {
    return _then(_PinLoginState(
      pin: pin == freezed
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as int,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      confirmingPin: confirmingPin == freezed
          ? _value.confirmingPin
          : confirmingPin // ignore: cast_nullable_to_non_nullable
              as bool,
      retryCount: retryCount == freezed
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      verified: verified == freezed
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_PinLoginState extends _PinLoginState {
  const _$_PinLoginState(
      {this.pin = 0,
      this.error = '',
      this.confirmingPin = false,
      this.retryCount = -1,
      this.verified = false})
      : super._();

  @JsonKey(defaultValue: 0)
  @override
  final int pin;
  @JsonKey(defaultValue: '')
  @override
  final String error;
  @JsonKey(defaultValue: false)
  @override
  final bool confirmingPin;
  @JsonKey(defaultValue: -1)
  @override
  final int retryCount;
  @JsonKey(defaultValue: false)
  @override
  final bool verified;

  @override
  String toString() {
    return 'PinLoginState(pin: $pin, error: $error, confirmingPin: $confirmingPin, retryCount: $retryCount, verified: $verified)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PinLoginState &&
            (identical(other.pin, pin) ||
                const DeepCollectionEquality().equals(other.pin, pin)) &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)) &&
            (identical(other.confirmingPin, confirmingPin) ||
                const DeepCollectionEquality()
                    .equals(other.confirmingPin, confirmingPin)) &&
            (identical(other.retryCount, retryCount) ||
                const DeepCollectionEquality()
                    .equals(other.retryCount, retryCount)) &&
            (identical(other.verified, verified) ||
                const DeepCollectionEquality()
                    .equals(other.verified, verified)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(pin) ^
      const DeepCollectionEquality().hash(error) ^
      const DeepCollectionEquality().hash(confirmingPin) ^
      const DeepCollectionEquality().hash(retryCount) ^
      const DeepCollectionEquality().hash(verified);

  @JsonKey(ignore: true)
  @override
  _$PinLoginStateCopyWith<_PinLoginState> get copyWith =>
      __$PinLoginStateCopyWithImpl<_PinLoginState>(this, _$identity);
}

abstract class _PinLoginState extends PinLoginState {
  const factory _PinLoginState(
      {int pin,
      String error,
      bool confirmingPin,
      int retryCount,
      bool verified}) = _$_PinLoginState;
  const _PinLoginState._() : super._();

  @override
  int get pin => throw _privateConstructorUsedError;
  @override
  String get error => throw _privateConstructorUsedError;
  @override
  bool get confirmingPin => throw _privateConstructorUsedError;
  @override
  int get retryCount => throw _privateConstructorUsedError;
  @override
  bool get verified => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PinLoginStateCopyWith<_PinLoginState> get copyWith =>
      throw _privateConstructorUsedError;
}
