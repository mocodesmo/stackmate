// import 'package:flutter/material.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/cubit/pin/pin-login.dart';
// import 'package:sats/zold/view/common/header-text.dart';
// import 'package:sats/zold/view/common/header.dart';

// class PinLoginHeader extends StatelessWidget {
//   const PinLoginHeader({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSwitcher(
//       duration: Duration(milliseconds: 800),
//       child:
//           BlocBuilder<PinLoginCubit, PinLoginState>(builder: (context, state) {
//         return Header(cornerTitle: 'STACKMATE', children: [
//           SizedBox(height: 8),
//           if (!state.locked()) ...[
//             HeaderText(
//               text: 'Enter Your\nSecurity Pin'.notLocalised(),
//             ),
//           ],
//           if (state.locked()) ...[
//             HeaderText(
//               text: 'Your Account\nis locked.'.notLocalised(),
//             ),
//           ],
//           SizedBox(height: 8),
//           Padding(
//               padding: const EdgeInsets.only(left: 8.0, top: 8),
//               child: Text('Forgot Pin?',
//                   style: context.fonts.caption!
//                       .copyWith(color: context.colours.surface))),
//           Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: Text('Contact Support',
//                   style: context.fonts.button!
//                       .copyWith(color: context.colours.error)))
//         ]);
//       }),
//     );
//   }
// }
