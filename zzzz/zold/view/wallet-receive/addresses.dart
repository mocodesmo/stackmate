// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:sats/zold/cubit/wallet.dart';
// import 'package:sats/pkg/extensions.dart';

// class BtcReceieveAddresses extends StatelessWidget {
//   const BtcReceieveAddresses({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext c) {
//     final wallet = c.select((WalletCubit w) => w.state.selectedWallet!);
//     return _BtcReceiveCell(
//       title: wallet.label,
//       description: 'Segwit-Compatible',
//       address: wallet.address,
//       isExpanded: true,
//     );
//   }
// }

// class _BtcReceiveCell extends StatelessWidget {
//   const _BtcReceiveCell({
//     Key? key,
//     required this.title,
//     required this.description,
//     required this.address,
//     required this.isExpanded,
//     this.onTapped,
//   }) : super(key: key);

//   final String title;
//   final String description;
//   final String address;
//   final bool isExpanded;
//   final Function? onTapped;

//   @override
//   Widget build(BuildContext c) {
//     return GestureDetector(
//         onTap: () {
//           if (onTapped != null) onTapped!();
//         },
//         child: Container(
//             margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(2),
//                 color: c.colours.surface),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text(title,
//                       style: c.fonts.subtitle2!
//                           .copyWith(fontWeight: FontWeight.bold)),
//                   Text(description, style: c.fonts.caption),
//                   if (isExpanded) ...[
//                     SizedBox(height: 24),
//                     Row(children: [
//                       Expanded(
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                             Text('ADDRESS'.notLocalised(),
//                                 style: c.fonts.overline),
//                             Container(
//                                 width: c.width / 3,
//                                 child: Text(address, style: c.fonts.caption)),
//                             GestureDetector(
//                                 onTap: () {
//                                   c.read<WalletCubit>().copyAddress(address);
//                                 },
//                                 child: Text('COPY',
//                                     style: c.fonts.button!.copyWith(
//                                         color: c.colours.primaryVariant))),
//                             SizedBox(height: 32),
//                             SizedBox(
//                               width: c.width / 4,
//                               child: ElevatedButton(
//                                   onPressed: () {
//                                     c.read<WalletCubit>().shareAddress(address);
//                                   },
//                                   child: Text('Share'.notLocalised())),
//                             )
//                           ])),
//                       Expanded(
//                           child:
//                               QrImage(data: address, version: QrVersions.auto))
//                     ])
//                   ]
//                 ])));
//   }
// }
