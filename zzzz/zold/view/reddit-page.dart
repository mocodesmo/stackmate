// import 'package:flutter/material.dart';
// import 'package:sats/cubit/reddit.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/view/home/reddit-feed.dart';
// import 'package:sats/zold/view/home-info/learn-card.dart';

// class HomeInfoPage extends StatelessWidget {
//   const HomeInfoPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext c) {
//     return SafeArea(
//         child:
//             Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//       //WorthHeader(),
//       //HomeWalletsLoader(),
//       Expanded(
//           child: SingleChildScrollView(
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//             SizedBox(height: 24),
//             Padding(
//                 padding: const EdgeInsets.only(left: 16),
//                 child: Text('BITCOIN 101',
//                     style: c.fonts.subtitle2!.copyWith(
//                         color: c.colours.secondary,
//                         fontWeight: FontWeight.bold))),
//             SizedBox(height: 16),
//             SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Padding(
//                     padding: const EdgeInsets.only(bottom: 16),
//                     child: Row(children: [
//                       SizedBox(width: 16),
//                       LearnCard(
//                           onTap: () {
//                             c
//                                 .read<RedditCubit>()
//                                 .openLink('https://bitcoin.org/bitcoin.pdf');
//                           },
//                           textColor: c.colours.secondary,
//                           text: 'Bitcoin\nWhitepaper',
//                           color: c.colours.primary),
//                       SizedBox(width: 16),
//                       LearnCard(
//                           onTap: () {
//                             c.read<RedditCubit>().openLink(
//                                 'https://en.bitcoin.it/wiki/Proof_of_work');
//                           },
//                           textColor: c.colours.secondary,
//                           text: 'Proof of\nWork',
//                           color: c.colours.primary),
//                       SizedBox(width: 16),
//                       LearnCard(
//                           onTap: () {
//                             c.read<RedditCubit>().openLink(
//                                 'https://en.wikipedia.org/wiki/Lightning_Network');
//                           },
//                           textColor: c.colours.secondary,
//                           header: 'FUTURE',
//                           text: 'Ligthning\nNetwork',
//                           color: c.colours.primary),
//                       SizedBox(width: 24)
//                     ]))),
//             SizedBox(height: 24),
//             Padding(
//                 padding: const EdgeInsets.only(left: 16),
//                 child: Text('SECURITY BEST PRACTICES',
//                     style: c.fonts.subtitle2!.copyWith(
//                         color: c.colours.secondary,
//                         fontWeight: FontWeight.bold))),
//             SizedBox(height: 16),
//             SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Padding(
//                     padding: const EdgeInsets.only(bottom: 16),
//                     child: Row(children: [
//                       SizedBox(width: 16),
//                       LearnCard(
//                           onTap: () {
//                             c.read<RedditCubit>().openLink(
//                                 'https://www.google.com/landing/2step/');
//                           },
//                           textColor: c.colours.secondary,
//                           header: '3rd PARTY',
//                           text: '2-Factor\nAuthentication',
//                           color: c.colours.surface),
//                       SizedBox(width: 16),
//                       LearnCard(
//                           onTap: () {
//                             c.read<RedditCubit>().openLink(
//                                   'https://en.bitcoin.it/wiki/Hardware_wallet',
//                                 );
//                           },
//                           textColor: c.colours.secondary,
//                           header: 'PERSONAL',
//                           text: 'Hardware\nWallets',
//                           color: c.colours.surface),
//                       SizedBox(width: 16),
//                       LearnCard(
//                           onTap: () {
//                             c.read<RedditCubit>().openLink(
//                                   'https://www.cryptomathic.com/news-events/blog/distributed-vs-centralized-key-management',
//                                 );
//                           },
//                           header: 'EXPERT',
//                           text: 'Decentralised\nKeys',
//                           textColor: c.colours.surface,
//                           color: c.colours.secondary),
//                       SizedBox(width: 24)
//                     ]))),
//             SizedBox(height: 24),
//             Padding(
//                 padding: const EdgeInsets.only(left: 16),
//                 child: GestureDetector(
//                   onLongPress: () {
//                     c.read<RedditCubit>().getPosts();
//                   },
//                   child: Text('LASTEST',
//                       style: c.fonts.subtitle2!.copyWith(
//                           color: c.colours.secondary,
//                           fontWeight: FontWeight.bold)),
//                 )),
//             SizedBox(height: 16),
//             RedditFeed(),
//           ])))
//     ]));
//   }
// }
