// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'network.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$NetworkStateTearOff {
  const _$NetworkStateTearOff();

  _NetworkState call(
      {bool bluetoothOnline = false,
      bool wifiOnline = false,
      bool mobileOnline = false}) {
    return _NetworkState(
      bluetoothOnline: bluetoothOnline,
      wifiOnline: wifiOnline,
      mobileOnline: mobileOnline,
    );
  }
}

/// @nodoc
const $NetworkState = _$NetworkStateTearOff();

/// @nodoc
mixin _$NetworkState {
  bool get bluetoothOnline => throw _privateConstructorUsedError;
  bool get wifiOnline => throw _privateConstructorUsedError;
  bool get mobileOnline => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NetworkStateCopyWith<NetworkState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkStateCopyWith<$Res> {
  factory $NetworkStateCopyWith(
          NetworkState value, $Res Function(NetworkState) then) =
      _$NetworkStateCopyWithImpl<$Res>;
  $Res call({bool bluetoothOnline, bool wifiOnline, bool mobileOnline});
}

/// @nodoc
class _$NetworkStateCopyWithImpl<$Res> implements $NetworkStateCopyWith<$Res> {
  _$NetworkStateCopyWithImpl(this._value, this._then);

  final NetworkState _value;
  // ignore: unused_field
  final $Res Function(NetworkState) _then;

  @override
  $Res call({
    Object? bluetoothOnline = freezed,
    Object? wifiOnline = freezed,
    Object? mobileOnline = freezed,
  }) {
    return _then(_value.copyWith(
      bluetoothOnline: bluetoothOnline == freezed
          ? _value.bluetoothOnline
          : bluetoothOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      wifiOnline: wifiOnline == freezed
          ? _value.wifiOnline
          : wifiOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      mobileOnline: mobileOnline == freezed
          ? _value.mobileOnline
          : mobileOnline // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$NetworkStateCopyWith<$Res>
    implements $NetworkStateCopyWith<$Res> {
  factory _$NetworkStateCopyWith(
          _NetworkState value, $Res Function(_NetworkState) then) =
      __$NetworkStateCopyWithImpl<$Res>;
  @override
  $Res call({bool bluetoothOnline, bool wifiOnline, bool mobileOnline});
}

/// @nodoc
class __$NetworkStateCopyWithImpl<$Res> extends _$NetworkStateCopyWithImpl<$Res>
    implements _$NetworkStateCopyWith<$Res> {
  __$NetworkStateCopyWithImpl(
      _NetworkState _value, $Res Function(_NetworkState) _then)
      : super(_value, (v) => _then(v as _NetworkState));

  @override
  _NetworkState get _value => super._value as _NetworkState;

  @override
  $Res call({
    Object? bluetoothOnline = freezed,
    Object? wifiOnline = freezed,
    Object? mobileOnline = freezed,
  }) {
    return _then(_NetworkState(
      bluetoothOnline: bluetoothOnline == freezed
          ? _value.bluetoothOnline
          : bluetoothOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      wifiOnline: wifiOnline == freezed
          ? _value.wifiOnline
          : wifiOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      mobileOnline: mobileOnline == freezed
          ? _value.mobileOnline
          : mobileOnline // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_NetworkState extends _NetworkState {
  const _$_NetworkState(
      {this.bluetoothOnline = false,
      this.wifiOnline = false,
      this.mobileOnline = false})
      : super._();

  @JsonKey(defaultValue: false)
  @override
  final bool bluetoothOnline;
  @JsonKey(defaultValue: false)
  @override
  final bool wifiOnline;
  @JsonKey(defaultValue: false)
  @override
  final bool mobileOnline;

  @override
  String toString() {
    return 'NetworkState(bluetoothOnline: $bluetoothOnline, wifiOnline: $wifiOnline, mobileOnline: $mobileOnline)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NetworkState &&
            (identical(other.bluetoothOnline, bluetoothOnline) ||
                const DeepCollectionEquality()
                    .equals(other.bluetoothOnline, bluetoothOnline)) &&
            (identical(other.wifiOnline, wifiOnline) ||
                const DeepCollectionEquality()
                    .equals(other.wifiOnline, wifiOnline)) &&
            (identical(other.mobileOnline, mobileOnline) ||
                const DeepCollectionEquality()
                    .equals(other.mobileOnline, mobileOnline)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(bluetoothOnline) ^
      const DeepCollectionEquality().hash(wifiOnline) ^
      const DeepCollectionEquality().hash(mobileOnline);

  @JsonKey(ignore: true)
  @override
  _$NetworkStateCopyWith<_NetworkState> get copyWith =>
      __$NetworkStateCopyWithImpl<_NetworkState>(this, _$identity);
}

abstract class _NetworkState extends NetworkState {
  const factory _NetworkState(
      {bool bluetoothOnline,
      bool wifiOnline,
      bool mobileOnline}) = _$_NetworkState;
  const _NetworkState._() : super._();

  @override
  bool get bluetoothOnline => throw _privateConstructorUsedError;
  @override
  bool get wifiOnline => throw _privateConstructorUsedError;
  @override
  bool get mobileOnline => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$NetworkStateCopyWith<_NetworkState> get copyWith =>
      throw _privateConstructorUsedError;
}
