// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/style.dart';
// import 'package:sats/zold/view/common/loading.dart';
// import 'package:sats/zold/view/common/main-button.dart';
// import 'package:sats/zold/cubit/pin/pin-keyboard.dart';
// import 'package:sats/zold/cubit/pin/pin-login.dart';

// class PinLoginButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSwitcher(
//         duration: Duration(milliseconds: 2000),
//         transitionBuilder: (child, animation) =>
//             buttonToLoaderTransition(child: child, animation: animation),
//         child: BlocBuilder<PinKeyboardCubit, PinKeyboardState>(
//             //key: ValueKey(9),
//             buildWhen: (previous, current) =>
//                 previous.fourKeysEntered().not(current.fourKeysEntered()),
//             builder: (context, keyboardState) {
//               return BlocBuilder<PinLoginCubit, PinLoginState>(
//                   builder: (context, state) {
//                 if (state.confirmingPin)
//                   return Loading(
//                     text: 'Confirming ..'.notLocalised(),
//                   );

//                 if (state.verified) return Container();

//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     SizedBox(height: 40),
//                     _Button(isOn: keyboardState.fourKeysEntered()),
//                   ],
//                 );
//               });
//             }));
//   }
// }

// class _Button extends StatelessWidget {
//   const _Button({Key? key, required this.isOn}) : super(key: key);

//   final bool isOn;

//   @override
//   Widget build(BuildContext context) {
//     final buttonOpacity = isOn ? 1.0 : 0.3;

//     return AnimatedSwitcher(
//       duration: Duration(milliseconds: 400),
//       child: Opacity(
//           key: isOn ? ValueKey(1) : ValueKey(2),
//           opacity: buttonOpacity,
//           child: MainButton(
//               text: 'Confirm Pin'.notLocalised(),
//               onTapped: () {
//                 if (isOn)
//                   context.read<PinLoginCubit>().pinLoginVerifyButtonPressed();
//               })),
//     );
//   }
// }
