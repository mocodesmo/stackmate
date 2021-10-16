import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'node.g.dart';
part 'node.freezed.dart';

@HiveType(typeId: 22, adapterName: 'NodeTypeClassAdaper')
enum NodeType {
  @HiveField(0)
  electrum,

  @HiveField(1)
  bitcoincore,
}

@freezed
class Node with _$Node {
  @HiveType(typeId: 5, adapterName: 'NodeClassAdaper')
  const factory Node({
    @HiveField(0) required NodeType nodeType,
    @HiveField(1) required String address,
    @HiveField(2) required String port,
    @HiveField(3) required String username,
    @HiveField(4) required String password,
  }) = _Node;

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);
}
