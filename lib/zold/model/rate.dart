import 'package:freezed_annotation/freezed_annotation.dart';

part 'rate.g.dart';
part 'rate.freezed.dart';

@freezed
class Rate with _$Rate {
  const factory Rate({
    @JsonKey(name: 'symbol') @Default('') String symbol,
    @JsonKey(name: 'name') @Default('') String name,
    @JsonKey(name: 'rate') @Default(0) double rate,
  }) = _Rate;

  factory Rate.fromJson(Map<String, dynamic> json) => _$RateFromJson(json);
}
