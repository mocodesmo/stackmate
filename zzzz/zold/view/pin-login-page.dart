// import 'package:flutter/material.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/view/pin-keyboard/keyboard.dart';
// import 'package:sats/zold/cubit/pin/pin-login.dart';
// import 'package:sats/zold/view/pin-login/button.dart';
// import 'package:sats/zold/view/pin-login/header.dart';
// import 'package:sats/zold/view/pin-login/pin-field.dart';

// class PinLoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext c) {
//     return BlocListener<PinLoginCubit, PinLoginState>(
//       listener: (_, state) {
//         if (state.verified) Navigator.pushReplacementNamed(c, '/home');
//       },
//       child: Scaffold(
//           body: SafeArea(
//               //bottom: false,
//               child: Stack(children: [
//         SingleChildScrollView(
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//               PinLoginHeader(),
//               PinLoginField(),
//               PinLoginButton(),
//               SizedBox(height: c.height * 0.7)
//             ])),
//         BlocBuilder<PinLoginCubit, PinLoginState>(builder: (context, state) {
//           if (state.confirmingPin) return Container();

//           return PositionedDirectional(
//               bottom: 0, start: 0, end: 0, child: PinKeyBoard());
//         })
//       ]))),
//     );
//   }
// }
