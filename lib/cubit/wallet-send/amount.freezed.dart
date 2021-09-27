// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'amount.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$BtcSendAmountStateTearOff {
  const _$BtcSendAmountStateTearOff();

  _BtcSendAmountState call({String amountEntered = '', String errAmount = ''}) {
    return _BtcSendAmountState(
      amountEntered: amountEntered,
      errAmount: errAmount,
    );
  }
}

/// @nodoc
const $BtcSendAmountState = _$BtcSendAmountStateTearOff();

/// @nodoc
mixin _$BtcSendAmountState {
  String get amountEntered => throw _privateConstructorUsedError;
  String get errAmount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BtcSendAmountStateCopyWith<BtcSendAmountState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BtcSendAmountStateCopyWith<$Res> {
  factory $BtcSendAmountStateCopyWith(
          BtcSendAmountState value, $Res Function(BtcSendAmountState) then) =
      _$BtcSendAmountStateCopyWithImpl<$Res>;
  $Res call({String amountEntered, String errAmount});
}

/// @nodoc
class _$BtcSendAmountStateCopyWithImpl<$Res>
    implements $BtcSendAmountStateCopyWith<$Res> {
  _$BtcSendAmountStateCopyWithImpl(this._value, this._then);

  final BtcSendAmountState _value;
  // ignore: unused_field
  final $Res Function(BtcSendAmountState) _then;

  @override
  $Res call({
    Object? amountEntered = freezed,
    Object? errAmount = freezed,
  }) {
    return _then(_value.copyWith(
      amountEntered: amountEntered == freezed
          ? _value.amountEntered
          : amountEntered // ignore: cast_nullable_to_non_nullable
              as String,
      errAmount: errAmount == freezed
          ? _value.errAmount
          : errAmount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$BtcSendAmountStateCopyWith<$Res>
    implements $BtcSendAmountStateCopyWith<$Res> {
  factory _$BtcSendAmountStateCopyWith(
          _BtcSendAmountState value, $Res Function(_BtcSendAmountState) then) =
      __$BtcSendAmountStateCopyWithImpl<$Res>;
  @override
  $Res call({String amountEntered, String errAmount});
}

/// @nodoc
class __$BtcSendAmountStateCopyWithImpl<$Res>
    extends _$BtcSendAmountStateCopyWithImpl<$Res>
    implements _$BtcSendAmountStateCopyWith<$Res> {
  __$BtcSendAmountStateCopyWithImpl(
      _BtcSendAmountState _value, $Res Function(_BtcSendAmountState) _then)
      : super(_value, (v) => _then(v as _BtcSendAmountState));

  @override
  _BtcSendAmountState get _value => super._value as _BtcSendAmountState;

  @override
  $Res call({
    Object? amountEntered = freezed,
    Object? errAmount = freezed,
  }) {
    return _then(_BtcSendAmountState(
      amountEntered: amountEntered == freezed
          ? _value.amountEntered
          : amountEntered // ignore: cast_nullable_to_non_nullable
              as String,
      errAmount: errAmount == freezed
          ? _value.errAmount
          : errAmount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_BtcSendAmountState extends _BtcSendAmountState {
  const _$_BtcSendAmountState({this.amountEntered = '', this.errAmount = ''})
      : super._();

  @JsonKey(defaultValue: '')
  @override
  final String amountEntered;
  @JsonKey(defaultValue: '')
  @override
  final String errAmount;

  @override
  String toString() {
    return 'BtcSendAmountState(amountEntered: $amountEntered, errAmount: $errAmount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BtcSendAmountState &&
            (identical(other.amountEntered, amountEntered) ||
                const DeepCollectionEquality()
                    .equals(other.amountEntered, amountEntered)) &&
            (identical(other.errAmount, errAmount) ||
                const DeepCollectionEquality()
                    .equals(other.errAmount, errAmount)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(amountEntered) ^
      const DeepCollectionEquality().hash(errAmount);

  @JsonKey(ignore: true)
  @override
  _$BtcSendAmountStateCopyWith<_BtcSendAmountState> get copyWith =>
      __$BtcSendAmountStateCopyWithImpl<_BtcSendAmountState>(this, _$identity);
}

abstract class _BtcSendAmountState extends BtcSendAmountState {
  const factory _BtcSendAmountState({String amountEntered, String errAmount}) =
      _$_BtcSendAmountState;
  const _BtcSendAmountState._() : super._();

  @override
  String get amountEntered => throw _privateConstructorUsedError;
  @override
  String get errAmount => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BtcSendAmountStateCopyWith<_BtcSendAmountState> get copyWith =>
      throw _privateConstructorUsedError;
}
