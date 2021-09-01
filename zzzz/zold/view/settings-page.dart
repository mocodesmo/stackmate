// import 'package:flutter/material.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/cubit/user.dart';
// import 'package:sats/zold/view/home-settings/header.dart';
// import 'package:sats/zold/view/home-settings/security-cell.dart';
// import 'package:sats/zold/view/home-settings/settings-cell.dart';
// import 'package:sats/zold/view/home-settings/settings-button.dart';
// import 'package:sats/zold/view/home-settings/testnet-cell.dart';

// class HomeSettingsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: SingleChildScrollView(
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//           HomeSettingsHeader(),
//           SizedBox(height: 24),
//           Padding(
//             padding: const EdgeInsets.only(left: 16.0),
//             child: Text('SETTINGS', style: context.fonts.subtitle2),
//           ),
//           SizedBox(height: 16),
//           //UserIDCell(),
//           SecurityCell(),
//           TestNetCell(),
//           //SettingsCell(
//           //    key: kSettingsPinChangeCell,
//           //    title: 'LOGIN PIN'.notLocalised(),
//           //    description: 'Update your pin\nfrequently'.notLocalised(),
//           //    largeText: 'AUTHENTICATION\nFOR LOGIN',
//           //    onTap: () {}),
//           //SettingsCell(
//           //    title: 'TRADING REPORT'.notLocalised(),
//           //    description:
//           //        'A convenient way to export\nearning and trade reports.'
//           //            .notLocalised(),
//           //    largeText: 'HISTORY'.notLocalised(),
//           //    comingSoon: true,
//           //    onTap: () {}),
//           SettingsCell(
//               title: 'SUPPORT'.notLocalised(),
//               description:
//                   'Contact our support team\nfor guidance'.notLocalised(),
//               largeText: 'ASK FOR HELP'.notLocalised(),
//               onTap: () {}),
//           SettingsCell(
//               title: 'SHARE FEEDBACK'.notLocalised(),
//               description:
//                   'Your experience is most\nimportant to us.'.notLocalised(),
//               largeText: 'SUGGESTIONS'.notLocalised(),
//               onTap: () {}),
//           //SettingsCell(
//           //    title: 'INVITE & EARN'.notLocalised(),
//           //    description: 'Invite members and\nget rewards!'.notLocalised(),
//           //    largeText: 'REWARDS'.notLocalised(),
//           //    comingSoon: true,
//           //    onTap: () {}),
//           SizedBox(height: 16),
//           SettingsButton(text: 'FAQS'.notLocalised(), onPressed: () {}),
//           SettingsButton(text: 'RATE US'.notLocalised(), onPressed: () {}),
//           SettingsButton(
//               text: 'TERMS AND CONDITIONS'.notLocalised(), onPressed: () {}),
//           SettingsButton(
//               text: 'PRIVACY POLICY'.notLocalised(), onPressed: () {}),
//           SettingsButton(text: 'DIAGNOSTICS'.notLocalised(), onPressed: () {}),
//           SettingsButton(
//               text: 'LOG OUT'.notLocalised(),
//               onPressed: () {
//                 context.read<UserCubit>().logOut();
//               },
//               isRed: true),
//           SizedBox(height: 100),
//         ])));
//   }
// }
