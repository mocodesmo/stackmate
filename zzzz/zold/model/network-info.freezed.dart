// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'network-info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NetworkInfo _$NetworkInfoFromJson(Map<String, dynamic> json) {
  return _NetworkInfo.fromJson(json);
}

/// @nodoc
class _$NetworkInfoTearOff {
  const _$NetworkInfoTearOff();

  _NetworkInfo call(
      {@JsonKey(name: 'traffic') String traffic = '',
      @JsonKey(name: 'fees') Fee fees = const Fee(),
      @JsonKey(name: 'mempool_size') int mempool_size = 0,
      @JsonKey(name: 'chain') String chain = '',
      @JsonKey(name: 'blocks') int blocks = 0}) {
    return _NetworkInfo(
      traffic: traffic,
      fees: fees,
      mempool_size: mempool_size,
      chain: chain,
      blocks: blocks,
    );
  }

  NetworkInfo fromJson(Map<String, Object> json) {
    return NetworkInfo.fromJson(json);
  }
}

/// @nodoc
const $NetworkInfo = _$NetworkInfoTearOff();

/// @nodoc
mixin _$NetworkInfo {
  @JsonKey(name: 'traffic')
  String get traffic => throw _privateConstructorUsedError;
  @JsonKey(name: 'fees')
  Fee get fees => throw _privateConstructorUsedError;
  @JsonKey(name: 'mempool_size')
  int get mempool_size => throw _privateConstructorUsedError;
  @JsonKey(name: 'chain')
  String get chain => throw _privateConstructorUsedError;
  @JsonKey(name: 'blocks')
  int get blocks => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NetworkInfoCopyWith<NetworkInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkInfoCopyWith<$Res> {
  factory $NetworkInfoCopyWith(
          NetworkInfo value, $Res Function(NetworkInfo) then) =
      _$NetworkInfoCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'traffic') String traffic,
      @JsonKey(name: 'fees') Fee fees,
      @JsonKey(name: 'mempool_size') int mempool_size,
      @JsonKey(name: 'chain') String chain,
      @JsonKey(name: 'blocks') int blocks});

  $FeeCopyWith<$Res> get fees;
}

/// @nodoc
class _$NetworkInfoCopyWithImpl<$Res> implements $NetworkInfoCopyWith<$Res> {
  _$NetworkInfoCopyWithImpl(this._value, this._then);

  final NetworkInfo _value;
  // ignore: unused_field
  final $Res Function(NetworkInfo) _then;

  @override
  $Res call({
    Object? traffic = freezed,
    Object? fees = freezed,
    Object? mempool_size = freezed,
    Object? chain = freezed,
    Object? blocks = freezed,
  }) {
    return _then(_value.copyWith(
      traffic: traffic == freezed
          ? _value.traffic
          : traffic // ignore: cast_nullable_to_non_nullable
              as String,
      fees: fees == freezed
          ? _value.fees
          : fees // ignore: cast_nullable_to_non_nullable
              as Fee,
      mempool_size: mempool_size == freezed
          ? _value.mempool_size
          : mempool_size // ignore: cast_nullable_to_non_nullable
              as int,
      chain: chain == freezed
          ? _value.chain
          : chain // ignore: cast_nullable_to_non_nullable
              as String,
      blocks: blocks == freezed
          ? _value.blocks
          : blocks // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  $FeeCopyWith<$Res> get fees {
    return $FeeCopyWith<$Res>(_value.fees, (value) {
      return _then(_value.copyWith(fees: value));
    });
  }
}

/// @nodoc
abstract class _$NetworkInfoCopyWith<$Res>
    implements $NetworkInfoCopyWith<$Res> {
  factory _$NetworkInfoCopyWith(
          _NetworkInfo value, $Res Function(_NetworkInfo) then) =
      __$NetworkInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'traffic') String traffic,
      @JsonKey(name: 'fees') Fee fees,
      @JsonKey(name: 'mempool_size') int mempool_size,
      @JsonKey(name: 'chain') String chain,
      @JsonKey(name: 'blocks') int blocks});

  @override
  $FeeCopyWith<$Res> get fees;
}

