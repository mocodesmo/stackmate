// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/view/common/pin-row.dart';
// import 'package:sats/zold/cubit/pin/pin-setup.dart';

// class PinSetupField extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSwitcher(
//       duration: Duration(milliseconds: 400),
//       child: BlocBuilder<PinSetupCubit, PinSetupState>(
//           buildWhen: (previous, current) =>
//               previous.pin.not(current.pin) ||
//               previous.confirmPin.not(current.confirmPin) ||
//               previous.pinEntered.not(current.pinEntered),
//           builder: (context, state) {
//             if (state.savingPin) return Container();

//             if (!state.pinEntered) {
//               //_controller!.text = fillPinInputText(state.pin);
//               return Container(
//                 width: context.width * 0.66,
//                 child: PinRow(count: state.pin),
//                 //child: IgnorePointer(
//                 //  child: PinInputTextField(
//                 //      controller: _controller,
//                 //      key: kSetupPinField1,
//                 //      pinLength: 4,
//                 //      decoration: pinInputDecoration),
//                 //),
//               );
//             }

//             //_controller!.text = fillPinInputText(state.confirmPin);
//             return Column(children: [
//               Container(
//                 width: context.width * 0.66,
//                 child: PinRow(count: state.confirmPin),
//                 //child: IgnorePointer(
//                 //  child: PinInputTextField(
//                 //      controller: _controller,
//                 //      key: kSetupPinField2,
//                 //      pinLength: 4,
//                 //      decoration: pinInputDecoration),
//                 //),
//               ),
//               if (state.confirmPinError != '') ...[
//                 SizedBox(height: 8),
//                 Text(state.confirmPinError,
//                     style: context.fonts.caption!
//                         .copyWith(color: context.colours.error))
//               ]
//             ]);
//           }),
//     );
//   }
// }
