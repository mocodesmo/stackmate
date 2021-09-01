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

/// @nodoc
class _$WalletStateTearOff {
  const _$WalletStateTearOff();

  _WalletState call(
      {List<SoloWallet> wallets = const [],
      SoloWallet? selectedWallet,
      bool loadingWallets = false,
      String loadingWalletsError = '',
      bool creatingBtcWallet = false,
      String createBtcWalletError = ''}) {
    return _WalletState(
      wallets: wallets,
      selectedWallet: selectedWallet,
      loadingWallets: loadingWallets,
      loadingWalletsError: loadingWalletsError,
      creatingBtcWallet: creatingBtcWallet,
      createBtcWalletError: createBtcWalletError,
    );
  }
}

/// @nodoc
const $WalletState = _$WalletStateTearOff();

/// @nodoc
mixin _$WalletState {
  List<SoloWallet> get wallets => throw _privateConstructorUsedError;
  SoloWallet? get selectedWallet => throw _privateConstructorUsedError;
  bool get loadingWallets => throw _privateConstructorUsedError;
  String get loadingWalletsError => throw _privateConstructorUsedError;
  bool get creatingBtcWallet => throw _privateConstructorUsedError;
  String get createBtcWalletError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WalletStateCopyWith<WalletState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletStateCopyWith<$Res> {
  factory $WalletStateCopyWith(
          WalletState value, $Res Function(WalletState) then) =
      _$WalletStateCopyWithImpl<$Res>;
  $Res call(
      {List<SoloWallet> wallets,
      SoloWallet? selectedWallet,
      bool loadingWallets,
      String loadingWalletsError,
      bool creatingBtcWallet,
      String createBtcWalletError});

  $SoloWalletCopyWith<$Res>? get selectedWallet;
}

/// @nodoc
class _$WalletStateCopyWithImpl<$Res> implements $WalletStateCopyWith<$Res> {
  _$WalletStateCopyWithImpl(this._value, this._then);

  final WalletState _value;
  // ignore: unused_field
  final $Res Function(WalletState) _then;

  @override
  $Res call({
    Object? wallets = freezed,
    Object? selectedWallet = freezed,
    Object? loadingWallets = freezed,
    Object? loadingWalletsError = freezed,
    Object? creatingBtcWallet = freezed,
    Object? createBtcWalletError = freezed,
  }) {
    return _then(_value.copyWith(
      wallets: wallets == freezed
          ? _value.wallets
          : wallets // ignore: cast_nullable_to_non_nullable
              as List<SoloWallet>,
      selectedWallet: selectedWallet == freezed
          ? _value.selectedWallet
          : selectedWallet // ignore: cast_nullable_to_non_nullable
              as SoloWallet?,
      loadingWallets: loadingWallets == freezed
          ? _value.loadingWallets
          : loadingWallets // ignore: cast_nullable_to_non_nullable
              as bool,
      loadingWalletsError: loadingWalletsError == freezed
          ? _value.loadingWalletsError
          : loadingWalletsError // ignore: cast_nullable_to_non_nullable
              as String,
      creatingBtcWallet: creatingBtcWallet == freezed
          ? _value.creatingBtcWallet
          : creatingBtcWallet // ignore: cast_nullable_to_non_nullable
              as bool,
      createBtcWalletError: createBtcWalletError == freezed
          ? _value.createBtcWalletError
          : createBtcWalletError // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $SoloWalletCopyWith<$Res>? get selectedWallet {
    if (_value.selectedWallet == null) {
      return null;
    }

    return $SoloWalletCopyWith<$Res>(_value.selectedWallet!, (value) {
      return _then(_value.copyWith(selectedWallet: value));
    });
  }
}

/// @nodoc
abstract class _$WalletStateCopyWith<$Res>
    implements $WalletStateCopyWith<$Res> {
  factory _$WalletStateCopyWith(
          _WalletState value, $Res Function(_WalletState) then) =
      __$WalletStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<SoloWallet> wallets,
      SoloWallet? selectedWallet,
      bool loadingWallets,
      String loadingWalletsError,
      bool creatingBtcWallet,
      String createBtcWalletError});

  @override
  $SoloWalletCopyWith<$Res>? get selectedWallet;
}

/// @nodoc
class __$WalletStateCopyWithImpl<$Res> extends _$WalletStateCopyWithImpl<$Res>
    implements _$WalletStateCopyWith<$Res> {
  __$WalletStateCopyWithImpl(
      _WalletState _value, $Res Function(_WalletState) _then)
      : super(_value, (v) => _then(v as _WalletState));

  @override
  _WalletState get _value => super._value as _WalletState;

  @override
  $Res call({
    Object? wallets = freezed,
    Object? selectedWallet = freezed,
    Object? loadingWallets = freezed,
    Object? loadingWalletsError = freezed,
    Object? creatingBtcWallet = freezed,
    Object? createBtcWalletError = freezed,
  }) {
    return _then(_WalletState(
      wallets: wallets == freezed
          ? _value.wallets
          : wallets // ignore: cast_nullable_to_non_nullable
              as List<SoloWallet>,
      selectedWallet: selectedWallet == freezed
          ? _value.selectedWallet
          : selectedWallet // ignore: cast_nullable_to_non_nullable
              as SoloWallet?,
      loadingWallets: loadingWallets == freezed
          ? _value.loadingWallets
          : loadingWallets // ignore: cast_nullable_to_non_nullable
              as bool,
      loadingWalletsError: loadingWalletsError == freezed
          ? _value.loadingWalletsError
          : loadingWalletsError // ignore: cast_nullable_to_non_nullable
              as String,
      creatingBtcWallet: creatingBtcWallet == freezed
          ? _value.creatingBtcWallet
          : creatingBtcWallet // ignore: cast_nullable_to_non_nullable
              as bool,
      createBtcWalletError: createBtcWalletError == freezed
          ? _value.createBtcWalletError
          : createBtcWalletError // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_WalletState extends _WalletState with DiagnosticableTreeMixin {
  const _$_WalletState(
      {this.wallets = const [],
      this.selectedWallet,
      this.loadingWallets = false,
      this.loadingWalletsError = '',
      this.creatingBtcWallet = false,
      this.createBtcWalletError = ''})
      : super._();

  @JsonKey(defaultValue: const [])
  @override
  final List<SoloWallet> wallets;
  @override
  final SoloWallet? selectedWallet;
  @JsonKey(defaultValue: false)
  @override
  final bool loadingWallets;
  @JsonKey(defaultValue: '')
  @override
  final String loadingWalletsError;
  @JsonKey(defaultValue: false)
  @override
  final bool creatingBtcWallet;
  @JsonKey(defaultValue: '')
  @override
  final String createBtcWalletError;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletState(wallets: $wallets, selectedWallet: $selectedWallet, loadingWallets: $loadingWallets, loadingWalletsError: $loadingWalletsError, creatingBtcWallet: $creatingBtcWallet, createBtcWalletError: $createBtcWalletError)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletState'))
      ..add(DiagnosticsProperty('wallets', wallets))
      ..add(DiagnosticsProperty('selectedWallet', selectedWallet))
      ..add(DiagnosticsProperty('loadingWallets', loadingWallets))
      ..add(DiagnosticsProperty('loadingWalletsError', loadingWalletsError))
      ..add(DiagnosticsProperty('creatingBtcWallet', creatingBtcWallet))
      ..add(DiagnosticsProperty('createBtcWalletError', createBtcWalletError));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WalletState &&
            (identical(other.wallets, wallets) ||
                const DeepCollectionEquality()
                    .equals(other.wallets, wallets)) &&
            (identical(other.selectedWallet, selectedWallet) ||
                const DeepCollectionEquality()
                    .equals(other.selectedWallet, selectedWallet)) &&
            (identical(other.loadingWallets, loadingWallets) ||
                const DeepCollectionEquality()
                    .equals(other.loadingWallets, loadingWallets)) &&
            (identical(other.loadingWalletsError, loadingWalletsError) ||
                const DeepCollectionEquality()
                    .equals(other.loadingWalletsError, loadingWalletsError)) &&
            (identical(other.creatingBtcWallet, creatingBtcWallet) ||
                const DeepCollectionEquality()
                    .equals(other.creatingBtcWallet, creatingBtcWallet)) &&
            (identical(other.createBtcWalletError, createBtcWalletError) ||
                const DeepCollectionEquality()
                    .equals(other.createBtcWalletError, createBtcWalletError)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(wallets) ^
      const DeepCollectionEquality().hash(selectedWallet) ^
      const DeepCollectionEquality().hash(loadingWallets) ^
      const DeepCollectionEquality().hash(loadingWalletsError) ^
      const DeepCollectionEquality().hash(creatingBtcWallet) ^
      const DeepCollectionEquality().hash(createBtcWalletError);

  @JsonKey(ignore: true)
  @override
  _$WalletStateCopyWith<_WalletState> get copyWith =>
      __$WalletStateCopyWithImpl<_WalletState>(this, _$identity);
}

abstract class _WalletState extends WalletState {
  const factory _WalletState(
      {List<SoloWallet> wallets,
      SoloWallet? selectedWallet,
      bool loadingWallets,
      String loadingWalletsError,
      bool creatingBtcWallet,
      String createBtcWalletError}) = _$_WalletState;
  const _WalletState._() : super._();

  @override
  List<SoloWallet> get wallets => throw _privateConstructorUsedError;
  @override
  SoloWallet? get selectedWallet => throw _privateConstructorUsedError;
  @override
  bool get loadingWallets => throw _privateConstructorUsedError;
  @override
  String get loadingWalletsError => throw _privateConstructorUsedError;
  @override
  bool get creatingBtcWallet => throw _privateConstructorUsedError;
  @override
  String get createBtcWalletError => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$WalletStateCopyWith<_WalletState> get copyWith =>
      throw _privateConstructorUsedError;
}
