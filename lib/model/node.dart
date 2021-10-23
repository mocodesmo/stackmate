import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'node.freezed.dart';
part 'node.g.dart';

@HiveType(typeId: 22, adapterName: 'NodeTypeClassAdaper')
enum NodeType {
  @HiveField(0)
  electrum,

  @HiveField(1)
  bitcoincore,
}

@freezed
class Node with _$Node {
  @HiveType(typeId: 14, adapterName: 'NodeClassAdaper')
  const factory Node({
    @HiveField(0) required NodeType nodeType,
    @HiveField(1) required String address,
    @HiveField(2) required String port,
    @HiveField(3) required String username,
    @HiveField(4) required String password,
  }) = _Node;
  const Node._();

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);

  String nodeAddress() => nodeType == NodeType.electrum
      ? 'default'
      : '$address:$port?auth=$username:$password';
}
