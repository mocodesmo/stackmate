// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'reddit-post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RedditPost _$RedditPostFromJson(Map<String, dynamic> json) {
  return _RedditPost.fromJson(json);
}

/// @nodoc
class _$RedditPostTearOff {
  const _$RedditPostTearOff();

  _RedditPost call(
      {@JsonKey(name: 'title') @HiveField(0) String title = '',
      @JsonKey(name: 'permalink') @HiveField(1) String permalink = '',
      @JsonKey(name: 'score') @HiveField(2) int score = 0,
      @JsonKey(name: 'thumbnail') @HiveField(3) String thumbnail = '',
      @JsonKey(name: 'url') @HiveField(4) String url = '',
      @JsonKey(name: 'created_utc') @HiveField(5) double createdAt = 0}) {
    return _RedditPost(
      title: title,
      permalink: permalink,
      score: score,
      thumbnail: thumbnail,
      url: url,
      createdAt: createdAt,
    );
  }

  RedditPost fromJson(Map<String, Object> json) {
    return RedditPost.fromJson(json);
  }
}

/// @nodoc
const $RedditPost = _$RedditPostTearOff();

/// @nodoc
mixin _$RedditPost {
  @JsonKey(name: 'title')
  @HiveField(0)
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'permalink')
  @HiveField(1)
  String get permalink => throw _privateConstructorUsedError;
  @JsonKey(name: 'score')
  @HiveField(2)
  int get score => throw _privateConstructorUsedError;
  @JsonKey(name: 'thumbnail')
  @HiveField(3)
  String get thumbnail => throw _privateConstructorUsedError;
  @JsonKey(name: 'url')
  @HiveField(4)
  String get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_utc')
  @HiveField(5)
  double get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RedditPostCopyWith<RedditPost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RedditPostCopyWith<$Res> {
  factory $RedditPostCopyWith(
          RedditPost value, $Res Function(RedditPost) then) =
      _$RedditPostCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'title') @HiveField(0) String title,
      @JsonKey(name: 'permalink') @HiveField(1) String permalink,
      @JsonKey(name: 'score') @HiveField(2) int score,
      @JsonKey(name: 'thumbnail') @HiveField(3) String thumbnail,
      @JsonKey(name: 'url') @HiveField(4) String url,
      @JsonKey(name: 'created_utc') @HiveField(5) double createdAt});
}

/// @nodoc
class _$RedditPostCopyWithImpl<$Res> implements $RedditPostCopyWith<$Res> {
  _$RedditPostCopyWithImpl(this._value, this._then);

  final RedditPost _value;
  // ignore: unused_field
  final $Res Function(RedditPost) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? permalink = freezed,
    Object? score = freezed,
    Object? thumbnail = freezed,
    Object? url = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      permalink: permalink == freezed
          ? _value.permalink
          : permalink // ignore: cast_nullable_to_non_nullable
              as String,
      score: score == freezed
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      thumbnail: thumbnail == freezed
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$RedditPostCopyWith<$Res> implements $RedditPostCopyWith<$Res> {
  factory _$RedditPostCopyWith(
          _RedditPost value, $Res Function(_RedditPost) then) =
      __$RedditPostCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'title') @HiveField(0) String title,
      @JsonKey(name: 'permalink') @HiveField(1) String permalink,
      @JsonKey(name: 'score') @HiveField(2) int score,
      @JsonKey(name: 'thumbnail') @HiveField(3) String thumbnail,
      @JsonKey(name: 'url') @HiveField(4) String url,
      @JsonKey(name: 'created_utc') @HiveField(5) double createdAt});
}

