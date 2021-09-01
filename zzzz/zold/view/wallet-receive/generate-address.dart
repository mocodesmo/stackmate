// import 'package:flutter/material.dart';
// import 'package:sats/zold/cubit/address-generate.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/view/common/loading.dart';

// class GenerateAddressSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext c) {
//     final state = c.select((AddressGenerateCubit s) => s.state);

//     return Container(
//         margin: const EdgeInsets.only(
//           left: 4,
//           right: 4,
//           top: 4,
//           bottom: 4,
//         ),
//         padding: const EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//             color: c.colours.onBackground,
//             borderRadius: BorderRadius.circular(4)),
//         child:
//             Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//           Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Expanded(
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                   Text('NEW ADDRESS'.notLocalised(),
//                       style: c.fonts.subtitle2!.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: c.colours.background,
//                       )),
//                   SizedBox(height: 4),
//                   Text(
//                       'Generate a new address to\nreceive bitcoin'
//                           .notLocalised(),
//                       style: c.fonts.caption!
//                           .copyWith(color: c.colours.background))
//                 ])),
//             if (!state.expandAddressSection)
//               GestureDetector(
//                   onTap: () {
//                     c.read<AddressGenerateCubit>().expandedAddressSection();
//                   },
//                   child: Text('GENERATE'.notLocalised(),
//                       style: c.fonts.button!.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: c.colours.primary)))
//             else
//               GestureDetector(
//                   onTap: () {
//                     c.read<AddressGenerateCubit>().closeAddressSection();
//                   },
//                   child: Text('CLOSE'.notLocalised(),
//                       style: c.fonts.button!.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: c.colours.surface))),
//             SizedBox(width: 16),
//           ]),
//           if (state.expandAddressSection) ...[
//             SizedBox(height: 24),
//             TextField(
//                 onChanged: (text) {
//                   c.read<AddressGenerateCubit>().addressLabelChanged(text);
//                 },
//                 decoration: InputDecoration(hintText: 'Address label')),
//             SizedBox(height: 8),
//             if (state.savingAddress) Loading(text: 'Saving Address'),
//             if (state.errAddressGenerate != '') ...[
//               Text(state.errAddressGenerate,
//                   style: c.fonts.caption!.copyWith(color: c.colours.error)),
//             ],
//             if (!state.savingAddress && !state.addressSaved) ...[
//               SizedBox(height: 24),
//               Center(
//                   child: GestureDetector(
//                       onTap: () {
//                         c.read<AddressGenerateCubit>().generateClicked();
//                       },
//                       child: Text('GENERATE'.notLocalised(),
//                           style: c.fonts.button!.copyWith(
//                               fontWeight: FontWeight.bold,
//                               color: c.colours.primary)))),
//               SizedBox(height: 16)
//             ],
//           ]
//         ]));
//   }
// }
