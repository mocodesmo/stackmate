// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wallet-solo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SoloWallet _$SoloWalletFromJson(Map<String, dynamic> json) {
  return _SoloWallet.fromJson(json);
}

/// @nodoc
class _$SoloWalletTearOff {
  const _$SoloWalletTearOff();

  _SoloWallet call(
      {@JsonKey(name: 'genesis')
          int genesis = 0,
      @JsonKey(name: 'nickname')
          String nickname = '',
      @JsonKey(name: 'fingerprint')
          String fingerprint = '',
      @JsonKey(name: 'path')
          String path = '',
      @JsonKey(name: 'xpub')
          String xpub = '',
      @JsonKey(name: 'address')
          String address = '',
      @JsonKey(name: 'label')
          String label = '',
      @JsonKey(name: 'index')
          int index = 0,
      bool watchOnly = true,
      @JsonKey(name: 'balances')
          WalletBalances balances = const WalletBalances()}) {
    return _SoloWallet(
      genesis: genesis,
      nickname: nickname,
      fingerprint: fingerprint,
      path: path,
      xpub: xpub,
      address: address,
      label: label,
      index: index,
      watchOnly: watchOnly,
      balances: balances,
    );
  }

  SoloWallet fromJson(Map<String, Object> json) {
    return SoloWallet.fromJson(json);
  }
}

/// @nodoc
const $SoloWallet = _$SoloWalletTearOff();

/// @nodoc
mixin _$SoloWallet {
  @JsonKey(name: 'genesis')
  int get genesis => throw _privateConstructorUsedError;
  @JsonKey(name: 'nickname')
  String get nickname => throw _privateConstructorUsedError;
  @JsonKey(name: 'fingerprint')
  String get fingerprint => throw _privateConstructorUsedError;
  @JsonKey(name: 'path')
  String get path => throw _privateConstructorUsedError;
  @JsonKey(name: 'xpub')
  String get xpub => throw _privateConstructorUsedError;
  @JsonKey(name: 'address')
  String get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'label')
  String get label => throw _privateConstructorUsedError;
  @JsonKey(name: 'index')
  int get index => throw _privateConstructorUsedError;
  bool get watchOnly => throw _privateConstructorUsedError;
  @JsonKey(name: 'balances')
  WalletBalances get balances => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SoloWalletCopyWith<SoloWallet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SoloWalletCopyWith<$Res> {
  factory $SoloWalletCopyWith(
          SoloWallet value, $Res Function(SoloWallet) then) =
      _$SoloWalletCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'genesis') int genesis,
      @JsonKey(name: 'nickname') String nickname,
      @JsonKey(name: 'fingerprint') String fingerprint,
      @JsonKey(name: 'path') String path,
      @JsonKey(name: 'xpub') String xpub,
      @JsonKey(name: 'address') String address,
      @JsonKey(name: 'label') String label,
      @JsonKey(name: 'index') int index,
      bool watchOnly,
      @JsonKey(name: 'balances') WalletBalances balances});

  $WalletBalancesCopyWith<$Res> get balances;
}

/// @nodoc
class _$SoloWalletCopyWithImpl<$Res> implements $SoloWalletCopyWith<$Res> {
  _$SoloWalletCopyWithImpl(this._value, this._then);

  final SoloWallet _value;
  // ignore: unused_field
  final $Res Function(SoloWallet) _then;

  @override
  $Res call({
    Object? genesis = freezed,
    Object? nickname = freezed,
    Object? fingerprint = freezed,
    Object? path = freezed,
    Object? xpub = freezed,
    Object? address = freezed,
    Object? label = freezed,
    Object? index = freezed,
    Object? watchOnly = freezed,
    Object? balances = freezed,
  }) {
    return _then(_value.copyWith(
      genesis: genesis == freezed
          ? _value.genesis
          : genesis // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      fingerprint: fingerprint == freezed
          ? _value.fingerprint
          : fingerprint // ignore: cast_nullable_to_non_nullable
              as String,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      xpub: xpub == freezed
          ? _value.xpub
          : xpub // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      watchOnly: watchOnly == freezed
          ? _value.watchOnly
          : watchOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      balances: balances == freezed
          ? _value.balances
          : balances // ignore: cast_nullable_to_non_nullable
              as WalletBalances,
    ));
  }

