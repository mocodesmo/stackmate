// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'pin-keyboard.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PinKeyboardStateTearOff {
  const _$PinKeyboardStateTearOff();

  _PinKeyboardState call(
      {List<String> numberList = const [
        '2',
        '7',
        '0',
        '1',
        '8',
        '4',
        '3',
        '6',
        '9',
        '5'
      ],
      List<String> numbersEntered = const []}) {
    return _PinKeyboardState(
      numberList: numberList,
      numbersEntered: numbersEntered,
    );
  }
}

/// @nodoc
const $PinKeyboardState = _$PinKeyboardStateTearOff();

/// @nodoc
mixin _$PinKeyboardState {
  List<String> get numberList => throw _privateConstructorUsedError;
  List<String> get numbersEntered => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PinKeyboardStateCopyWith<PinKeyboardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PinKeyboardStateCopyWith<$Res> {
  factory $PinKeyboardStateCopyWith(
          PinKeyboardState value, $Res Function(PinKeyboardState) then) =
      _$PinKeyboardStateCopyWithImpl<$Res>;
  $Res call({List<String> numberList, List<String> numbersEntered});
}

/// @nodoc
class _$PinKeyboardStateCopyWithImpl<$Res>
    implements $PinKeyboardStateCopyWith<$Res> {
  _$PinKeyboardStateCopyWithImpl(this._value, this._then);

  final PinKeyboardState _value;
  // ignore: unused_field
  final $Res Function(PinKeyboardState) _then;

  @override
  $Res call({
    Object? numberList = freezed,
    Object? numbersEntered = freezed,
  }) {
    return _then(_value.copyWith(
      numberList: numberList == freezed
          ? _value.numberList
          : numberList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      numbersEntered: numbersEntered == freezed
          ? _value.numbersEntered
          : numbersEntered // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$PinKeyboardStateCopyWith<$Res>
    implements $PinKeyboardStateCopyWith<$Res> {
  factory _$PinKeyboardStateCopyWith(
          _PinKeyboardState value, $Res Function(_PinKeyboardState) then) =
      __$PinKeyboardStateCopyWithImpl<$Res>;
  @override
  $Res call({List<String> numberList, List<String> numbersEntered});
}

/// @nodoc
class __$PinKeyboardStateCopyWithImpl<$Res>
    extends _$PinKeyboardStateCopyWithImpl<$Res>
    implements _$PinKeyboardStateCopyWith<$Res> {
  __$PinKeyboardStateCopyWithImpl(
      _PinKeyboardState _value, $Res Function(_PinKeyboardState) _then)
      : super(_value, (v) => _then(v as _PinKeyboardState));

  @override
  _PinKeyboardState get _value => super._value as _PinKeyboardState;

  @override
  $Res call({
    Object? numberList = freezed,
    Object? numbersEntered = freezed,
  }) {
    return _then(_PinKeyboardState(
      numberList: numberList == freezed
          ? _value.numberList
          : numberList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      numbersEntered: numbersEntered == freezed
          ? _value.numbersEntered
          : numbersEntered // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_PinKeyboardState extends _PinKeyboardState {
  const _$_PinKeyboardState(
      {this.numberList = const [
        '2',
        '7',
        '0',
        '1',
        '8',
        '4',
        '3',
        '6',
        '9',
        '5'
      ],
      this.numbersEntered = const []})
      : super._();

  @JsonKey(
      defaultValue: const ['2', '7', '0', '1', '8', '4', '3', '6', '9', '5'])
  @override
  final List<String> numberList;
  @JsonKey(defaultValue: const [])
  @override
  final List<String> numbersEntered;

  @override
  String toString() {
    return 'PinKeyboardState(numberList: $numberList, numbersEntered: $numbersEntered)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PinKeyboardState &&
            (identical(other.numberList, numberList) ||
                const DeepCollectionEquality()
                    .equals(other.numberList, numberList)) &&
            (identical(other.numbersEntered, numbersEntered) ||
                const DeepCollectionEquality()
                    .equals(other.numbersEntered, numbersEntered)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(numberList) ^
      const DeepCollectionEquality().hash(numbersEntered);

  @JsonKey(ignore: true)
  @override
  _$PinKeyboardStateCopyWith<_PinKeyboardState> get copyWith =>
      __$PinKeyboardStateCopyWithImpl<_PinKeyboardState>(this, _$identity);
}

abstract class _PinKeyboardState extends PinKeyboardState {
  const factory _PinKeyboardState(
      {List<String> numberList,
      List<String> numbersEntered}) = _$_PinKeyboardState;
  const _PinKeyboardState._() : super._();

  @override
  List<String> get numberList => throw _privateConstructorUsedError;
  @override
  List<String> get numbersEntered => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PinKeyboardStateCopyWith<_PinKeyboardState> get copyWith =>
      throw _privateConstructorUsedError;
}
