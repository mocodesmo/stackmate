import 'package:freezed_annotation/freezed_annotation.dart';

part 'reddit-post.g.dart';
part 'reddit-post.freezed.dart';

@freezed
class RedditPost with _$RedditPost {
  const RedditPost._();
  const factory RedditPost({
    @JsonKey(name: 'title') @Default('') String title,
    @JsonKey(name: 'permalink') @Default('') String permalink,
    @JsonKey(name: 'score') @Default(0) int score,
    @JsonKey(name: 'thumbnail') @Default('') String thumbnail,
    @JsonKey(name: 'url') @Default('') String url,
    @JsonKey(name: 'created_utc') @Default(0) double createdAt,
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
