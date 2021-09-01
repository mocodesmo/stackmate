// import 'package:flutter/material.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/view/common/header.dart';
// import 'package:sats/zold/cubit/wallet.dart';

// class WorthHeader extends StatelessWidget {
//   const WorthHeader({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext c) {
//     return AnimatedSwitcher(
//       duration: Duration(milliseconds: 800),
//       child: BlocBuilder<WalletCubit, WalletState>(
//           //buildWhen: (previous, current) =>
//           //    previous.wallet.totalWorth.not(current.wallet.totalWorth) ||
//           //    previous.loadingWallets.not(current.loadingWallets),
//           builder: (context, state) {
//         final loading = state.loadingWallets;

//         return Header(cornerTitle: 'STACKMATE', children: [
//           if (loading) SizedBox(height: 32),
//           if (!loading) ...[
//             Text('BALANCE'.notLocalised(),
//                 style: c.fonts.overline!.copyWith(color: c.colours.surface)),
//             Text('' + state.totakWorthSatsStr() + ' sats',
//                 style: c.fonts.headline5!.copyWith(color: c.colours.surface)),
//             Text(' ' + state.totalWorthBtcStr() + ' BTC',
//                 style: c.fonts.caption!
//                     .copyWith(color: c.colours.surface.withAlpha(200))),
//           ] else ...[
//             SizedBox(height: 32),
//           ],
//         ]);
//       }),
//     );
//   }
// }
