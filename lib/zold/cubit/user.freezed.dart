// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$UserStateTearOff {
  const _$UserStateTearOff();

  _UserState call(
      {bool authenticated = false,
      User? user,
      bool gettingUser = false,
      String errorOnGet = ''}) {
    return _UserState(
      authenticated: authenticated,
      user: user,
      gettingUser: gettingUser,
      errorOnGet: errorOnGet,
    );
  }
}

/// @nodoc
const $UserState = _$UserStateTearOff();

/// @nodoc
mixin _$UserState {
  bool get authenticated => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;
  bool get gettingUser => throw _privateConstructorUsedError;
  String get errorOnGet => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserStateCopyWith<UserState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStateCopyWith<$Res> {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) then) =
      _$UserStateCopyWithImpl<$Res>;
  $Res call(
      {bool authenticated, User? user, bool gettingUser, String errorOnGet});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$UserStateCopyWithImpl<$Res> implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._value, this._then);

  final UserState _value;
  // ignore: unused_field
  final $Res Function(UserState) _then;

  @override
  $Res call({
    Object? authenticated = freezed,
    Object? user = freezed,
    Object? gettingUser = freezed,
    Object? errorOnGet = freezed,
  }) {
    return _then(_value.copyWith(
      authenticated: authenticated == freezed
          ? _value.authenticated
          : authenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      gettingUser: gettingUser == freezed
          ? _value.gettingUser
          : gettingUser // ignore: cast_nullable_to_non_nullable
              as bool,
      errorOnGet: errorOnGet == freezed
          ? _value.errorOnGet
          : errorOnGet // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc
abstract class _$UserStateCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$UserStateCopyWith(
          _UserState value, $Res Function(_UserState) then) =
      __$UserStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool authenticated, User? user, bool gettingUser, String errorOnGet});

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$UserStateCopyWithImpl<$Res> extends _$UserStateCopyWithImpl<$Res>
    implements _$UserStateCopyWith<$Res> {
  __$UserStateCopyWithImpl(_UserState _value, $Res Function(_UserState) _then)
      : super(_value, (v) => _then(v as _UserState));

  @override
  _UserState get _value => super._value as _UserState;

  @override
  $Res call({
    Object? authenticated = freezed,
    Object? user = freezed,
    Object? gettingUser = freezed,
    Object? errorOnGet = freezed,
  }) {
    return _then(_UserState(
      authenticated: authenticated == freezed
          ? _value.authenticated
          : authenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      gettingUser: gettingUser == freezed
          ? _value.gettingUser
          : gettingUser // ignore: cast_nullable_to_non_nullable
              as bool,
      errorOnGet: errorOnGet == freezed
          ? _value.errorOnGet
          : errorOnGet // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_UserState implements _UserState {
  const _$_UserState(
      {this.authenticated = false,
      this.user,
      this.gettingUser = false,
      this.errorOnGet = ''});

  @JsonKey(defaultValue: false)
  @override
  final bool authenticated;
  @override
  final User? user;
  @JsonKey(defaultValue: false)
  @override
  final bool gettingUser;
  @JsonKey(defaultValue: '')
  @override
  final String errorOnGet;

  @override
  String toString() {
    return 'UserState(authenticated: $authenticated, user: $user, gettingUser: $gettingUser, errorOnGet: $errorOnGet)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UserState &&
            (identical(other.authenticated, authenticated) ||
                const DeepCollectionEquality()
                    .equals(other.authenticated, authenticated)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.gettingUser, gettingUser) ||
                const DeepCollectionEquality()
                    .equals(other.gettingUser, gettingUser)) &&
            (identical(other.errorOnGet, errorOnGet) ||
                const DeepCollectionEquality()
                    .equals(other.errorOnGet, errorOnGet)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(authenticated) ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(gettingUser) ^
      const DeepCollectionEquality().hash(errorOnGet);

  @JsonKey(ignore: true)
  @override
  _$UserStateCopyWith<_UserState> get copyWith =>
      __$UserStateCopyWithImpl<_UserState>(this, _$identity);
}

abstract class _UserState implements UserState {
  const factory _UserState(
      {bool authenticated,
      User? user,
      bool gettingUser,
      String errorOnGet}) = _$_UserState;

  @override
  bool get authenticated => throw _privateConstructorUsedError;
  @override
  User? get user => throw _privateConstructorUsedError;
  @override
  bool get gettingUser => throw _privateConstructorUsedError;
  @override
  String get errorOnGet => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UserStateCopyWith<_UserState> get copyWith =>
      throw _privateConstructorUsedError;
}