/// @nodoc
class __$NetworkInfoCopyWithImpl<$Res> extends _$NetworkInfoCopyWithImpl<$Res>
    implements _$NetworkInfoCopyWith<$Res> {
  __$NetworkInfoCopyWithImpl(
      _NetworkInfo _value, $Res Function(_NetworkInfo) _then)
      : super(_value, (v) => _then(v as _NetworkInfo));

  @override
  _NetworkInfo get _value => super._value as _NetworkInfo;

  @override
  $Res call({
    Object? traffic = freezed,
    Object? fees = freezed,
    Object? mempool_size = freezed,
    Object? chain = freezed,
    Object? blocks = freezed,
  }) {
    return _then(_NetworkInfo(
      traffic: traffic == freezed
          ? _value.traffic
          : traffic // ignore: cast_nullable_to_non_nullable
              as String,
      fees: fees == freezed
          ? _value.fees
          : fees // ignore: cast_nullable_to_non_nullable
              as Fee,
      mempool_size: mempool_size == freezed
          ? _value.mempool_size
          : mempool_size // ignore: cast_nullable_to_non_nullable
              as int,
      chain: chain == freezed
          ? _value.chain
          : chain // ignore: cast_nullable_to_non_nullable
              as String,
      blocks: blocks == freezed
          ? _value.blocks
          : blocks // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NetworkInfo extends _NetworkInfo {
  const _$_NetworkInfo(
      {@JsonKey(name: 'traffic') this.traffic = '',
      @JsonKey(name: 'fees') this.fees = const Fee(),
      @JsonKey(name: 'mempool_size') this.mempool_size = 0,
      @JsonKey(name: 'chain') this.chain = '',
      @JsonKey(name: 'blocks') this.blocks = 0})
      : super._();

  factory _$_NetworkInfo.fromJson(Map<String, dynamic> json) =>
      _$$_NetworkInfoFromJson(json);

  @override
  @JsonKey(name: 'traffic')
  final String traffic;
  @override
  @JsonKey(name: 'fees')
  final Fee fees;
  @override
  @JsonKey(name: 'mempool_size')
  final int mempool_size;
  @override
  @JsonKey(name: 'chain')
  final String chain;
  @override
  @JsonKey(name: 'blocks')
  final int blocks;

  @override
  String toString() {
    return 'NetworkInfo(traffic: $traffic, fees: $fees, mempool_size: $mempool_size, chain: $chain, blocks: $blocks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NetworkInfo &&
            (identical(other.traffic, traffic) ||
                const DeepCollectionEquality()
                    .equals(other.traffic, traffic)) &&
            (identical(other.fees, fees) ||
                const DeepCollectionEquality().equals(other.fees, fees)) &&
            (identical(other.mempool_size, mempool_size) ||
                const DeepCollectionEquality()
                    .equals(other.mempool_size, mempool_size)) &&
            (identical(other.chain, chain) ||
                const DeepCollectionEquality().equals(other.chain, chain)) &&
            (identical(other.blocks, blocks) ||
                const DeepCollectionEquality().equals(other.blocks, blocks)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(traffic) ^
      const DeepCollectionEquality().hash(fees) ^
      const DeepCollectionEquality().hash(mempool_size) ^
      const DeepCollectionEquality().hash(chain) ^
      const DeepCollectionEquality().hash(blocks);

  @JsonKey(ignore: true)
  @override
  _$NetworkInfoCopyWith<_NetworkInfo> get copyWith =>
      __$NetworkInfoCopyWithImpl<_NetworkInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NetworkInfoToJson(this);
  }
}

abstract class _NetworkInfo extends NetworkInfo {
  const factory _NetworkInfo(
      {@JsonKey(name: 'traffic') String traffic,
      @JsonKey(name: 'fees') Fee fees,
      @JsonKey(name: 'mempool_size') int mempool_size,
      @JsonKey(name: 'chain') String chain,
      @JsonKey(name: 'blocks') int blocks}) = _$_NetworkInfo;
  const _NetworkInfo._() : super._();

  factory _NetworkInfo.fromJson(Map<String, dynamic> json) =
      _$_NetworkInfo.fromJson;

  @override
  @JsonKey(name: 'traffic')
  String get traffic => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'fees')
  Fee get fees => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'mempool_size')
  int get mempool_size => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'chain')
  String get chain => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'blocks')
  int get blocks => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$NetworkInfoCopyWith<_NetworkInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

Fee _$FeeFromJson(Map<String, dynamic> json) {
  return _Fee.fromJson(json);
}

/// @nodoc
class _$FeeTearOff {
  const _$FeeTearOff();

  _Fee call(
      {@JsonKey(name: 'low') int slow = 0,
      @JsonKey(name: 'medium') int medium = 0,
      @JsonKey(name: 'high') int high = 0}) {
    return _Fee(
      slow: slow,
      medium: medium,
      high: high,
    );
  }

  Fee fromJson(Map<String, Object> json) {
    return Fee.fromJson(json);
  }
}

/// @nodoc
const $Fee = _$FeeTearOff();

/// @nodoc
mixin _$Fee {
  @JsonKey(name: 'low')
  int get slow => throw _privateConstructorUsedError;
  @JsonKey(name: 'medium')
  int get medium => throw _privateConstructorUsedError;
  @JsonKey(name: 'high')
  int get high => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeeCopyWith<Fee> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeeCopyWith<$Res> {
  factory $FeeCopyWith(Fee value, $Res Function(Fee) then) =
      _$FeeCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'low') int slow,
      @JsonKey(name: 'medium') int medium,
      @JsonKey(name: 'high') int high});
}

