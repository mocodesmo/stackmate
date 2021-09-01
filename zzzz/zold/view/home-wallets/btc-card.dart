// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/cubit/wallet.dart';
// import 'package:sats/pkg/validation.dart';

// class HomeWalletsBtcCard extends StatelessWidget {
//   const HomeWalletsBtcCard({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext c) {
//     return AnimatedSwitcher(
//         duration: Duration(milliseconds: 1000),
//         reverseDuration: Duration(milliseconds: 1000),
//         child: BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
//           if (state.wallets.isEmpty) return Container();

//           List<Widget> wallets = [];

//           for (var wallet in state.wallets) {
//             if (wallet.balances.zeroBalance())
//               wallets.add(GestureDetector(
//                   onTap: () {
//                     c.read<WalletCubit>().walletSelected(wallet.nickname);
//                     Navigator.pushNamed(context, '/btc-receive');
//                   },
//                   child: Material(
//                       color: c.colours.primary,
//                       borderRadius: BorderRadius.circular(16),
//                       elevation: 4,
//                       child: Container(
//                           width: c.width - 32,
//                           height: c.width * 0.55,
//                           padding: EdgeInsets.all(16),
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Text(wallet.nickname,
//                                     style: c.fonts.subtitle1!
//                                         .copyWith(fontWeight: FontWeight.bold)),
//                                 SizedBox(height: 8),
//                                 Text('No Balance'.notLocalised(),
//                                     style: c.fonts.subtitle2!.copyWith(
//                                         color: c.colours.secondary
//                                             .withAlpha(150))),
//                                 Spacer(),
//                                 Text('Receive Bitcoin'.notLocalised(),
//                                     style: c.fonts.caption!.copyWith())
//                               ])))));
//             else
//               wallets.add(GestureDetector(
//                   onTap: () {
//                     c.read<WalletCubit>().walletSelected(wallet.nickname);
//                     Navigator.pushNamed(context, '/wallet-bitcoin');
//                   },
//                   child: Material(
//                       elevation: 4,
//                       color: c.colours.primary,
//                       borderRadius: BorderRadius.circular(16),
//                       child: Container(
//                           width: c.width - 32,
//                           height: c.width * 0.55,
//                           padding: EdgeInsets.all(16),
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Text(wallet.nickname,
//                                     style: c.fonts.subtitle1!
//                                         .copyWith(fontWeight: FontWeight.bold)),
//                                 SizedBox(height: 8),
//                                 Text(
//                                     Validation.addCommas(wallet
//                                             .balances.confirmed
//                                             .toString()) +
//                                         ' sats',
//                                     style: c.fonts.headline6!.copyWith(
//                                         color: c.colours.secondary
//                                             .withAlpha(150))),
//                                 Text(
//                                     ' ' +
//                                         wallet.balances.confirmedToBtc() +
//                                         ' BTC',
//                                     style: c.fonts.caption!.copyWith(
//                                         color: c.colours.secondary
//                                             .withAlpha(150))),
//                                 Spacer(),
//                                 Text('Exchange, Transfer & Orders',
//                                     style: c.fonts.caption!.copyWith())
//                               ])))));

//             wallets.add(SizedBox(height: 32));
//           }
//           wallets.removeLast();

//           return FadeIn(
//               delay: Duration(milliseconds: 500),
//               duration: Duration(milliseconds: 800),
//               child: Column(children: [
//                 ...wallets,
//                 SizedBox(height: 16),
//               ]));
//         }));
//   }
// }
