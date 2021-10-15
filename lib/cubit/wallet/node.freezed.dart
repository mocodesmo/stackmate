// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$NodeAddressStateTearOff {
  const _$NodeAddressStateTearOff();

  _NodeAddressState call(
      {NodeType nodeType = NodeType.electrum,
      String? address,
      String errNodeState = ''}) {
    return _NodeAddressState(
      nodeType: nodeType,
      address: address,
      errNodeState: errNodeState,
    );
  }
}

/// @nodoc
const $NodeAddressState = _$NodeAddressStateTearOff();

/// @nodoc
mixin _$NodeAddressState {
  NodeType get nodeType => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String get errNodeState => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NodeAddressStateCopyWith<NodeAddressState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NodeAddressStateCopyWith<$Res> {
  factory $NodeAddressStateCopyWith(
          NodeAddressState value, $Res Function(NodeAddressState) then) =
      _$NodeAddressStateCopyWithImpl<$Res>;
  $Res call({NodeType nodeType, String? address, String errNodeState});
}

/// @nodoc
class _$NodeAddressStateCopyWithImpl<$Res>
    implements $NodeAddressStateCopyWith<$Res> {
  _$NodeAddressStateCopyWithImpl(this._value, this._then);

  final NodeAddressState _value;
  // ignore: unused_field
  final $Res Function(NodeAddressState) _then;

  @override
  $Res call({
    Object? nodeType = freezed,
    Object? address = freezed,
    Object? errNodeState = freezed,
  }) {
    return _then(_value.copyWith(
      nodeType: nodeType == freezed
          ? _value.nodeType
          : nodeType // ignore: cast_nullable_to_non_nullable
              as NodeType,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      errNodeState: errNodeState == freezed
          ? _value.errNodeState
          : errNodeState // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$NodeAddressStateCopyWith<$Res>
    implements $NodeAddressStateCopyWith<$Res> {
  factory _$NodeAddressStateCopyWith(
          _NodeAddressState value, $Res Function(_NodeAddressState) then) =
      __$NodeAddressStateCopyWithImpl<$Res>;
  @override
  $Res call({NodeType nodeType, String? address, String errNodeState});
}

/// @nodoc
class __$NodeAddressStateCopyWithImpl<$Res>
    extends _$NodeAddressStateCopyWithImpl<$Res>
    implements _$NodeAddressStateCopyWith<$Res> {
  __$NodeAddressStateCopyWithImpl(
      _NodeAddressState _value, $Res Function(_NodeAddressState) _then)
      : super(_value, (v) => _then(v as _NodeAddressState));

  @override
  _NodeAddressState get _value => super._value as _NodeAddressState;

  @override
  $Res call({
    Object? nodeType = freezed,
    Object? address = freezed,
    Object? errNodeState = freezed,
  }) {
    return _then(_NodeAddressState(
      nodeType: nodeType == freezed
          ? _value.nodeType
          : nodeType // ignore: cast_nullable_to_non_nullable
              as NodeType,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      errNodeState: errNodeState == freezed
          ? _value.errNodeState
          : errNodeState // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_NodeAddressState implements _NodeAddressState {
  const _$_NodeAddressState(
      {this.nodeType = NodeType.electrum,
      this.address,
      this.errNodeState = ''});

  @JsonKey(defaultValue: NodeType.electrum)
  @override
  final NodeType nodeType;
  @override
  final String? address;
  @JsonKey(defaultValue: '')
  @override
  final String errNodeState;

  @override
  String toString() {
    return 'NodeAddressState(nodeType: $nodeType, address: $address, errNodeState: $errNodeState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NodeAddressState &&
            (identical(other.nodeType, nodeType) ||
                const DeepCollectionEquality()
                    .equals(other.nodeType, nodeType)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.errNodeState, errNodeState) ||
                const DeepCollectionEquality()
                    .equals(other.errNodeState, errNodeState)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(nodeType) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(errNodeState);

  @JsonKey(ignore: true)
  @override
  _$NodeAddressStateCopyWith<_NodeAddressState> get copyWith =>
      __$NodeAddressStateCopyWithImpl<_NodeAddressState>(this, _$identity);
}

abstract class _NodeAddressState implements NodeAddressState {
  const factory _NodeAddressState(
      {NodeType nodeType,
      String? address,
      String errNodeState}) = _$_NodeAddressState;

  @override
  NodeType get nodeType => throw _privateConstructorUsedError;
  @override
  String? get address => throw _privateConstructorUsedError;
  @override
  String get errNodeState => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$NodeAddressStateCopyWith<_NodeAddressState> get copyWith =>
      throw _privateConstructorUsedError;
}