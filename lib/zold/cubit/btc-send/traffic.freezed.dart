// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'traffic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TrafficStateTearOff {
  const _$TrafficStateTearOff();

  _TrafficState call({Fee? fee, bool loading = false, String error = ''}) {
    return _TrafficState(
      fee: fee,
      loading: loading,
      error: error,
    );
  }
}

/// @nodoc
const $TrafficState = _$TrafficStateTearOff();

/// @nodoc
mixin _$TrafficState {
  Fee? get fee => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TrafficStateCopyWith<TrafficState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrafficStateCopyWith<$Res> {
  factory $TrafficStateCopyWith(
          TrafficState value, $Res Function(TrafficState) then) =
      _$TrafficStateCopyWithImpl<$Res>;
  $Res call({Fee? fee, bool loading, String error});

  $FeeCopyWith<$Res>? get fee;
}

/// @nodoc
class _$TrafficStateCopyWithImpl<$Res> implements $TrafficStateCopyWith<$Res> {
  _$TrafficStateCopyWithImpl(this._value, this._then);

  final TrafficState _value;
  // ignore: unused_field
  final $Res Function(TrafficState) _then;

  @override
  $Res call({
    Object? fee = freezed,
    Object? loading = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      fee: fee == freezed
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as Fee?,
      loading: loading == freezed
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $FeeCopyWith<$Res>? get fee {
    if (_value.fee == null) {
      return null;
    }

    return $FeeCopyWith<$Res>(_value.fee!, (value) {
      return _then(_value.copyWith(fee: value));
    });
  }
}

/// @nodoc
abstract class _$TrafficStateCopyWith<$Res>
    implements $TrafficStateCopyWith<$Res> {
  factory _$TrafficStateCopyWith(
          _TrafficState value, $Res Function(_TrafficState) then) =
      __$TrafficStateCopyWithImpl<$Res>;
  @override
  $Res call({Fee? fee, bool loading, String error});

  @override
  $FeeCopyWith<$Res>? get fee;
}

/// @nodoc
class __$TrafficStateCopyWithImpl<$Res> extends _$TrafficStateCopyWithImpl<$Res>
    implements _$TrafficStateCopyWith<$Res> {
  __$TrafficStateCopyWithImpl(
      _TrafficState _value, $Res Function(_TrafficState) _then)
      : super(_value, (v) => _then(v as _TrafficState));

  @override
  _TrafficState get _value => super._value as _TrafficState;

  @override
  $Res call({
    Object? fee = freezed,
    Object? loading = freezed,
    Object? error = freezed,
  }) {
    return _then(_TrafficState(
      fee: fee == freezed
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as Fee?,
      loading: loading == freezed
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_TrafficState implements _TrafficState {
  const _$_TrafficState({this.fee, this.loading = false, this.error = ''});

  @override
  final Fee? fee;
  @JsonKey(defaultValue: false)
  @override
  final bool loading;
  @JsonKey(defaultValue: '')
  @override
  final String error;

  @override
  String toString() {
    return 'TrafficState(fee: $fee, loading: $loading, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TrafficState &&
            (identical(other.fee, fee) ||
                const DeepCollectionEquality().equals(other.fee, fee)) &&
            (identical(other.loading, loading) ||
                const DeepCollectionEquality()
                    .equals(other.loading, loading)) &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(fee) ^
      const DeepCollectionEquality().hash(loading) ^
      const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  _$TrafficStateCopyWith<_TrafficState> get copyWith =>
      __$TrafficStateCopyWithImpl<_TrafficState>(this, _$identity);
}

abstract class _TrafficState implements TrafficState {
  const factory _TrafficState({Fee? fee, bool loading, String error}) =
      _$_TrafficState;

  @override
  Fee? get fee => throw _privateConstructorUsedError;
  @override
  bool get loading => throw _privateConstructorUsedError;
  @override
  String get error => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TrafficStateCopyWith<_TrafficState> get copyWith =>
      throw _privateConstructorUsedError;
}