/// @nodoc
class __$RedditPostCopyWithImpl<$Res> extends _$RedditPostCopyWithImpl<$Res>
    implements _$RedditPostCopyWith<$Res> {
  __$RedditPostCopyWithImpl(
      _RedditPost _value, $Res Function(_RedditPost) _then)
      : super(_value, (v) => _then(v as _RedditPost));

  @override
  _RedditPost get _value => super._value as _RedditPost;

  @override
  $Res call({
    Object? title = freezed,
    Object? permalink = freezed,
    Object? score = freezed,
    Object? thumbnail = freezed,
    Object? url = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_RedditPost(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      permalink: permalink == freezed
          ? _value.permalink
          : permalink // ignore: cast_nullable_to_non_nullable
              as String,
      score: score == freezed
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      thumbnail: thumbnail == freezed
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 0, adapterName: 'RedditPostClassAdapter')
class _$_RedditPost extends _RedditPost {
  const _$_RedditPost(
      {@JsonKey(name: 'title') @HiveField(0) this.title = '',
      @JsonKey(name: 'permalink') @HiveField(1) this.permalink = '',
      @JsonKey(name: 'score') @HiveField(2) this.score = 0,
      @JsonKey(name: 'thumbnail') @HiveField(3) this.thumbnail = '',
      @JsonKey(name: 'url') @HiveField(4) this.url = '',
      @JsonKey(name: 'created_utc') @HiveField(5) this.createdAt = 0})
      : super._();

  factory _$_RedditPost.fromJson(Map<String, dynamic> json) =>
      _$$_RedditPostFromJson(json);

  @override
  @JsonKey(name: 'title')
  @HiveField(0)
  final String title;
  @override
  @JsonKey(name: 'permalink')
  @HiveField(1)
  final String permalink;
  @override
  @JsonKey(name: 'score')
  @HiveField(2)
  final int score;
  @override
  @JsonKey(name: 'thumbnail')
  @HiveField(3)
  final String thumbnail;
  @override
  @JsonKey(name: 'url')
  @HiveField(4)
  final String url;
  @override
  @JsonKey(name: 'created_utc')
  @HiveField(5)
  final double createdAt;

  @override
  String toString() {
    return 'RedditPost(title: $title, permalink: $permalink, score: $score, thumbnail: $thumbnail, url: $url, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RedditPost &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.permalink, permalink) ||
                const DeepCollectionEquality()
                    .equals(other.permalink, permalink)) &&
            (identical(other.score, score) ||
                const DeepCollectionEquality().equals(other.score, score)) &&
            (identical(other.thumbnail, thumbnail) ||
                const DeepCollectionEquality()
                    .equals(other.thumbnail, thumbnail)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(permalink) ^
      const DeepCollectionEquality().hash(score) ^
      const DeepCollectionEquality().hash(thumbnail) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(createdAt);

  @JsonKey(ignore: true)
  @override
  _$RedditPostCopyWith<_RedditPost> get copyWith =>
      __$RedditPostCopyWithImpl<_RedditPost>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RedditPostToJson(this);
  }
}

abstract class _RedditPost extends RedditPost {
  const factory _RedditPost(
          {@JsonKey(name: 'title') @HiveField(0) String title,
          @JsonKey(name: 'permalink') @HiveField(1) String permalink,
          @JsonKey(name: 'score') @HiveField(2) int score,
          @JsonKey(name: 'thumbnail') @HiveField(3) String thumbnail,
          @JsonKey(name: 'url') @HiveField(4) String url,
          @JsonKey(name: 'created_utc') @HiveField(5) double createdAt}) =
      _$_RedditPost;
  const _RedditPost._() : super._();

  factory _RedditPost.fromJson(Map<String, dynamic> json) =
      _$_RedditPost.fromJson;

  @override
  @JsonKey(name: 'title')
  @HiveField(0)
  String get title => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'permalink')
  @HiveField(1)
  String get permalink => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'score')
  @HiveField(2)
  int get score => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'thumbnail')
  @HiveField(3)
  String get thumbnail => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'url')
  @HiveField(4)
  String get url => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'created_utc')
  @HiveField(5)
  double get createdAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RedditPostCopyWith<_RedditPost> get copyWith =>
      throw _privateConstructorUsedError;
}
