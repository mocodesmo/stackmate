// import 'package:flutter/material.dart';
// //import 'package:sats/zold/model/zsecurity.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/view/common/back-button.dart';
// import 'package:sats/zold/view/common/header-text.dart';
// import 'package:sats/zold/view/common/header.dart';
// import 'package:sats/zold/view/security-home/settings-cell.dart';

// enum SecurityType { tfa }

// class SecurityHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//             child: SingleChildScrollView(
//       child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//         Header(cornerTitle: 'SECURITY\nSETTINGS', children: [
//           BckButton(
//               text: 'BACK'.notLocalised(),
//               onTapped: () {
//                 Navigator.pop(context);
//               }),
//           SizedBox(height: 24),
//           HeaderText(text: 'Adjust levels\nof security'),
//           Padding(
//             padding: const EdgeInsets.only(left: 8.0),
//             child: Text(
//                 'for all important actions like\norder confirmation, payment account update, etc.',
//                 style: context.fonts.bodyText2!
//                     .copyWith(color: context.colours.surface)),
//           )
//         ]),
//         SizedBox(height: 24),
//         //SecurityHomeCell(type: SecurityType.otp),
//         SecurityHomeCell(type: SecurityType.tfa)
//       ]),
//     )));
//   }
// }
