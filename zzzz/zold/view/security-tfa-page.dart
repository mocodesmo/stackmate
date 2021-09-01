// import 'package:flutter/material.dart';
// import 'package:sats/zold/cubit/user.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/cubit/security-tfa.dart';
// import 'package:sats/zold/view/security-tfa/button.dart';
// import 'package:sats/zold/view/security-tfa/header.dart';
// import 'package:sats/zold/view/security-tfa/pin-field.dart';
// import 'package:sats/zold/view/security-tfa/show-key.dart';

// class SecurityTfaPage extends StatelessWidget {
//   const SecurityTfaPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<SecurityTfaCubit, SecurityTfaState>(
//         listener: (context, state) {
//           if (state.pinVerified) {
//             context.read<UserCubit>().tfaCompleted();
//             Navigator.pop(context);
//           }
//         },
//         child: Scaffold(
//             body: SafeArea(
//                 child: SingleChildScrollView(
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//               SecurityTfaHeader(),
//               SizedBox(height: 24),
//               SecurityTfaShowKey(),
//               SizedBox(height: 48),
//               SecurityTfaPinField(),
//               SecurityTfaButton(),
//               SizedBox(height: 48)
//             ])))));
//   }
// }
