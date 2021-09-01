// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'address.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$BtcSendAddressStateTearOff {
  const _$BtcSendAddressStateTearOff();

  _BtcSendAddressState call(
      {bool cameraOpened = false,
      String address = '',
      String addressError = '',
      String comment = '',
      String commentError = ''}) {
    return _BtcSendAddressState(
      cameraOpened: cameraOpened,
      address: address,
      addressError: addressError,
      comment: comment,
      commentError: commentError,
    );
  }
}

/// @nodoc
const $BtcSendAddressState = _$BtcSendAddressStateTearOff();

/// @nodoc
mixin _$BtcSendAddressState {
  bool get cameraOpened => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get addressError => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  String get commentError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BtcSendAddressStateCopyWith<BtcSendAddressState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BtcSendAddressStateCopyWith<$Res> {
  factory $BtcSendAddressStateCopyWith(
          BtcSendAddressState value, $Res Function(BtcSendAddressState) then) =
      _$BtcSendAddressStateCopyWithImpl<$Res>;
  $Res call(
      {bool cameraOpened,
      String address,
      String addressError,
      String comment,
      String commentError});
}

/// @nodoc
class _$BtcSendAddressStateCopyWithImpl<$Res>
    implements $BtcSendAddressStateCopyWith<$Res> {
  _$BtcSendAddressStateCopyWithImpl(this._value, this._then);

  final BtcSendAddressState _value;
  // ignore: unused_field
  final $Res Function(BtcSendAddressState) _then;

  @override
  $Res call({
    Object? cameraOpened = freezed,
    Object? address = freezed,
    Object? addressError = freezed,
    Object? comment = freezed,
    Object? commentError = freezed,
  }) {
    return _then(_value.copyWith(
      cameraOpened: cameraOpened == freezed
          ? _value.cameraOpened
          : cameraOpened // ignore: cast_nullable_to_non_nullable
              as bool,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      addressError: addressError == freezed
          ? _value.addressError
          : addressError // ignore: cast_nullable_to_non_nullable
              as String,
      comment: comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      commentError: commentError == freezed
          ? _value.commentError
          : commentError // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$BtcSendAddressStateCopyWith<$Res>
    implements $BtcSendAddressStateCopyWith<$Res> {
  factory _$BtcSendAddressStateCopyWith(_BtcSendAddressState value,
          $Res Function(_BtcSendAddressState) then) =
      __$BtcSendAddressStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool cameraOpened,
      String address,
      String addressError,
      String comment,
      String commentError});
}

/// @nodoc
class __$BtcSendAddressStateCopyWithImpl<$Res>
    extends _$BtcSendAddressStateCopyWithImpl<$Res>
    implements _$BtcSendAddressStateCopyWith<$Res> {
  __$BtcSendAddressStateCopyWithImpl(
      _BtcSendAddressState _value, $Res Function(_BtcSendAddressState) _then)
      : super(_value, (v) => _then(v as _BtcSendAddressState));

  @override
  _BtcSendAddressState get _value => super._value as _BtcSendAddressState;

  @override
  $Res call({
    Object? cameraOpened = freezed,
    Object? address = freezed,
    Object? addressError = freezed,
    Object? comment = freezed,
    Object? commentError = freezed,
  }) {
    return _then(_BtcSendAddressState(
      cameraOpened: cameraOpened == freezed
          ? _value.cameraOpened
          : cameraOpened // ignore: cast_nullable_to_non_nullable
              as bool,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      addressError: addressError == freezed
          ? _value.addressError
          : addressError // ignore: cast_nullable_to_non_nullable
              as String,
      comment: comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      commentError: commentError == freezed
          ? _value.commentError
          : commentError // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_BtcSendAddressState extends _BtcSendAddressState {
  const _$_BtcSendAddressState(
      {this.cameraOpened = false,
      this.address = '',
      this.addressError = '',
      this.comment = '',
      this.commentError = ''})
      : super._();

  @JsonKey(defaultValue: false)
  @override
  final bool cameraOpened;
  @JsonKey(defaultValue: '')
  @override
  final String address;
  @JsonKey(defaultValue: '')
  @override
  final String addressError;
  @JsonKey(defaultValue: '')
  @override
  final String comment;
  @JsonKey(defaultValue: '')
  @override
  final String commentError;

  @override
  String toString() {
    return 'BtcSendAddressState(cameraOpened: $cameraOpened, address: $address, addressError: $addressError, comment: $comment, commentError: $commentError)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BtcSendAddressState &&
            (identical(other.cameraOpened, cameraOpened) ||
                const DeepCollectionEquality()
                    .equals(other.cameraOpened, cameraOpened)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.addressError, addressError) ||
                const DeepCollectionEquality()
                    .equals(other.addressError, addressError)) &&
            (identical(other.comment, comment) ||
                const DeepCollectionEquality()
                    .equals(other.comment, comment)) &&
            (identical(other.commentError, commentError) ||
                const DeepCollectionEquality()
                    .equals(other.commentError, commentError)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(cameraOpened) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(addressError) ^
      const DeepCollectionEquality().hash(comment) ^
      const DeepCollectionEquality().hash(commentError);

  @JsonKey(ignore: true)
  @override
  _$BtcSendAddressStateCopyWith<_BtcSendAddressState> get copyWith =>
      __$BtcSendAddressStateCopyWithImpl<_BtcSendAddressState>(
          this, _$identity);
}

abstract class _BtcSendAddressState extends BtcSendAddressState {
  const factory _BtcSendAddressState(
      {bool cameraOpened,
      String address,
      String addressError,
      String comment,
      String commentError}) = _$_BtcSendAddressState;
  const _BtcSendAddressState._() : super._();

  @override
  bool get cameraOpened => throw _privateConstructorUsedError;
  @override
  String get address => throw _privateConstructorUsedError;
  @override
  String get addressError => throw _privateConstructorUsedError;
  @override
  String get comment => throw _privateConstructorUsedError;
  @override
  String get commentError => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BtcSendAddressStateCopyWith<_BtcSendAddressState> get copyWith =>
      throw _privateConstructorUsedError;
}
