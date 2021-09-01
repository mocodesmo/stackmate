// import 'package:flutter/material.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/view/common/header.dart';
// import 'package:sats/zold/cubit/user.dart';

// class HomeSettingsHeader extends StatelessWidget {
//   const HomeSettingsHeader({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final user = context.select((UserCubit bloc) => bloc.state.user);
//     if (user == null) return Container();

//     return Header(cornerTitle: 'STACKMATE', children: [
//       //SizedBox(height: 24),
//       Text('LOGGED IN FROM'.notLocalised(),
//           style:
//               context.fonts.overline!.copyWith(color: context.colours.surface)),
//       Text(user.email,
//           style:
//               context.fonts.headline6!.copyWith(color: context.colours.surface))
//     ]);
//   }
// }