  @override
  $WalletBalancesCopyWith<$Res> get balances {
    return $WalletBalancesCopyWith<$Res>(_value.balances, (value) {
      return _then(_value.copyWith(balances: value));
    });
  }
}

/// @nodoc
abstract class _$SoloWalletCopyWith<$Res> implements $SoloWalletCopyWith<$Res> {
  factory _$SoloWalletCopyWith(
          _SoloWallet value, $Res Function(_SoloWallet) then) =
      __$SoloWalletCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'genesis') int genesis,
      @JsonKey(name: 'nickname') String nickname,
      @JsonKey(name: 'fingerprint') String fingerprint,
      @JsonKey(name: 'path') String path,
      @JsonKey(name: 'xpub') String xpub,
      @JsonKey(name: 'address') String address,
      @JsonKey(name: 'label') String label,
      @JsonKey(name: 'index') int index,
      bool watchOnly,
      @JsonKey(name: 'balances') WalletBalances balances});

  @override
  $WalletBalancesCopyWith<$Res> get balances;
}

/// @nodoc
class __$SoloWalletCopyWithImpl<$Res> extends _$SoloWalletCopyWithImpl<$Res>
    implements _$SoloWalletCopyWith<$Res> {
  __$SoloWalletCopyWithImpl(
      _SoloWallet _value, $Res Function(_SoloWallet) _then)
      : super(_value, (v) => _then(v as _SoloWallet));

  @override
  _SoloWallet get _value => super._value as _SoloWallet;

  @override
  $Res call({
    Object? genesis = freezed,
    Object? nickname = freezed,
    Object? fingerprint = freezed,
    Object? path = freezed,
    Object? xpub = freezed,
    Object? address = freezed,
    Object? label = freezed,
    Object? index = freezed,
    Object? watchOnly = freezed,
    Object? balances = freezed,
  }) {
    return _then(_SoloWallet(
      genesis: genesis == freezed
          ? _value.genesis
          : genesis // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      fingerprint: fingerprint == freezed
          ? _value.fingerprint
          : fingerprint // ignore: cast_nullable_to_non_nullable
              as String,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      xpub: xpub == freezed
          ? _value.xpub
          : xpub // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      watchOnly: watchOnly == freezed
          ? _value.watchOnly
          : watchOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      balances: balances == freezed
          ? _value.balances
          : balances // ignore: cast_nullable_to_non_nullable
              as WalletBalances,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SoloWallet extends _SoloWallet {
  const _$_SoloWallet(
      {@JsonKey(name: 'genesis') this.genesis = 0,
      @JsonKey(name: 'nickname') this.nickname = '',
      @JsonKey(name: 'fingerprint') this.fingerprint = '',
      @JsonKey(name: 'path') this.path = '',
      @JsonKey(name: 'xpub') this.xpub = '',
      @JsonKey(name: 'address') this.address = '',
      @JsonKey(name: 'label') this.label = '',
      @JsonKey(name: 'index') this.index = 0,
      this.watchOnly = true,
      @JsonKey(name: 'balances') this.balances = const WalletBalances()})
      : super._();

  factory _$_SoloWallet.fromJson(Map<String, dynamic> json) =>
      _$$_SoloWalletFromJson(json);

  @override
  @JsonKey(name: 'genesis')
  final int genesis;
  @override
  @JsonKey(name: 'nickname')
  final String nickname;
  @override
  @JsonKey(name: 'fingerprint')
  final String fingerprint;
  @override
  @JsonKey(name: 'path')
  final String path;
  @override
  @JsonKey(name: 'xpub')
  final String xpub;
  @override
  @JsonKey(name: 'address')
  final String address;
  @override
  @JsonKey(name: 'label')
  final String label;
  @override
  @JsonKey(name: 'index')
  final int index;
  @JsonKey(defaultValue: true)
  @override
  final bool watchOnly;
  @override
  @JsonKey(name: 'balances')
  final WalletBalances balances;

  @override
  String toString() {
    return 'SoloWallet(genesis: $genesis, nickname: $nickname, fingerprint: $fingerprint, path: $path, xpub: $xpub, address: $address, label: $label, index: $index, watchOnly: $watchOnly, balances: $balances)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SoloWallet &&
            (identical(other.genesis, genesis) ||
                const DeepCollectionEquality()
                    .equals(other.genesis, genesis)) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality()
                    .equals(other.nickname, nickname)) &&
            (identical(other.fingerprint, fingerprint) ||
                const DeepCollectionEquality()
                    .equals(other.fingerprint, fingerprint)) &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.xpub, xpub) ||
                const DeepCollectionEquality().equals(other.xpub, xpub)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.index, index) ||
                const DeepCollectionEquality().equals(other.index, index)) &&
            (identical(other.watchOnly, watchOnly) ||
                const DeepCollectionEquality()
                    .equals(other.watchOnly, watchOnly)) &&
            (identical(other.balances, balances) ||
                const DeepCollectionEquality()
                    .equals(other.balances, balances)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(genesis) ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(fingerprint) ^
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(xpub) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(index) ^
      const DeepCollectionEquality().hash(watchOnly) ^
      const DeepCollectionEquality().hash(balances);

  @JsonKey(ignore: true)
  @override
  _$SoloWalletCopyWith<_SoloWallet> get copyWith =>
      __$SoloWalletCopyWithImpl<_SoloWallet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SoloWalletToJson(this);
  }
}

abstract class _SoloWallet extends SoloWallet {
  const factory _SoloWallet(
      {@JsonKey(name: 'genesis') int genesis,
      @JsonKey(name: 'nickname') String nickname,
      @JsonKey(name: 'fingerprint') String fingerprint,
      @JsonKey(name: 'path') String path,
      @JsonKey(name: 'xpub') String xpub,
      @JsonKey(name: 'address') String address,
      @JsonKey(name: 'label') String label,
      @JsonKey(name: 'index') int index,
      bool watchOnly,
      @JsonKey(name: 'balances') WalletBalances balances}) = _$_SoloWallet;
  const _SoloWallet._() : super._();

  factory _SoloWallet.fromJson(Map<String, dynamic> json) =
      _$_SoloWallet.fromJson;

  @override
  @JsonKey(name: 'genesis')
  int get genesis => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'nickname')
  String get nickname => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'fingerprint')
  String get fingerprint => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'path')
  String get path => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'xpub')
  String get xpub => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'address')
  String get address => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'label')
  String get label => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'index')
  int get index => throw _privateConstructorUsedError;
  @override
  bool get watchOnly => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'balances')
  WalletBalances get balances => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SoloWalletCopyWith<_SoloWallet> get copyWith =>
      throw _privateConstructorUsedError;
}