/// @nodoc
class _$FeeCopyWithImpl<$Res> implements $FeeCopyWith<$Res> {
  _$FeeCopyWithImpl(this._value, this._then);

  final Fee _value;
  // ignore: unused_field
  final $Res Function(Fee) _then;

  @override
  $Res call({
    Object? slow = freezed,
    Object? medium = freezed,
    Object? high = freezed,
  }) {
    return _then(_value.copyWith(
      slow: slow == freezed
          ? _value.slow
          : slow // ignore: cast_nullable_to_non_nullable
              as int,
      medium: medium == freezed
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as int,
      high: high == freezed
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$FeeCopyWith<$Res> implements $FeeCopyWith<$Res> {
  factory _$FeeCopyWith(_Fee value, $Res Function(_Fee) then) =
      __$FeeCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'low') int slow,
      @JsonKey(name: 'medium') int medium,
      @JsonKey(name: 'high') int high});
}

/// @nodoc
class __$FeeCopyWithImpl<$Res> extends _$FeeCopyWithImpl<$Res>
    implements _$FeeCopyWith<$Res> {
  __$FeeCopyWithImpl(_Fee _value, $Res Function(_Fee) _then)
      : super(_value, (v) => _then(v as _Fee));

  @override
  _Fee get _value => super._value as _Fee;

  @override
  $Res call({
    Object? slow = freezed,
    Object? medium = freezed,
    Object? high = freezed,
  }) {
    return _then(_Fee(
      slow: slow == freezed
          ? _value.slow
          : slow // ignore: cast_nullable_to_non_nullable
              as int,
      medium: medium == freezed
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as int,
      high: high == freezed
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Fee extends _Fee {
  const _$_Fee(
      {@JsonKey(name: 'low') this.slow = 0,
      @JsonKey(name: 'medium') this.medium = 0,
      @JsonKey(name: 'high') this.high = 0})
      : super._();

  factory _$_Fee.fromJson(Map<String, dynamic> json) => _$$_FeeFromJson(json);

  @override
  @JsonKey(name: 'low')
  final int slow;
  @override
  @JsonKey(name: 'medium')
  final int medium;
  @override
  @JsonKey(name: 'high')
  final int high;

  @override
  String toString() {
    return 'Fee(slow: $slow, medium: $medium, high: $high)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Fee &&
            (identical(other.slow, slow) ||
                const DeepCollectionEquality().equals(other.slow, slow)) &&
            (identical(other.medium, medium) ||
                const DeepCollectionEquality().equals(other.medium, medium)) &&
            (identical(other.high, high) ||
                const DeepCollectionEquality().equals(other.high, high)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(slow) ^
      const DeepCollectionEquality().hash(medium) ^
      const DeepCollectionEquality().hash(high);

  @JsonKey(ignore: true)
  @override
  _$FeeCopyWith<_Fee> get copyWith =>
      __$FeeCopyWithImpl<_Fee>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FeeToJson(this);
  }
}

abstract class _Fee extends Fee {
  const factory _Fee(
      {@JsonKey(name: 'low') int slow,
      @JsonKey(name: 'medium') int medium,
      @JsonKey(name: 'high') int high}) = _$_Fee;
  const _Fee._() : super._();

  factory _Fee.fromJson(Map<String, dynamic> json) = _$_Fee.fromJson;

  @override
  @JsonKey(name: 'low')
  int get slow => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'medium')
  int get medium => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'high')
  int get high => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FeeCopyWith<_Fee> get copyWith => throw _privateConstructorUsedError;
}
