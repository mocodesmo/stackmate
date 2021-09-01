// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'email-login.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$EmailStateTearOff {
  const _$EmailStateTearOff();

  _EmailState call(
      {String email = '',
      String emailError = '',
      bool sendingEmail = false,
      bool emailSent = false,
      bool checkingLink = false,
      String linkError = '',
      bool loggedIn = false}) {
    return _EmailState(
      email: email,
      emailError: emailError,
      sendingEmail: sendingEmail,
      emailSent: emailSent,
      checkingLink: checkingLink,
      linkError: linkError,
      loggedIn: loggedIn,
    );
  }
}

/// @nodoc
const $EmailState = _$EmailStateTearOff();

/// @nodoc
mixin _$EmailState {
  String get email => throw _privateConstructorUsedError;
  String get emailError => throw _privateConstructorUsedError;
  bool get sendingEmail => throw _privateConstructorUsedError;
  bool get emailSent => throw _privateConstructorUsedError;
  bool get checkingLink => throw _privateConstructorUsedError;
  String get linkError => throw _privateConstructorUsedError;
  bool get loggedIn => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EmailStateCopyWith<EmailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailStateCopyWith<$Res> {
  factory $EmailStateCopyWith(
          EmailState value, $Res Function(EmailState) then) =
      _$EmailStateCopyWithImpl<$Res>;
  $Res call(
      {String email,
      String emailError,
      bool sendingEmail,
      bool emailSent,
      bool checkingLink,
      String linkError,
      bool loggedIn});
}

/// @nodoc
class _$EmailStateCopyWithImpl<$Res> implements $EmailStateCopyWith<$Res> {
  _$EmailStateCopyWithImpl(this._value, this._then);

  final EmailState _value;
  // ignore: unused_field
  final $Res Function(EmailState) _then;

  @override
  $Res call({
    Object? email = freezed,
    Object? emailError = freezed,
    Object? sendingEmail = freezed,
    Object? emailSent = freezed,
    Object? checkingLink = freezed,
    Object? linkError = freezed,
    Object? loggedIn = freezed,
  }) {
    return _then(_value.copyWith(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      emailError: emailError == freezed
          ? _value.emailError
          : emailError // ignore: cast_nullable_to_non_nullable
              as String,
      sendingEmail: sendingEmail == freezed
          ? _value.sendingEmail
          : sendingEmail // ignore: cast_nullable_to_non_nullable
              as bool,
      emailSent: emailSent == freezed
          ? _value.emailSent
          : emailSent // ignore: cast_nullable_to_non_nullable
              as bool,
      checkingLink: checkingLink == freezed
          ? _value.checkingLink
          : checkingLink // ignore: cast_nullable_to_non_nullable
              as bool,
      linkError: linkError == freezed
          ? _value.linkError
          : linkError // ignore: cast_nullable_to_non_nullable
              as String,
      loggedIn: loggedIn == freezed
          ? _value.loggedIn
          : loggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$EmailStateCopyWith<$Res> implements $EmailStateCopyWith<$Res> {
  factory _$EmailStateCopyWith(
          _EmailState value, $Res Function(_EmailState) then) =
      __$EmailStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String email,
      String emailError,
      bool sendingEmail,
      bool emailSent,
      bool checkingLink,
      String linkError,
      bool loggedIn});
}

/// @nodoc
class __$EmailStateCopyWithImpl<$Res> extends _$EmailStateCopyWithImpl<$Res>
    implements _$EmailStateCopyWith<$Res> {
  __$EmailStateCopyWithImpl(
      _EmailState _value, $Res Function(_EmailState) _then)
      : super(_value, (v) => _then(v as _EmailState));

  @override
  _EmailState get _value => super._value as _EmailState;

  @override
  $Res call({
    Object? email = freezed,
    Object? emailError = freezed,
    Object? sendingEmail = freezed,
    Object? emailSent = freezed,
    Object? checkingLink = freezed,
    Object? linkError = freezed,
    Object? loggedIn = freezed,
  }) {
    return _then(_EmailState(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      emailError: emailError == freezed
          ? _value.emailError
          : emailError // ignore: cast_nullable_to_non_nullable
              as String,
      sendingEmail: sendingEmail == freezed
          ? _value.sendingEmail
          : sendingEmail // ignore: cast_nullable_to_non_nullable
              as bool,
      emailSent: emailSent == freezed
          ? _value.emailSent
          : emailSent // ignore: cast_nullable_to_non_nullable
              as bool,
      checkingLink: checkingLink == freezed
          ? _value.checkingLink
          : checkingLink // ignore: cast_nullable_to_non_nullable
              as bool,
      linkError: linkError == freezed
          ? _value.linkError
          : linkError // ignore: cast_nullable_to_non_nullable
              as String,
      loggedIn: loggedIn == freezed
          ? _value.loggedIn
          : loggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_EmailState implements _EmailState {
  const _$_EmailState(
      {this.email = '',
      this.emailError = '',
      this.sendingEmail = false,
      this.emailSent = false,
      this.checkingLink = false,
      this.linkError = '',
      this.loggedIn = false});

  @JsonKey(defaultValue: '')
  @override
  final String email;
  @JsonKey(defaultValue: '')
  @override
  final String emailError;
  @JsonKey(defaultValue: false)
  @override
  final bool sendingEmail;
  @JsonKey(defaultValue: false)
  @override
  final bool emailSent;
  @JsonKey(defaultValue: false)
  @override
  final bool checkingLink;
  @JsonKey(defaultValue: '')
  @override
  final String linkError;
  @JsonKey(defaultValue: false)
  @override
  final bool loggedIn;

  @override
  String toString() {
    return 'EmailState(email: $email, emailError: $emailError, sendingEmail: $sendingEmail, emailSent: $emailSent, checkingLink: $checkingLink, linkError: $linkError, loggedIn: $loggedIn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EmailState &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.emailError, emailError) ||
                const DeepCollectionEquality()
                    .equals(other.emailError, emailError)) &&
            (identical(other.sendingEmail, sendingEmail) ||
                const DeepCollectionEquality()
                    .equals(other.sendingEmail, sendingEmail)) &&
            (identical(other.emailSent, emailSent) ||
                const DeepCollectionEquality()
                    .equals(other.emailSent, emailSent)) &&
            (identical(other.checkingLink, checkingLink) ||
                const DeepCollectionEquality()
                    .equals(other.checkingLink, checkingLink)) &&
            (identical(other.linkError, linkError) ||
                const DeepCollectionEquality()
                    .equals(other.linkError, linkError)) &&
            (identical(other.loggedIn, loggedIn) ||
                const DeepCollectionEquality()
                    .equals(other.loggedIn, loggedIn)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(emailError) ^
      const DeepCollectionEquality().hash(sendingEmail) ^
      const DeepCollectionEquality().hash(emailSent) ^
      const DeepCollectionEquality().hash(checkingLink) ^
      const DeepCollectionEquality().hash(linkError) ^
      const DeepCollectionEquality().hash(loggedIn);

  @JsonKey(ignore: true)
  @override
  _$EmailStateCopyWith<_EmailState> get copyWith =>
      __$EmailStateCopyWithImpl<_EmailState>(this, _$identity);
}

abstract class _EmailState implements EmailState {
  const factory _EmailState(
      {String email,
      String emailError,
      bool sendingEmail,
      bool emailSent,
      bool checkingLink,
      String linkError,
      bool loggedIn}) = _$_EmailState;

  @override
  String get email => throw _privateConstructorUsedError;
  @override
  String get emailError => throw _privateConstructorUsedError;
  @override
  bool get sendingEmail => throw _privateConstructorUsedError;
  @override
  bool get emailSent => throw _privateConstructorUsedError;
  @override
  bool get checkingLink => throw _privateConstructorUsedError;
  @override
  String get linkError => throw _privateConstructorUsedError;
  @override
  bool get loggedIn => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EmailStateCopyWith<_EmailState> get copyWith =>
      throw _privateConstructorUsedError;
}