WalletBalances _$WalletBalancesFromJson(Map<String, dynamic> json) {
  return _WalletBalances.fromJson(json);
}

/// @nodoc
class _$WalletBalancesTearOff {
  const _$WalletBalancesTearOff();

  _WalletBalances call(
      {@JsonKey(name: 'confirmed') int confirmed = 0,
      @JsonKey(name: 'unconfirmed') int unconfirmed = 0}) {
    return _WalletBalances(
      confirmed: confirmed,
      unconfirmed: unconfirmed,
    );
  }

  WalletBalances fromJson(Map<String, Object> json) {
    return WalletBalances.fromJson(json);
  }
}

/// @nodoc
const $WalletBalances = _$WalletBalancesTearOff();

/// @nodoc
mixin _$WalletBalances {
  @JsonKey(name: 'confirmed')
  int get confirmed => throw _privateConstructorUsedError;
  @JsonKey(name: 'unconfirmed')
  int get unconfirmed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WalletBalancesCopyWith<WalletBalances> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletBalancesCopyWith<$Res> {
  factory $WalletBalancesCopyWith(
          WalletBalances value, $Res Function(WalletBalances) then) =
      _$WalletBalancesCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'confirmed') int confirmed,
      @JsonKey(name: 'unconfirmed') int unconfirmed});
}

