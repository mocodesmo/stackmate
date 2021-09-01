// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/view/common/back-button.dart';
// import 'package:sats/zold/view/common/header-text.dart';
// import 'package:sats/zold/view/common/header.dart';

// class BtcSendComplete extends StatelessWidget {
//   const BtcSendComplete({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext c) {
//     return Column(children: [
//       Header(cornerTitle: 'SEND BITCOIN', children: [
//         BckButton(
//             text: 'Home',
//             onTapped: () {
//               Navigator.pushReplacementNamed(c, '/home');
//             }),
//         SizedBox(height: 32),
//         Align(
//             alignment: Alignment.centerLeft,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: FadeInLeft(
//                 delay: Duration(seconds: 1),
//                 child: Icon(
//                   Icons.check_circle,
//                   color: Colors.green,
//                   size: 80,
//                 ),
//               ),
//             )),
//         HeaderText(text: 'Payment\nSent'.notLocalised()),
//         SizedBox(height: 16),
//         GestureDetector(
//           onTap: () {
//             Navigator.pop(c);
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: FadeIn(
//               delay: Duration(seconds: 2),
//               child: Text(
//                 'VIEW TRANSACTIONS'.notLocalised(),
//                 style:
//                     c.fonts.button!.copyWith(color: c.colours.primaryVariant),
//               ),
//             ),
//           ),
//         )
//       ])
//     ]);
//   }
// }
