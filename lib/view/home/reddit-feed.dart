import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sats/model/reddit-post.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/cubit/reddit.dart';

class RedditLoader extends StatelessWidget {
  const RedditLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    final loading = c.select((RedditCubit c) => c.state.loading);

    if (loading) return LinearProgressIndicator();

    return Container();
  }
}

class RedditFeed extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    final redditState = c.select((RedditCubit c) => c.state);

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      // if (redditState.loading) ...[
      //   SizedBox(height: 80),
      //   LinearProgressIndicator(),
      //   //SizedBox(height: 32),
      //   // FadeIn(
      //   //     duration: Duration(milliseconds: 500),
      //   //     child: Row(children: [
      //   //       Container(
      //   //         margin: EdgeInsets.only(left: 16),
      //   //         width: c.width * 0.25,
      //   //         child: Loading(text: 'Fetching Posts'),
      //   //       ),
      //   //       Expanded(child: Container())
      //   //     ])),
      //   SizedBox(height: 100),
      // ] else

      if (redditState.error != '') ...[
        SizedBox(height: 32),
        Center(child: Text(redditState.error)),
        Center(
            child: GestureDetector(
                onTap: () {
                  c.read<RedditCubit>().getPosts();
                },
                child: Text('Try Again.',
                    style: c.fonts.button!.copyWith(color: Colors.white)))),
        SizedBox(height: 100),
      ] else ...[
        SizedBox(height: 24),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text('REDDIT FEED',
              style: c.fonts.overline!.copyWith(
                color: Colors.white,
                // fontSize: 13,
                // fontWeight: FontWeight.bold,
              )),
        ),
        SizedBox(height: 8),
        for (var post in redditState.posts) FeedItem(post: post),
        SizedBox(height: 40),
      ]
    ]);
  }
}

class FeedItem extends StatelessWidget {
  const FeedItem({
    Key? key,
    required this.post,
  }) : super(key: key);
  final RedditPost post;

  @override
  Widget build(BuildContext c) {
    return FadeIn(
      child: GestureDetector(
          onTap: () {
            c.read<RedditCubit>().openPostLink(post);
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              margin: EdgeInsets.symmetric(
                vertical: 4,
                // horizontal: 8,
              ),
              decoration: BoxDecoration(
                color: c.colours.surface,
                // borderRadius: BorderRadius.circular(8),
              ),
              // height: 125,
              child: Row(children: [
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 16, bottom: 8, top: 8),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(post.time(),
                                  style: c.fonts.overline!.copyWith(
                                    color: Colors.white,
                                    // fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 4),
                              Text(post.title,
                                  style: c.fonts.caption!.copyWith(
                                    // fontWeight: FontWeight.bold,
                                    color: c.colours.onSurface,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis),
                            ]))),
                //if (post.hasImage())
                //  Container(
                //      height: 125 - 16,
                //      width: 125 - 16,
                //      color: c.colours.primary,
                //      child: Image.network(
                //        post.link(),
                //        fit: BoxFit.cover,
                //        errorBuilder: (context, error, stackTrace) {
                //          return Container();
                //        },
                //      ))
              ]))),
    );
  }
}
