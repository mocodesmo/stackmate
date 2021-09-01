// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'address-generate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AddressGenerateStateTearOff {
  const _$AddressGenerateStateTearOff();

  _AddressGenerate call(
      {bool expandAddressSection = false,
      String addressLabel = '',
      bool savingAddress = false,
      String errAddressGenerate = '',
      bool addressSaved = false}) {
    return _AddressGenerate(
      expandAddressSection: expandAddressSection,
      addressLabel: addressLabel,
      savingAddress: savingAddress,
      errAddressGenerate: errAddressGenerate,
      addressSaved: addressSaved,
    );
  }
}

/// @nodoc
const $AddressGenerateState = _$AddressGenerateStateTearOff();

/// @nodoc
mixin _$AddressGenerateState {
  bool get expandAddressSection => throw _privateConstructorUsedError;
  String get addressLabel => throw _privateConstructorUsedError;
  bool get savingAddress => throw _privateConstructorUsedError;
  String get errAddressGenerate => throw _privateConstructorUsedError;
  bool get addressSaved => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddressGenerateStateCopyWith<AddressGenerateState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressGenerateStateCopyWith<$Res> {
  factory $AddressGenerateStateCopyWith(AddressGenerateState value,
          $Res Function(AddressGenerateState) then) =
      _$AddressGenerateStateCopyWithImpl<$Res>;
  $Res call(
      {bool expandAddressSection,
      String addressLabel,
      bool savingAddress,
      String errAddressGenerate,
      bool addressSaved});
}

/// @nodoc
class _$AddressGenerateStateCopyWithImpl<$Res>
    implements $AddressGenerateStateCopyWith<$Res> {
  _$AddressGenerateStateCopyWithImpl(this._value, this._then);

  final AddressGenerateState _value;
  // ignore: unused_field
  final $Res Function(AddressGenerateState) _then;

  @override
  $Res call({
    Object? expandAddressSection = freezed,
    Object? addressLabel = freezed,
    Object? savingAddress = freezed,
    Object? errAddressGenerate = freezed,
    Object? addressSaved = freezed,
  }) {
    return _then(_value.copyWith(
      expandAddressSection: expandAddressSection == freezed
          ? _value.expandAddressSection
          : expandAddressSection // ignore: cast_nullable_to_non_nullable
              as bool,
      addressLabel: addressLabel == freezed
          ? _value.addressLabel
          : addressLabel // ignore: cast_nullable_to_non_nullable
              as String,
      savingAddress: savingAddress == freezed
          ? _value.savingAddress
          : savingAddress // ignore: cast_nullable_to_non_nullable
              as bool,
      errAddressGenerate: errAddressGenerate == freezed
          ? _value.errAddressGenerate
          : errAddressGenerate // ignore: cast_nullable_to_non_nullable
              as String,
      addressSaved: addressSaved == freezed
          ? _value.addressSaved
          : addressSaved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$AddressGenerateCopyWith<$Res>
    implements $AddressGenerateStateCopyWith<$Res> {
  factory _$AddressGenerateCopyWith(
          _AddressGenerate value, $Res Function(_AddressGenerate) then) =
      __$AddressGenerateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool expandAddressSection,
      String addressLabel,
      bool savingAddress,
      String errAddressGenerate,
      bool addressSaved});
}

/// @nodoc
class __$AddressGenerateCopyWithImpl<$Res>
    extends _$AddressGenerateStateCopyWithImpl<$Res>
    implements _$AddressGenerateCopyWith<$Res> {
  __$AddressGenerateCopyWithImpl(
      _AddressGenerate _value, $Res Function(_AddressGenerate) _then)
      : super(_value, (v) => _then(v as _AddressGenerate));

  @override
  _AddressGenerate get _value => super._value as _AddressGenerate;

  @override
  $Res call({
    Object? expandAddressSection = freezed,
    Object? addressLabel = freezed,
    Object? savingAddress = freezed,
    Object? errAddressGenerate = freezed,
    Object? addressSaved = freezed,
  }) {
    return _then(_AddressGenerate(
      expandAddressSection: expandAddressSection == freezed
          ? _value.expandAddressSection
          : expandAddressSection // ignore: cast_nullable_to_non_nullable
              as bool,
      addressLabel: addressLabel == freezed
          ? _value.addressLabel
          : addressLabel // ignore: cast_nullable_to_non_nullable
              as String,
      savingAddress: savingAddress == freezed
          ? _value.savingAddress
          : savingAddress // ignore: cast_nullable_to_non_nullable
              as bool,
      errAddressGenerate: errAddressGenerate == freezed
          ? _value.errAddressGenerate
          : errAddressGenerate // ignore: cast_nullable_to_non_nullable
              as String,
      addressSaved: addressSaved == freezed
          ? _value.addressSaved
          : addressSaved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_AddressGenerate implements _AddressGenerate {
  const _$_AddressGenerate(
      {this.expandAddressSection = false,
      this.addressLabel = '',
      this.savingAddress = false,
      this.errAddressGenerate = '',
      this.addressSaved = false});

  @JsonKey(defaultValue: false)
  @override
  final bool expandAddressSection;
  @JsonKey(defaultValue: '')
  @override
  final String addressLabel;
  @JsonKey(defaultValue: false)
  @override
  final bool savingAddress;
  @JsonKey(defaultValue: '')
  @override
  final String errAddressGenerate;
  @JsonKey(defaultValue: false)
  @override
  final bool addressSaved;

  @override
  String toString() {
    return 'AddressGenerateState(expandAddressSection: $expandAddressSection, addressLabel: $addressLabel, savingAddress: $savingAddress, errAddressGenerate: $errAddressGenerate, addressSaved: $addressSaved)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AddressGenerate &&
            (identical(other.expandAddressSection, expandAddressSection) ||
                const DeepCollectionEquality().equals(
                    other.expandAddressSection, expandAddressSection)) &&
            (identical(other.addressLabel, addressLabel) ||
                const DeepCollectionEquality()
                    .equals(other.addressLabel, addressLabel)) &&
            (identical(other.savingAddress, savingAddress) ||
                const DeepCollectionEquality()
                    .equals(other.savingAddress, savingAddress)) &&
            (identical(other.errAddressGenerate, errAddressGenerate) ||
                const DeepCollectionEquality()
                    .equals(other.errAddressGenerate, errAddressGenerate)) &&
            (identical(other.addressSaved, addressSaved) ||
                const DeepCollectionEquality()
                    .equals(other.addressSaved, addressSaved)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(expandAddressSection) ^
      const DeepCollectionEquality().hash(addressLabel) ^
      const DeepCollectionEquality().hash(savingAddress) ^
      const DeepCollectionEquality().hash(errAddressGenerate) ^
      const DeepCollectionEquality().hash(addressSaved);

  @JsonKey(ignore: true)
  @override
  _$AddressGenerateCopyWith<_AddressGenerate> get copyWith =>
      __$AddressGenerateCopyWithImpl<_AddressGenerate>(this, _$identity);
}

abstract class _AddressGenerate implements AddressGenerateState {
  const factory _AddressGenerate(
      {bool expandAddressSection,
      String addressLabel,
      bool savingAddress,
      String errAddressGenerate,
      bool addressSaved}) = _$_AddressGenerate;

  @override
  bool get expandAddressSection => throw _privateConstructorUsedError;
  @override
  String get addressLabel => throw _privateConstructorUsedError;
  @override
  bool get savingAddress => throw _privateConstructorUsedError;
  @override
  String get errAddressGenerate => throw _privateConstructorUsedError;
  @override
  bool get addressSaved => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AddressGenerateCopyWith<_AddressGenerate> get copyWith =>
      throw _privateConstructorUsedError;
}
