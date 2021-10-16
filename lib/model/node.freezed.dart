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

Node _$NodeFromJson(Map<String, dynamic> json) {
  return _Node.fromJson(json);
}

/// @nodoc
class _$NodeTearOff {
  const _$NodeTearOff();

  _Node call(
      {@HiveField(0) required NodeType nodeType,
      @HiveField(1) required String address,
      @HiveField(2) required String port,
      @HiveField(3) required String username,
      @HiveField(4) required String password}) {
    return _Node(
      nodeType: nodeType,
      address: address,
      port: port,
      username: username,
      password: password,
    );
  }

  Node fromJson(Map<String, Object> json) {
    return Node.fromJson(json);
  }
}

/// @nodoc
const $Node = _$NodeTearOff();

/// @nodoc
mixin _$Node {
  @HiveField(0)
  NodeType get nodeType => throw _privateConstructorUsedError;
  @HiveField(1)
  String get address => throw _privateConstructorUsedError;
  @HiveField(2)
  String get port => throw _privateConstructorUsedError;
  @HiveField(3)
  String get username => throw _privateConstructorUsedError;
  @HiveField(4)
  String get password => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NodeCopyWith<Node> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NodeCopyWith<$Res> {
  factory $NodeCopyWith(Node value, $Res Function(Node) then) =
      _$NodeCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) NodeType nodeType,
      @HiveField(1) String address,
      @HiveField(2) String port,
      @HiveField(3) String username,
      @HiveField(4) String password});
}

/// @nodoc
class _$NodeCopyWithImpl<$Res> implements $NodeCopyWith<$Res> {
  _$NodeCopyWithImpl(this._value, this._then);

  final Node _value;
  // ignore: unused_field
  final $Res Function(Node) _then;

  @override
  $Res call({
    Object? nodeType = freezed,
    Object? address = freezed,
    Object? port = freezed,
    Object? username = freezed,
    Object? password = freezed,
  }) {
    return _then(_value.copyWith(
      nodeType: nodeType == freezed
          ? _value.nodeType
          : nodeType // ignore: cast_nullable_to_non_nullable
              as NodeType,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      port: port == freezed
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as String,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$NodeCopyWith<$Res> implements $NodeCopyWith<$Res> {
  factory _$NodeCopyWith(_Node value, $Res Function(_Node) then) =
      __$NodeCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) NodeType nodeType,
      @HiveField(1) String address,
      @HiveField(2) String port,
      @HiveField(3) String username,
      @HiveField(4) String password});
}

/// @nodoc
class __$NodeCopyWithImpl<$Res> extends _$NodeCopyWithImpl<$Res>
    implements _$NodeCopyWith<$Res> {
  __$NodeCopyWithImpl(_Node _value, $Res Function(_Node) _then)
      : super(_value, (v) => _then(v as _Node));

  @override
  _Node get _value => super._value as _Node;

  @override
  $Res call({
    Object? nodeType = freezed,
    Object? address = freezed,
    Object? port = freezed,
    Object? username = freezed,
    Object? password = freezed,
  }) {
    return _then(_Node(
      nodeType: nodeType == freezed
          ? _value.nodeType
          : nodeType // ignore: cast_nullable_to_non_nullable
              as NodeType,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      port: port == freezed
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as String,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 5, adapterName: 'NodeClassAdaper')
class _$_Node implements _Node {
  const _$_Node(
      {@HiveField(0) required this.nodeType,
      @HiveField(1) required this.address,
      @HiveField(2) required this.port,
      @HiveField(3) required this.username,
      @HiveField(4) required this.password});

  factory _$_Node.fromJson(Map<String, dynamic> json) => _$$_NodeFromJson(json);

  @override
  @HiveField(0)
  final NodeType nodeType;
  @override
  @HiveField(1)
  final String address;
  @override
  @HiveField(2)
  final String port;
  @override
  @HiveField(3)
  final String username;
  @override
  @HiveField(4)
  final String password;

  @override
  String toString() {
    return 'Node(nodeType: $nodeType, address: $address, port: $port, username: $username, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Node &&
            (identical(other.nodeType, nodeType) ||
                const DeepCollectionEquality()
                    .equals(other.nodeType, nodeType)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.port, port) ||
                const DeepCollectionEquality().equals(other.port, port)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(nodeType) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(port) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(password);

  @JsonKey(ignore: true)
  @override
  _$NodeCopyWith<_Node> get copyWith =>
      __$NodeCopyWithImpl<_Node>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NodeToJson(this);
  }
}

abstract class _Node implements Node {
  const factory _Node(
      {@HiveField(0) required NodeType nodeType,
      @HiveField(1) required String address,
      @HiveField(2) required String port,
      @HiveField(3) required String username,
      @HiveField(4) required String password}) = _$_Node;

  factory _Node.fromJson(Map<String, dynamic> json) = _$_Node.fromJson;

  @override
  @HiveField(0)
  NodeType get nodeType => throw _privateConstructorUsedError;
  @override
  @HiveField(1)
  String get address => throw _privateConstructorUsedError;
  @override
  @HiveField(2)
  String get port => throw _privateConstructorUsedError;
  @override
  @HiveField(3)
  String get username => throw _privateConstructorUsedError;
  @override
  @HiveField(4)
  String get password => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$NodeCopyWith<_Node> get copyWith => throw _privateConstructorUsedError;
}
