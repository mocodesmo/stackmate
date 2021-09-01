// import 'package:flutter/material.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/cubit/pin/pin-change.dart';
// import 'package:sats/zold/view/pin-keyboard/keyboard.dart';

// class PinChangeKeyboard extends StatelessWidget {
//   const PinChangeKeyboard({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PinChangeCubit, PinChangeState>(
//         buildWhen: (previous, current) =>
//             previous.currentPinChecked.not(current.currentPinChecked) ||
//             previous.newPinComplete.not(current.newPinComplete),
//         builder: (context, state) {
//           if (!state.currentPinChecked) return PinKeyBoard();
//           if (state.currentPinChecked && !state.newPinComplete)
//             return PinKeyBoard();
//           if (state.newPinComplete) return PinKeyBoard();
//           return Container();
//         });
//   }
// }
