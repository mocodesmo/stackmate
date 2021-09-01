import 'package:freezed_annotation/freezed_annotation.dart';

part 'network-info.g.dart';
part 'network-info.freezed.dart';

@freezed
class NetworkInfo with _$NetworkInfo {
  const NetworkInfo._();
  const factory NetworkInfo({
    @JsonKey(name: 'traffic') @Default('') String traffic,
    @JsonKey(name: 'fees') @Default(Fee()) Fee fees,
    @JsonKey(name: 'mempool_size') @Default(0) int mempool_size,
    @JsonKey(name: 'chain') @Default('') String chain,
    @JsonKey(name: 'blocks') @Default(0) int blocks,
  }) = _NetworkInfo;

  factory NetworkInfo.fromJson(Map<String, dynamic> json) =>
      _$NetworkInfoFromJson(json);
}

@freezed
class Fee with _$Fee {
  const Fee._();
  const factory Fee({
    @JsonKey(name: 'low') @Default(0) int slow,
    @JsonKey(name: 'medium') @Default(0) int medium,
    @JsonKey(name: 'high') @Default(0) int high,
  }) = _Fee;

  factory Fee.fromJson(Map<String, dynamic> json) => _$FeeFromJson(json);
}
