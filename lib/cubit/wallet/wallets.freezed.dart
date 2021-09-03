// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wallets.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$WalletsStateTearOff {
  const _$WalletsStateTearOff();

  _WalletsState call({List<Wallet> wallets = const []}) {
    return _WalletsState(
      wallets: wallets,
    );
  }
}

/// @nodoc
const $WalletsState = _$WalletsStateTearOff();

/// @nodoc
mixin _$WalletsState {
  List<Wallet> get wallets => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WalletsStateCopyWith<WalletsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletsStateCopyWith<$Res> {
  factory $WalletsStateCopyWith(
          WalletsState value, $Res Function(WalletsState) then) =
      _$WalletsStateCopyWithImpl<$Res>;
  $Res call({List<Wallet> wallets});
}

/// @nodoc
class _$WalletsStateCopyWithImpl<$Res> implements $WalletsStateCopyWith<$Res> {
  _$WalletsStateCopyWithImpl(this._value, this._then);

  final WalletsState _value;
  // ignore: unused_field
  final $Res Function(WalletsState) _then;

  @override
  $Res call({
    Object? wallets = freezed,
  }) {
    return _then(_value.copyWith(
      wallets: wallets == freezed
          ? _value.wallets
          : wallets // ignore: cast_nullable_to_non_nullable
              as List<Wallet>,
    ));
  }
}

/// @nodoc
abstract class _$WalletsStateCopyWith<$Res>
    implements $WalletsStateCopyWith<$Res> {
  factory _$WalletsStateCopyWith(
          _WalletsState value, $Res Function(_WalletsState) then) =
      __$WalletsStateCopyWithImpl<$Res>;
  @override
  $Res call({List<Wallet> wallets});
}

/// @nodoc
class __$WalletsStateCopyWithImpl<$Res> extends _$WalletsStateCopyWithImpl<$Res>
    implements _$WalletsStateCopyWith<$Res> {
  __$WalletsStateCopyWithImpl(
      _WalletsState _value, $Res Function(_WalletsState) _then)
      : super(_value, (v) => _then(v as _WalletsState));

  @override
  _WalletsState get _value => super._value as _WalletsState;

  @override
  $Res call({
    Object? wallets = freezed,
  }) {
    return _then(_WalletsState(
      wallets: wallets == freezed
          ? _value.wallets
          : wallets // ignore: cast_nullable_to_non_nullable
              as List<Wallet>,
    ));
  }
}

/// @nodoc

class _$_WalletsState with DiagnosticableTreeMixin implements _WalletsState {
  const _$_WalletsState({this.wallets = const []});

  @JsonKey(defaultValue: const [])
  @override
  final List<Wallet> wallets;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletsState(wallets: $wallets)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletsState'))
      ..add(DiagnosticsProperty('wallets', wallets));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WalletsState &&
            (identical(other.wallets, wallets) ||
                const DeepCollectionEquality().equals(other.wallets, wallets)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(wallets);

  @JsonKey(ignore: true)
  @override
  _$WalletsStateCopyWith<_WalletsState> get copyWith =>
      __$WalletsStateCopyWithImpl<_WalletsState>(this, _$identity);
}

abstract class _WalletsState implements WalletsState {
  const factory _WalletsState({List<Wallet> wallets}) = _$_WalletsState;

  @override
  List<Wallet> get wallets => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$WalletsStateCopyWith<_WalletsState> get copyWith =>
      throw _privateConstructorUsedError;
}
