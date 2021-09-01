import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/api/reddit.dart';
import 'package:sats/model/reddit-post.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/pkg/launcher.dart';

part 'reddit.freezed.dart';

@freezed
class RedditState with _$RedditState {
  const factory RedditState({
    @Default([]) List<RedditPost> posts,
    @Default('') String error,
    @Default(false) bool loading,
  }) = _RedditState;
}

class RedditCubit extends Cubit<RedditState> {
  RedditCubit(
    this._reddit,
    this._logger,
    this._launcher,
  ) : super(RedditState()) {
    this.getPosts();
  }

  final IRedditAPI _reddit;
  final LoggerCubit _logger;
  final ILauncher _launcher;

  void getPosts() async {
    try {
      emit(state.copyWith(loading: true, error: ''));
      var response = await _reddit.fetchPosts('bitcoin');
      if (response.data == null || response.statusCode != 200) throw '';

      final posts = await compute(_parsePosts, response.data);

      emit(state.copyWith(posts: posts, loading: false));
    } catch (e, s) {
      _logger.logException(e, 'RedditBloc._mapGetPostsToState', s);
      emit(state.copyWith(loading: false, error: 'Error Occured.'));
    }
  }

  openPostLink(RedditPost post) {
    try {
      _launcher.launchApp(post.link());
    } catch (e, s) {
      _logger.logException(e, 'FeedItem._linkClicked', s);
    }
  }

  openLink(String link) {
    try {
      _launcher.launchApp(link);
    } catch (e, s) {
      _logger.logException(e, 'HomeInfoPage._openLink:' + link, s);
    }
  }
}

List<RedditPost> _parsePosts(dynamic body) {
  List<RedditPost> posts = [];
  for (var post in body['data']['children'])
    posts.add(RedditPost.fromJson(post['data']));
  posts.removeWhere((post) => post.score < 100);

  return posts;
}
