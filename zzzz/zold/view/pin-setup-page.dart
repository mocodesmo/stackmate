// import 'package:flutter/material.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/view/pin-keyboard/keyboard.dart';
// import 'package:sats/zold/cubit/pin/pin-setup.dart';
// import 'package:sats/zold/view/pin-setup/button.dart';
// import 'package:sats/zold/view/pin-setup/header.dart';
// import 'package:sats/zold/view/pin-setup/pin_field.dart';

// class PinSetupPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext c) {
//     return BlocListener<PinSetupCubit, PinSetupState>(
//         listener: (_, state) {
//           if (state.pinSaved) Navigator.pushReplacementNamed(c, '/home');
//         },
//         child: Scaffold(
//             body: SafeArea(
//                 child: Stack(fit: StackFit.expand, children: [
//           SingleChildScrollView(
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                 PinSetupHeader(),
//                 SizedBox(height: 32),
//                 PinSetupField(),
//                 SizedBox(height: 40),
//                 PinSetupButton(),
//                 SizedBox(height: c.height * 0.7)
//               ])),
//           BlocBuilder<PinSetupCubit, PinSetupState>(builder: (context, state) {
//             if (state.savingPin) return Container();

//             return PositionedDirectional(
//                 bottom: 0, start: 0, end: 0, child: PinKeyBoard());
//           })
//         ]))));
//   }
// }
