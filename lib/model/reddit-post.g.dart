// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reddit-post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RedditPost _$$_RedditPostFromJson(Map<String, dynamic> json) =>
    _$_RedditPost(
      title: json['title'] as String? ?? '',
      permalink: json['permalink'] as String? ?? '',
      score: json['score'] as int? ?? 0,
      thumbnail: json['thumbnail'] as String? ?? '',
      url: json['url'] as String? ?? '',
      createdAt: (json['created_utc'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$_RedditPostToJson(_$_RedditPost instance) =>
    <String, dynamic>{
      'title': instance.title,
      'permalink': instance.permalink,
      'score': instance.score,
      'thumbnail': instance.thumbnail,
      'url': instance.url,
      'created_utc': instance.createdAt,
    };