/// @nodoc
class _$WalletBalancesCopyWithImpl<$Res>
    implements $WalletBalancesCopyWith<$Res> {
  _$WalletBalancesCopyWithImpl(this._value, this._then);

  final WalletBalances _value;
  // ignore: unused_field
  final $Res Function(WalletBalances) _then;

  @override
  $Res call({
    Object? confirmed = freezed,
    Object? unconfirmed = freezed,
  }) {
    return _then(_value.copyWith(
      confirmed: confirmed == freezed
          ? _value.confirmed
          : confirmed // ignore: cast_nullable_to_non_nullable
              as int,
      unconfirmed: unconfirmed == freezed
          ? _value.unconfirmed
          : unconfirmed // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$WalletBalancesCopyWith<$Res>
    implements $WalletBalancesCopyWith<$Res> {
  factory _$WalletBalancesCopyWith(
          _WalletBalances value, $Res Function(_WalletBalances) then) =
      __$WalletBalancesCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'confirmed') int confirmed,
      @JsonKey(name: 'unconfirmed') int unconfirmed});
}

/// @nodoc
class __$WalletBalancesCopyWithImpl<$Res>
    extends _$WalletBalancesCopyWithImpl<$Res>
    implements _$WalletBalancesCopyWith<$Res> {
  __$WalletBalancesCopyWithImpl(
      _WalletBalances _value, $Res Function(_WalletBalances) _then)
      : super(_value, (v) => _then(v as _WalletBalances));

  @override
  _WalletBalances get _value => super._value as _WalletBalances;

  @override
  $Res call({
    Object? confirmed = freezed,
    Object? unconfirmed = freezed,
  }) {
    return _then(_WalletBalances(
      confirmed: confirmed == freezed
          ? _value.confirmed
          : confirmed // ignore: cast_nullable_to_non_nullable
              as int,
      unconfirmed: unconfirmed == freezed
          ? _value.unconfirmed
          : unconfirmed // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WalletBalances extends _WalletBalances {
  const _$_WalletBalances(
      {@JsonKey(name: 'confirmed') this.confirmed = 0,
      @JsonKey(name: 'unconfirmed') this.unconfirmed = 0})
      : super._();

  factory _$_WalletBalances.fromJson(Map<String, dynamic> json) =>
      _$$_WalletBalancesFromJson(json);

  @override
  @JsonKey(name: 'confirmed')
  final int confirmed;
  @override
  @JsonKey(name: 'unconfirmed')
  final int unconfirmed;

  @override
  String toString() {
    return 'WalletBalances(confirmed: $confirmed, unconfirmed: $unconfirmed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WalletBalances &&
            (identical(other.confirmed, confirmed) ||
                const DeepCollectionEquality()
                    .equals(other.confirmed, confirmed)) &&
            (identical(other.unconfirmed, unconfirmed) ||
                const DeepCollectionEquality()
                    .equals(other.unconfirmed, unconfirmed)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(confirmed) ^
      const DeepCollectionEquality().hash(unconfirmed);

  @JsonKey(ignore: true)
  @override
  _$WalletBalancesCopyWith<_WalletBalances> get copyWith =>
      __$WalletBalancesCopyWithImpl<_WalletBalances>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WalletBalancesToJson(this);
  }
}

abstract class _WalletBalances extends WalletBalances {
  const factory _WalletBalances(
      {@JsonKey(name: 'confirmed') int confirmed,
      @JsonKey(name: 'unconfirmed') int unconfirmed}) = _$_WalletBalances;
  const _WalletBalances._() : super._();

  factory _WalletBalances.fromJson(Map<String, dynamic> json) =
      _$_WalletBalances.fromJson;

  @override
  @JsonKey(name: 'confirmed')
  int get confirmed => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'unconfirmed')
  int get unconfirmed => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$WalletBalancesCopyWith<_WalletBalances> get copyWith =>
      throw _privateConstructorUsedError;
}
