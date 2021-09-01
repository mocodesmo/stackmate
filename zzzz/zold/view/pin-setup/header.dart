// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/view/common/back-button.dart';
// import 'package:sats/zold/view/common/header-text.dart';
// import 'package:sats/zold/view/common/header.dart';
// import 'package:sats/zold/cubit/user.dart';
// import 'package:sats/zold/cubit/pin/pin-setup.dart';

// class PinSetupHeader extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSwitcher(
//       duration: Duration(milliseconds: 800),
//       child: BlocBuilder<PinSetupCubit, PinSetupState>(
//           buildWhen: (previous, current) =>
//               previous.pinEntered.not(current.pinEntered),
//           builder: (c, state) {
//             return Header(cornerTitle: 'STACKMATE', children: [
//               if (!state.pinEntered)
//                 Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       BckButton(
//                           text: 'LOG OUT'.notLocalised(),
//                           onTapped: () {
//                             c.read<UserCubit>().logOut();
//                           }),
//                       SizedBox(height: 48),
//                       HeaderText(
//                         text: 'Setup Your\nSecurity Pin',
//                       ),
//                       SizedBox(height: 4),
//                       Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                               'For enhanced security, we require that you to\nenter a security pin for all important action.',
//                               style: c.fonts.caption!
//                                   .copyWith(color: c.colours.surface)))
//                     ])
//               else
//                 Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       BckButton(
//                           text: 'BACK'.notLocalised(),
//                           onTapped: () {
//                             c.read<PinSetupCubit>().confirmPinBackClicked();
//                           }),
//                       SizedBox(height: 48),
//                       HeaderText(
//                         text: 'Confirm Your\nSecurity Pin',
//                       ),
//                     ])
//             ]);
//           }),
//     );
//   }
// }
