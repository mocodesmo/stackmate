// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:sats/zold/cubit/email-login.dart';
// import 'package:sats/pkg/extensions.dart';

// class PolicyText extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: RichText(
//           textAlign: TextAlign.center,
//           text: TextSpan(children: [
//             TextSpan(
//                 text: 'By logging, in you are agreeing to our\n',
//                 style: context.fonts.caption),
//             TextSpan(
//               text: 'Terms & Conditions',
//               recognizer: new TapGestureRecognizer()
//                 ..onTap = () {
//                   context.read<EmailCubit>().openTerms();
//                 },
//               style: context.fonts.caption!
//                   .copyWith(color: context.colours.primaryVariant),
//             ),
//             TextSpan(text: '   and   ', style: context.fonts.caption),
//             TextSpan(
//               text: 'Privacy Policy',
//               recognizer: new TapGestureRecognizer()
//                 ..onTap = () {
//                   context.read<EmailCubit>().opennPrivacy();
//                 },
//               style: context.fonts.caption!
//                   .copyWith(color: context.colours.primaryVariant),
//             ),
//           ])),
//       //child: Text(
//       //    'By logging, in you are agreeing to our\nTerms & Conditions   and  Privacy Policy'
//       //        .notLocalised(),
//       //    textAlign: TextAlign.center,
//       //    style: context.fonts.caption),
//     );
//   }
// }
