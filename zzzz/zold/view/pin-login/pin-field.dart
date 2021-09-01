// import 'package:flutter/material.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/view/common/pin-row.dart';
// import 'package:sats/zold/cubit/pin/pin-login.dart';

// class PinLoginField extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSwitcher(
//       duration: Duration(milliseconds: 800),
//       child:
//           BlocBuilder<PinLoginCubit, PinLoginState>(builder: (context, state) {
//         //_controller!.text = fillPinInputText(state.pin);

//         if (state.locked() || state.confirmingPin || state.verified)
//           return Container();

//         return Column(children: [
//           SizedBox(height: 32),
//           Container(
//             width: context.width * 0.66,
//             child: PinRow(count: state.pin),
//             //child: IgnorePointer(
//             //    child: PinInputTextField(
//             //        controller: _controller,
//             //        key: kPinLoginPinField,
//             //        pinLength: 4,
//             //        decoration: pinInputDecoration)),
//           ),
//           SizedBox(height: 8),
//           if (state.error != '') ...[
//             Text(state.error,
//                 style: context.fonts.caption!
//                     .copyWith(color: context.colours.error))
//           ]
//         ]);
//       }),
//     );
//   }
// }
