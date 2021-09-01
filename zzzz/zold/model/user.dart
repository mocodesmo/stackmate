import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: 'email') @Default('') String email,
    //Security? security,
    @JsonKey(name: 'locked') @Default(false) bool locked,
    @JsonKey(name: 'pin') @Default(false) bool pinStatus,
    @JsonKey(name: 'tfa') @Default(false) bool tfaStatus,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
