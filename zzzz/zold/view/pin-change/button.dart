// import 'package:flutter/material.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/view/common/loading.dart';
// import 'package:sats/zold/view/common/main-button.dart';
// import 'package:sats/zold/cubit/pin/pin-change.dart';

// class PinChangeButton extends StatelessWidget {
//   const PinChangeButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSwitcher(
//       duration: Duration(milliseconds: 800),
//       child: BlocBuilder<PinChangeCubit, PinChangeState>(
//           buildWhen: (previous, current) =>
//               previous.currentPinChecked.not(current.currentPinChecked) ||
//               previous.newPinComplete.not(current.newPinComplete),
//           builder: (context, state) {
//             if (state.checkingCurrentPin) return Loading(text: 'Checking Pin');

//             if (state.savingNewPin) return Loading(text: 'Checking Pin');

//             if (!state.currentPinChecked)
//               return MainButton(text: 'VERIFY', onTapped: () {});

//             if (state.currentPinChecked && !state.newPinComplete)
//               return MainButton(text: 'CONFIRM PIN', onTapped: () {});

//             if (state.newPinComplete)
//               return MainButton(text: 'SAVE NEW PIN', onTapped: () {});

//             return Container();
//           }),
//     );
//   }
// }
