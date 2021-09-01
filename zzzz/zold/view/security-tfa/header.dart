// import 'package:flutter/material.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/view/common/back-button.dart';
// import 'package:sats/zold/view/common/header-text.dart';
// import 'package:sats/zold/view/common/header.dart';
// import 'package:sats/zold/cubit/security-tfa.dart';
// import 'package:sats/zold/view/security-tfa/open-auth-button.dart';

// class SecurityTfaHeader extends StatelessWidget {
//   const SecurityTfaHeader({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext c) {
//     final keyGenerated =
//         c.select((SecurityTfaCubit bloc) => bloc.state.keyGenerated);

//     return AnimatedSwitcher(
//         duration: Duration(milliseconds: 800),
//         child: () {
//           if (!keyGenerated)
//             return Header(
//                 cornerTitle: 'SETUP\nAUTHENTICATOR'.notLocalised(),
//                 children: [
//                   BckButton(
//                       text: 'BACK',
//                       onTapped: () {
//                         Navigator.pop(c);
//                       }),
//                   SizedBox(height: 16),
//                   HeaderText(
//                       text:
//                           'Steps to  setup\nan authenticator.'.notLocalised()),
//                   SizedBox(height: 16),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Text(
//                         'Make sure you have an\nAuthenticator app installed.\nHere are some,',
//                         style: c.fonts.bodyText1!
//                             .copyWith(color: c.colours.surface)),
//                   ),
//                   SizedBox(height: 8),
//                   SecurityTfaOpenAuthButton(),
//                   SizedBox(height: 16),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Text(
//                         'A secret key will be generated\nin the next step.',
//                         style: c.fonts.bodyText1!
//                             .copyWith(color: c.colours.surface)),
//                   ),
//                   SizedBox(height: 16),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Text(
//                         'Copy the key and add it into your authenticator app.',
//                         style: c.fonts.bodyText1!
//                             .copyWith(color: c.colours.surface)),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Text(
//                         '\nWARNING:\nThe secret key will only be shared once.',
//                         style: c.fonts.bodyText1!
//                             .copyWith(color: c.colours.error)),
//                   ),
//                   SizedBox(height: 16),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Text(
//                         'Contact support immediately in the event\nof lost/stolen device, your secret key\nwill need to the reset.',
//                         style: c.fonts.bodyText1!
//                             .copyWith(color: c.colours.error)),
//                   )
//                 ]);

//           return Header(
//             cornerTitle: 'SETUP\nAUTHENTICATOR'.notLocalised(),
//             children: [
//               BckButton(
//                   text: 'BACK'.notLocalised(),
//                   onTapped: () {
//                     Navigator.pop(c);
//                   }),
//               SizedBox(height: 24),
//               HeaderText(
//                   text: 'Copy secret key\nto your\nauthenticator.'
//                       .notLocalised()),
//               SizedBox(height: 16),
//               Padding(
//                   padding: const EdgeInsets.only(left: 8.0),
//                   child: Text('Open Authenticator'.notLocalised(),
//                       style: c.fonts.bodyText2!
//                           .copyWith(color: c.colours.surface))),
//               SizedBox(height: 8),
//               SecurityTfaOpenAuthButton(),
//             ],
//           );
//         }());
//   }
// }
