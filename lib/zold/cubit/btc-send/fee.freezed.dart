// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'fee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$BtcSendFeesStateTearOff {
  const _$BtcSendFeesStateTearOff();

  _BtcSendFeesState call(
      {String feeEntered = '',
      int feeEnteredD = 0,
      String feeEnteredSmall = '0.00 BTC',
      String feeError = '',
      bool fetchingFee = false,
      NetworkInfo networkInfo = const NetworkInfo(),
      Traffic feeSelected = Traffic.medium,
      String fetchFeeError = ''}) {
    return _BtcSendFeesState(
      feeEntered: feeEntered,
      feeEnteredD: feeEnteredD,
      feeEnteredSmall: feeEnteredSmall,
      feeError: feeError,
      fetchingFee: fetchingFee,
      networkInfo: networkInfo,
      feeSelected: feeSelected,
      fetchFeeError: fetchFeeError,
    );
  }
}

/// @nodoc
const $BtcSendFeesState = _$BtcSendFeesStateTearOff();

/// @nodoc
mixin _$BtcSendFeesState {
  String get feeEntered => throw _privateConstructorUsedError;
  int get feeEnteredD => throw _privateConstructorUsedError;
  String get feeEnteredSmall => throw _privateConstructorUsedError;
  String get feeError => throw _privateConstructorUsedError;
  bool get fetchingFee => throw _privateConstructorUsedError;
  NetworkInfo get networkInfo => throw _privateConstructorUsedError;
  Traffic get feeSelected => throw _privateConstructorUsedError;
  String get fetchFeeError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BtcSendFeesStateCopyWith<BtcSendFeesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BtcSendFeesStateCopyWith<$Res> {
  factory $BtcSendFeesStateCopyWith(
          BtcSendFeesState value, $Res Function(BtcSendFeesState) then) =
      _$BtcSendFeesStateCopyWithImpl<$Res>;
  $Res call(
      {String feeEntered,
      int feeEnteredD,
      String feeEnteredSmall,
      String feeError,
      bool fetchingFee,
      NetworkInfo networkInfo,
      Traffic feeSelected,
      String fetchFeeError});

  $NetworkInfoCopyWith<$Res> get networkInfo;
}

/// @nodoc
class _$BtcSendFeesStateCopyWithImpl<$Res>
    implements $BtcSendFeesStateCopyWith<$Res> {
  _$BtcSendFeesStateCopyWithImpl(this._value, this._then);

  final BtcSendFeesState _value;
  // ignore: unused_field
  final $Res Function(BtcSendFeesState) _then;

  @override
  $Res call({
    Object? feeEntered = freezed,
    Object? feeEnteredD = freezed,
    Object? feeEnteredSmall = freezed,
    Object? feeError = freezed,
    Object? fetchingFee = freezed,
    Object? networkInfo = freezed,
    Object? feeSelected = freezed,
    Object? fetchFeeError = freezed,
  }) {
    return _then(_value.copyWith(
      feeEntered: feeEntered == freezed
          ? _value.feeEntered
          : feeEntered // ignore: cast_nullable_to_non_nullable
              as String,
      feeEnteredD: feeEnteredD == freezed
          ? _value.feeEnteredD
          : feeEnteredD // ignore: cast_nullable_to_non_nullable
              as int,
      feeEnteredSmall: feeEnteredSmall == freezed
          ? _value.feeEnteredSmall
          : feeEnteredSmall // ignore: cast_nullable_to_non_nullable
              as String,
      feeError: feeError == freezed
          ? _value.feeError
          : feeError // ignore: cast_nullable_to_non_nullable
              as String,
      fetchingFee: fetchingFee == freezed
          ? _value.fetchingFee
          : fetchingFee // ignore: cast_nullable_to_non_nullable
              as bool,
      networkInfo: networkInfo == freezed
          ? _value.networkInfo
          : networkInfo // ignore: cast_nullable_to_non_nullable
              as NetworkInfo,
      feeSelected: feeSelected == freezed
          ? _value.feeSelected
          : feeSelected // ignore: cast_nullable_to_non_nullable
              as Traffic,
      fetchFeeError: fetchFeeError == freezed
          ? _value.fetchFeeError
          : fetchFeeError // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $NetworkInfoCopyWith<$Res> get networkInfo {
    return $NetworkInfoCopyWith<$Res>(_value.networkInfo, (value) {
      return _then(_value.copyWith(networkInfo: value));
    });
  }
}

/// @nodoc
abstract class _$BtcSendFeesStateCopyWith<$Res>
    implements $BtcSendFeesStateCopyWith<$Res> {
  factory _$BtcSendFeesStateCopyWith(
          _BtcSendFeesState value, $Res Function(_BtcSendFeesState) then) =
      __$BtcSendFeesStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String feeEntered,
      int feeEnteredD,
      String feeEnteredSmall,
      String feeError,
      bool fetchingFee,
      NetworkInfo networkInfo,
      Traffic feeSelected,
      String fetchFeeError});

  @override
  $NetworkInfoCopyWith<$Res> get networkInfo;
}

/// @nodoc
class __$BtcSendFeesStateCopyWithImpl<$Res>
    extends _$BtcSendFeesStateCopyWithImpl<$Res>
    implements _$BtcSendFeesStateCopyWith<$Res> {
  __$BtcSendFeesStateCopyWithImpl(
      _BtcSendFeesState _value, $Res Function(_BtcSendFeesState) _then)
      : super(_value, (v) => _then(v as _BtcSendFeesState));

  @override
  _BtcSendFeesState get _value => super._value as _BtcSendFeesState;

  @override
  $Res call({
    Object? feeEntered = freezed,
    Object? feeEnteredD = freezed,
    Object? feeEnteredSmall = freezed,
    Object? feeError = freezed,
    Object? fetchingFee = freezed,
    Object? networkInfo = freezed,
    Object? feeSelected = freezed,
    Object? fetchFeeError = freezed,
  }) {
    return _then(_BtcSendFeesState(
      feeEntered: feeEntered == freezed
          ? _value.feeEntered
          : feeEntered // ignore: cast_nullable_to_non_nullable
              as String,
      feeEnteredD: feeEnteredD == freezed
          ? _value.feeEnteredD
          : feeEnteredD // ignore: cast_nullable_to_non_nullable
              as int,
      feeEnteredSmall: feeEnteredSmall == freezed
          ? _value.feeEnteredSmall
          : feeEnteredSmall // ignore: cast_nullable_to_non_nullable
              as String,
      feeError: feeError == freezed
          ? _value.feeError
          : feeError // ignore: cast_nullable_to_non_nullable
              as String,
      fetchingFee: fetchingFee == freezed
          ? _value.fetchingFee
          : fetchingFee // ignore: cast_nullable_to_non_nullable
              as bool,
      networkInfo: networkInfo == freezed
          ? _value.networkInfo
          : networkInfo // ignore: cast_nullable_to_non_nullable
              as NetworkInfo,
      feeSelected: feeSelected == freezed
          ? _value.feeSelected
          : feeSelected // ignore: cast_nullable_to_non_nullable
              as Traffic,
      fetchFeeError: fetchFeeError == freezed
          ? _value.fetchFeeError
          : fetchFeeError // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_BtcSendFeesState extends _BtcSendFeesState
    with DiagnosticableTreeMixin {
  const _$_BtcSendFeesState(
      {this.feeEntered = '',
      this.feeEnteredD = 0,
      this.feeEnteredSmall = '0.00 BTC',
      this.feeError = '',
      this.fetchingFee = false,
      this.networkInfo = const NetworkInfo(),
      this.feeSelected = Traffic.medium,
      this.fetchFeeError = ''})
      : super._();

  @JsonKey(defaultValue: '')
  @override
  final String feeEntered;
  @JsonKey(defaultValue: 0)
  @override
  final int feeEnteredD;
  @JsonKey(defaultValue: '0.00 BTC')
  @override
  final String feeEnteredSmall;
  @JsonKey(defaultValue: '')
  @override
  final String feeError;
  @JsonKey(defaultValue: false)
  @override
  final bool fetchingFee;
  @JsonKey(defaultValue: const NetworkInfo())
  @override
  final NetworkInfo networkInfo;
  @JsonKey(defaultValue: Traffic.medium)
  @override
  final Traffic feeSelected;
  @JsonKey(defaultValue: '')
  @override
  final String fetchFeeError;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BtcSendFeesState(feeEntered: $feeEntered, feeEnteredD: $feeEnteredD, feeEnteredSmall: $feeEnteredSmall, feeError: $feeError, fetchingFee: $fetchingFee, networkInfo: $networkInfo, feeSelected: $feeSelected, fetchFeeError: $fetchFeeError)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BtcSendFeesState'))
      ..add(DiagnosticsProperty('feeEntered', feeEntered))
      ..add(DiagnosticsProperty('feeEnteredD', feeEnteredD))
      ..add(DiagnosticsProperty('feeEnteredSmall', feeEnteredSmall))
      ..add(DiagnosticsProperty('feeError', feeError))
      ..add(DiagnosticsProperty('fetchingFee', fetchingFee))
      ..add(DiagnosticsProperty('networkInfo', networkInfo))
      ..add(DiagnosticsProperty('feeSelected', feeSelected))
      ..add(DiagnosticsProperty('fetchFeeError', fetchFeeError));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BtcSendFeesState &&
            (identical(other.feeEntered, feeEntered) ||
                const DeepCollectionEquality()
                    .equals(other.feeEntered, feeEntered)) &&
            (identical(other.feeEnteredD, feeEnteredD) ||
                const DeepCollectionEquality()
                    .equals(other.feeEnteredD, feeEnteredD)) &&
            (identical(other.feeEnteredSmall, feeEnteredSmall) ||
                const DeepCollectionEquality()
                    .equals(other.feeEnteredSmall, feeEnteredSmall)) &&
            (identical(other.feeError, feeError) ||
                const DeepCollectionEquality()
                    .equals(other.feeError, feeError)) &&
            (identical(other.fetchingFee, fetchingFee) ||
                const DeepCollectionEquality()
                    .equals(other.fetchingFee, fetchingFee)) &&
            (identical(other.networkInfo, networkInfo) ||
                const DeepCollectionEquality()
                    .equals(other.networkInfo, networkInfo)) &&
            (identical(other.feeSelected, feeSelected) ||
                const DeepCollectionEquality()
                    .equals(other.feeSelected, feeSelected)) &&
            (identical(other.fetchFeeError, fetchFeeError) ||
                const DeepCollectionEquality()
                    .equals(other.fetchFeeError, fetchFeeError)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(feeEntered) ^
      const DeepCollectionEquality().hash(feeEnteredD) ^
      const DeepCollectionEquality().hash(feeEnteredSmall) ^
      const DeepCollectionEquality().hash(feeError) ^
      const DeepCollectionEquality().hash(fetchingFee) ^
      const DeepCollectionEquality().hash(networkInfo) ^
      const DeepCollectionEquality().hash(feeSelected) ^
      const DeepCollectionEquality().hash(fetchFeeError);

  @JsonKey(ignore: true)
  @override
  _$BtcSendFeesStateCopyWith<_BtcSendFeesState> get copyWith =>
      __$BtcSendFeesStateCopyWithImpl<_BtcSendFeesState>(this, _$identity);
}

abstract class _BtcSendFeesState extends BtcSendFeesState {
  const factory _BtcSendFeesState(
      {String feeEntered,
      int feeEnteredD,
      String feeEnteredSmall,
      String feeError,
      bool fetchingFee,
      NetworkInfo networkInfo,
      Traffic feeSelected,
      String fetchFeeError}) = _$_BtcSendFeesState;
  const _BtcSendFeesState._() : super._();

  @override
  String get feeEntered => throw _privateConstructorUsedError;
  @override
  int get feeEnteredD => throw _privateConstructorUsedError;
  @override
  String get feeEnteredSmall => throw _privateConstructorUsedError;
  @override
  String get feeError => throw _privateConstructorUsedError;
  @override
  bool get fetchingFee => throw _privateConstructorUsedError;
  @override
  NetworkInfo get networkInfo => throw _privateConstructorUsedError;
  @override
  Traffic get feeSelected => throw _privateConstructorUsedError;
  @override
  String get fetchFeeError => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BtcSendFeesStateCopyWith<_BtcSendFeesState> get copyWith =>
      throw _privateConstructorUsedError;
}
