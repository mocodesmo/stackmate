// import 'package:flutter/material.dart';
// import 'package:sats/zold/cubit/user.dart';
// import 'package:sats/pkg/extensions.dart';

// class SecurityTfaOpenAuthButton extends StatelessWidget {
//   const SecurityTfaOpenAuthButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext c) {
//     //return Container();
//     return Row(children: [
//       SizedBox(width: 8),
//       Expanded(
//           flex: 2,
//           child: GestureDetector(
//             onTap: () {
//               c.read<UserCubit>().openAuthApp(AuthApp.gauth);
//             },
//             child: Text('Google Authenticator',
//                 style:
//                     c.fonts.button!.copyWith(color: c.colours.primaryVariant)),
//           )),
//       //SizedBox(width: 48),
//       SizedBox(width: 8),
//       Expanded(
//           child: GestureDetector(
//         onTap: () {
//           c.read<UserCubit>().openAuthApp(AuthApp.freeotp);
//         },
//         child: Text('Free OTP',
//             style: c.fonts.button!.copyWith(color: c.colours.primaryVariant)),
//       )),
//       Spacer(),
//     ]);
//   }
// }
