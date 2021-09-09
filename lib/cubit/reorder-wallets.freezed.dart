// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'reorder-wallets.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ReorderWalletsStateTearOff {
  const _$ReorderWalletsStateTearOff();

  _ReorderWalletsState call(
      {List<Wallet> wallets = const [], bool arranging = false}) {
    return _ReorderWalletsState(
      wallets: wallets,
      arranging: arranging,
    );
  }
}

/// @nodoc
const $ReorderWalletsState = _$ReorderWalletsStateTearOff();

/// @nodoc
mixin _$ReorderWalletsState {
  List<Wallet> get wallets => throw _privateConstructorUsedError;
  bool get arranging => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReorderWalletsStateCopyWith<ReorderWalletsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReorderWalletsStateCopyWith<$Res> {
  factory $ReorderWalletsStateCopyWith(
          ReorderWalletsState value, $Res Function(ReorderWalletsState) then) =
      _$ReorderWalletsStateCopyWithImpl<$Res>;
  $Res call({List<Wallet> wallets, bool arranging});
}

/// @nodoc
class _$ReorderWalletsStateCopyWithImpl<$Res>
    implements $ReorderWalletsStateCopyWith<$Res> {
  _$ReorderWalletsStateCopyWithImpl(this._value, this._then);

  final ReorderWalletsState _value;
  // ignore: unused_field
  final $Res Function(ReorderWalletsState) _then;

  @override
  $Res call({
    Object? wallets = freezed,
    Object? arranging = freezed,
  }) {
    return _then(_value.copyWith(
      wallets: wallets == freezed
          ? _value.wallets
          : wallets // ignore: cast_nullable_to_non_nullable
              as List<Wallet>,
      arranging: arranging == freezed
          ? _value.arranging
          : arranging // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$ReorderWalletsStateCopyWith<$Res>
    implements $ReorderWalletsStateCopyWith<$Res> {
  factory _$ReorderWalletsStateCopyWith(_ReorderWalletsState value,
          $Res Function(_ReorderWalletsState) then) =
      __$ReorderWalletsStateCopyWithImpl<$Res>;
  @override
  $Res call({List<Wallet> wallets, bool arranging});
}

/// @nodoc
class __$ReorderWalletsStateCopyWithImpl<$Res>
    extends _$ReorderWalletsStateCopyWithImpl<$Res>
    implements _$ReorderWalletsStateCopyWith<$Res> {
  __$ReorderWalletsStateCopyWithImpl(
      _ReorderWalletsState _value, $Res Function(_ReorderWalletsState) _then)
      : super(_value, (v) => _then(v as _ReorderWalletsState));

  @override
  _ReorderWalletsState get _value => super._value as _ReorderWalletsState;

  @override
  $Res call({
    Object? wallets = freezed,
    Object? arranging = freezed,
  }) {
    return _then(_ReorderWalletsState(
      wallets: wallets == freezed
          ? _value.wallets
          : wallets // ignore: cast_nullable_to_non_nullable
              as List<Wallet>,
      arranging: arranging == freezed
          ? _value.arranging
          : arranging // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ReorderWalletsState implements _ReorderWalletsState {
  const _$_ReorderWalletsState(
      {this.wallets = const [], this.arranging = false});

  @JsonKey(defaultValue: const [])
  @override
  final List<Wallet> wallets;
  @JsonKey(defaultValue: false)
  @override
  final bool arranging;

  @override
  String toString() {
    return 'ReorderWalletsState(wallets: $wallets, arranging: $arranging)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ReorderWalletsState &&
            (identical(other.wallets, wallets) ||
                const DeepCollectionEquality()
                    .equals(other.wallets, wallets)) &&
            (identical(other.arranging, arranging) ||
                const DeepCollectionEquality()
                    .equals(other.arranging, arranging)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(wallets) ^
      const DeepCollectionEquality().hash(arranging);

  @JsonKey(ignore: true)
  @override
  _$ReorderWalletsStateCopyWith<_ReorderWalletsState> get copyWith =>
      __$ReorderWalletsStateCopyWithImpl<_ReorderWalletsState>(
          this, _$identity);
}

abstract class _ReorderWalletsState implements ReorderWalletsState {
  const factory _ReorderWalletsState({List<Wallet> wallets, bool arranging}) =
      _$_ReorderWalletsState;

  @override
  List<Wallet> get wallets => throw _privateConstructorUsedError;
  @override
  bool get arranging => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ReorderWalletsStateCopyWith<_ReorderWalletsState> get copyWith =>
      throw _privateConstructorUsedError;
}
