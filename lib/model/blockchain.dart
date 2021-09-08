import 'package:hive/hive.dart';

part 'blockchain.g.dart';

@HiveType(typeId: 10, adapterName: 'BlockchainClassAdaper')
enum Blockchain {
  @HiveField(0)
  mainNet,

  @HiveField(1)
  testNet,
}

extension x on Blockchain {
  String get name => const {
        Blockchain.mainNet: 'main',
        Blockchain.testNet: 'test',
      }[this]!;
}
