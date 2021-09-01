import 'package:flutter/material.dart';
import 'package:sats/navigation.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/home/reddit-feed.dart';
import 'dart:ui';

class HeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 16, top: 32, bottom: 16),
        child: Row(children: [
          Text(
            'STACKMATE',
            style: c.fonts.headline5!.copyWith(
              color: Colors.white,

              // color: Colors.blue[400],
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.lightbulb_outline_sharp,
                size: 32,
                // color: Colors.blue[400],
                color: c.colours.primary),
          ),
        ]));
  }
}

class AccountsRow extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return Container(
        child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              SizedBox(width: 16),
              for (var i = 0; i < 5; i++) ...[
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Material(
                        elevation: 4,
                        shadowColor: Colors.white24,
                        borderRadius: BorderRadius.circular(16),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                          child: Container(
                              height: 180,
                              width: 150,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.centerRight,
                                    stops: [
                                      0.3,
                                      0.99
                                    ],
                                    colors: [
                                      Colors.blue[300]!.withOpacity(0.5),
                                      Colors.teal[100]!.withOpacity(0.5)
                                    ]),
                              )),
                        )))
              ],
              SizedBox(width: 16),
            ])));
  }
}

class ActionsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 8, left: 24, right: 24, bottom: 16),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.qr_code,
                size: 32,
                // color: Colors.blue[400],
                color: context.colours.primary

                ///Colors.orange[400],
                ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.addWallet);
            },
            icon: Icon(Icons.add,
                size: 32,
                // color: Colors.blue[400],
                color: context.colours.primary),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.calculate_sharp,
                  size: 32, color: context.colours.primary

                  // color: Colors.blue[400],
                  )),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings, size: 32, color: context.colours.primary
                // color: Colors.blue[400],
                ),
          ),
        ]));
  }
}

class FeedRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RedditFeed();
  }
}

class NewHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
            stretch: true,
            //floating: true,
            pinned: true,
            expandedHeight: 350,
            // collapsedHeight: 88,
            // leadingWidth: c.width * 0.33,
            backgroundColor: c.colours.secondary,
            flexibleSpace: FlexibleSpaceBar(
                stretchModes: [
                  StretchMode.blurBackground,
                  //StretchMode.zoomBackground,
                  StretchMode.fadeTitle
                ],
                //centerTitle: true,
                collapseMode: CollapseMode.pin,
                background: Column(children: [
                  HeaderRow(),
                  AccountsRow(),
                ])),
            bottom: PreferredSize(
              preferredSize: Size(c.width, 24),
              child: ActionsRow(),
            )),
        SliverList(
            delegate: SliverChildListDelegate([
          FeedRow(),
        ]))
      ]),
      // body: SingleChildScrollView(
      //     child: Column(children: [
      //   Material(
      //       elevation: 8,
      //       shadowColor: Colors.lightBlue.withOpacity(0.3),
      //       color: context.colours.secondary,
      //       child: Column(children: [
      //         HeaderRow(),
      //         AccountsRow(),
      //         ActionsRow(),
      //         SizedBox(height: 16)
      //       ])),
      //   FeedRow(),
      // ])),
    );
  }
}
