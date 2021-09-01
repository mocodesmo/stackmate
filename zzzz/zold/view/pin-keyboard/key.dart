// import 'package:flutter/material.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/cubit/pin/pin-keyboard.dart';

// class PinKey extends StatelessWidget {
//   const PinKey({Key? key, required this.number}) : super(key: key);

//   final String number;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: context.width / 3,
//       height: 55,
//       child: InkWell(
//         enableFeedback: number == '' ? false : true,
//         onTap: () {
//           if (number == '') return;
//           if (number == 'x')
//             context.read<PinKeyboardCubit>().clearKeys();
//           else
//             context.read<PinKeyboardCubit>().keyPressed(number);
//         },
//         child: number == 'x'
//             ? Padding(
//                 padding: const EdgeInsets.only(top: 4.0, right: 4),
//                 child: Icon(Icons.backspace_outlined,
//                     color: context.colours.onBackground, size: 24),
//               )
//             : Column(
//                 //mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 8),
//                   Text(number, style: context.fonts.headline5),
//                 ],
//               ),
//       ),
//     );
//   }
// }
