// import 'package:flutter/material.dart';
// import 'package:sats/zold/cubit/wallet.dart';
// import 'package:sats/pkg/extensions.dart';

// class WalletInfo extends StatelessWidget {
//   const WalletInfo({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext c) {
//     final wallet = c.select((WalletCubit w) => w.state.selectedWallet!);

//     return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//       Container(
//           color: c.colours.background,
//           margin: EdgeInsets.all(4),
//           padding: EdgeInsets.all(16),
//           child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text('Fingerprint'.notLocalised()),
//             Spacer(),
//             Expanded(
//                 child: Text(wallet.fingerprint, textAlign: TextAlign.right)),
//           ])),
//       Container(
//           color: c.colours.background,
//           margin: EdgeInsets.all(4),
//           padding: EdgeInsets.all(16),
//           child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text('Derivation Path'.notLocalised()),
//             Spacer(),
//             Expanded(child: Text(wallet.path, textAlign: TextAlign.right)),
//           ])),
//       Container(
//           color: c.colours.background,
//           margin: EdgeInsets.all(4),
//           padding: EdgeInsets.all(16),
//           child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text('XPub'.notLocalised()),
//             Spacer(),
//             Expanded(child: Text(wallet.xpub, textAlign: TextAlign.right)),
//           ])),
//     ]);
//   }
// }
