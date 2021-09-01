// import 'package:flutter/material.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/cubit/security-tfa.dart';

// class SecurityTfaShowKey extends StatelessWidget {
//   const SecurityTfaShowKey({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext c) {
//     return AnimatedSwitcher(
//       duration: Duration(milliseconds: 800),
//       child: BlocBuilder<SecurityTfaCubit, SecurityTfaState>(
//           //buildWhen: (previous, current) =>
//           //    previous.keyGenerated.not(current.keyGenerated),
//           builder: (context, state) {
//         if (state.verifyingPin) return Container();

//         if (!state.keyGenerated) return Container();
//         return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text('SECRET KEY'.notLocalised())),
//               SizedBox(width: context.width * 0.4, child: Text(state.key)),
//               SizedBox(height: 8),
//               SizedBox(
//                   width: context.width / 3,
//                   child: ElevatedButton(
//                       onPressed: () {
//                         c.read<SecurityTfaCubit>().copyKey();
//                       },
//                       child: Text('COPY')))
//             ]));
//       }),
//     );
//   }
// }
