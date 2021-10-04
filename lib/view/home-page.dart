import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sats/cubit/reddit.dart';
import 'package:sats/cubit/wallet/wallets.dart';
import 'package:sats/model/reddit-post.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/navigation.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/log-button.dart';

class HeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const RedditLoader(),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 24, right: 16),
            child: Row(
              children: [
                Text(
                  'STACKMATE',
                  style: c.fonts.headline5!.copyWith(
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(c, Routes.setting);
                  },
                  icon: Icon(
                    Icons.settings,
                    size: 32,
                    color: c.colours.primary,
                  ),
                ),

                // LogButton(
                //   child: IconButton(
                //     onPressed: () {},
                //     icon: Icon(
                //       Icons.lightbulb_outline_sharp,
                //       size: 32,
                //       color: c.colours.primary,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WalletCard extends StatelessWidget {
  const WalletCard({
    Key? key,
    required this.wallet,
    this.isSelection = false,
  }) : super(key: key);

  final Wallet wallet;
  final bool isSelection;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<WalletsCubit>().walletSelected(wallet);
        if (!isSelection) {
          Navigator.pushNamed(
            context,
            Routes.wallet,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: context.colours.background,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              // sigmaX: 0,
              // sigmaY: 0,
              tileMode: TileMode.mirror,
            ),
            child: Container(
              height: 180,
              width: 150,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  // end: Alignment.centerRight,
                  stops: const [0.3, 0.99],
                  colors: [
                    context.colours.surface,
                    context.colours.surface,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    wallet.label,
                    style: context.fonts.subtitle1!.copyWith(
                      color: context.colours.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    wallet.descriptor,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 10,
                    style: context.fonts.caption!.copyWith(
                      color: context.colours.onBackground.withOpacity(0.8),
                      fontSize: 8,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'SINGLE SIGNATURE',
                    overflow: TextOverflow.ellipsis,
                    // textAlign: TextAlign.end,
                    maxLines: 10,
                    style: context.fonts.caption!.copyWith(
                      color: context.colours.onBackground,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AccountsRow extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    final wallets = c.select((WalletsCubit w) => w.state.wallets);
    if (wallets.isEmpty)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 66),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'No\nwallets\nadded',
              style: c.fonts.caption!.copyWith(
                color: c.colours.onBackground,
              ),
            ),
          ),
        ],
      );
    return Container(
      width: c.width,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 16),
            for (var w in wallets) WalletCard(wallet: w),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}

class ActionsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, left: 24, right: 24, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.qr);
            },
            icon: Icon(Icons.qr_code, size: 32, color: context.colours.primary),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.addWallet);
            },
            icon: Icon(Icons.add, size: 32, color: context.colours.primary),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.addressBook);
            },
            icon: Icon(
              Icons.schema_outlined,
              size: 32,
              color: context.colours.primary,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.calc);
            },
            icon: Icon(
              Icons.calculate_sharp,
              size: 32,
              color: context.colours.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class RedditLoader extends StatelessWidget {
  const RedditLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    final loading = c.select((RedditCubit c) => c.state.loading);

    if (loading) return const LinearProgressIndicator();

    return Container();
  }
}

class RedditFeed extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    final redditState = c.select((RedditCubit c) => c.state);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (redditState.error != '') ...[
          const SizedBox(height: 32),
          Center(
            child: Text(
              redditState.error,
              style: c.fonts.overline!.copyWith(
                color: c.colours.onBackground,
              ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                c.read<RedditCubit>().getPosts();
              },
              child: const Text(
                'Try Again.',
                // style: c.fonts.button!.copyWith(
                // color: Colors.white,
                // ),
              ),
            ),
          ),
          const SizedBox(height: 100),
        ] else ...[
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              'REDDIT FEED',
              style: c.fonts.overline!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          for (var post in redditState.posts) FeedItem(post: post),
          const SizedBox(height: 40),
        ]
      ],
    );
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          margin: const EdgeInsets.symmetric(
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: c.colours.surface,
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 16,
                    bottom: 8,
                    top: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        post.time(),
                        style: c.fonts.overline!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        post.title,
                        style: c.fonts.caption!.copyWith(
                          color: c.colours.onSurface,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            stretch: true,
            pinned: true,
            expandedHeight: 350,
            automaticallyImplyLeading: false,
            backgroundColor: c.colours.secondary,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.blurBackground,
                StretchMode.fadeTitle
              ],
              collapseMode: CollapseMode.pin,
              background: Column(
                children: [
                  HeaderRow(),
                  AccountsRow(),
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size(c.width, 20),
              child: ActionsRow(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                RedditFeed(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
