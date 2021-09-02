import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'reddit-post.g.dart';
part 'reddit-post.freezed.dart';

@freezed
class RedditPost with _$RedditPost {
  const RedditPost._();

  @HiveType(typeId: 0, adapterName: 'RedditPostClassAdapter')
  const factory RedditPost({
    @JsonKey(name: 'title') @HiveField(0) @Default('') String title,
    @JsonKey(name: 'permalink') @HiveField(1) @Default('') String permalink,
    @JsonKey(name: 'score') @HiveField(2) @Default(0) int score,
    @JsonKey(name: 'thumbnail') @HiveField(3) @Default('') String thumbnail,
    @JsonKey(name: 'url') @HiveField(4) @Default('') String url,
    @JsonKey(name: 'created_utc') @HiveField(5) @Default(0) double createdAt,
  }) = _RedditPost;

  factory RedditPost.fromJson(Map<String, dynamic> json) =>
      _$RedditPostFromJson(json);

  String time() {
    String date = '';
    final inttime = createdAt.toInt();
    DateTime dt =
        DateTime.fromMillisecondsSinceEpoch(inttime * 1000, isUtc: true);
    date += dt.day.toString() +
        '-' +
        dt.month.toString() +
        '-' +
        dt.year.toString() +
        ' ';
    date += dt.hour.toString() + ':';
    date += dt.minute.toString().length == 1
        ? ('0' + dt.minute.toString())
        : dt.minute.toString();
    // date += dt.hour < 12 ? '  AM' : '  PM';
    // date += ' GMT';
    return date;
  }

  bool hasImage() {
    if (thumbnail.endsWith('.jpg') ||
        thumbnail.endsWith('.jpeg') ||
        thumbnail.endsWith('.png')) return true;
    return false;
  }

  String link() => 'https://www.reddit.com' + permalink;
}

cc() {
  var rd = RedditPost(title: '');
  // rd.;
}
