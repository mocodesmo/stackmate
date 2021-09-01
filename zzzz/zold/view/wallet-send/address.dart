// import 'package:flutter/material.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/cubit/btc-send/address.dart';
// import 'package:sats/zold/cubit/btc-send/send.dart';
// import 'package:sats/zold/view/common/back-button.dart';
// import 'package:sats/zold/view/common/header-text.dart';
// import 'package:sats/zold/view/common/header.dart';
// import 'package:sats/zold/view/common/main-button.dart';

// class BtcSendAddress extends StatefulWidget {
//   const BtcSendAddress({Key? key}) : super(key: key);

//   @override
//   _BtcSendAddressState createState() => _BtcSendAddressState();
// }

// class _BtcSendAddressState extends State<BtcSendAddress> {
//   TextEditingController? _addressController;
//   TextEditingController? _commentController;

//   @override
//   void initState() {
//     _addressController = TextEditingController();
//     _commentController = TextEditingController();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext c) {
//     return BlocBuilder<BtcSendAddressCubit, BtcSendAddressState>(
//         builder: (context, addressState) {
//       if (_addressController!.text != addressState.address)
//         _addressController!.text = addressState.address;

//       if (_commentController!.text != addressState.comment)
//         _commentController!.text = addressState.comment;

//       return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//         Header(cornerTitle: 'SEND BITCOIN'.notLocalised(), children: [
//           BckButton(
//               text: 'BACK',
//               onTapped: () {
//                 Navigator.pop(c);
//               }),
//           SizedBox(height: 16),
//           HeaderText(text: 'Enter address\nto send')
//         ]),
//         SizedBox(height: 24),
//         Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(children: [
//               Expanded(
//                   child: Text('ADDRESS'.notLocalised(),
//                       style: c.fonts.overline!
//                           .copyWith(fontWeight: FontWeight.bold))),
//               ElevatedButton(
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     child: Text('OPEN SCANNER'),
//                   ),
//                   onPressed: () {
//                     c.read<BtcSendAddressCubit>().toggleCamera();
//                   })
//             ])),
//         Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: TextField(
//                 onChanged: (text) {
//                   c.read<BtcSendAddressCubit>().addressChanged(text);
//                 },
//                 controller: _addressController,
//                 decoration: InputDecoration(
//                     errorText: addressState.addressError.nullIfEmpty(),
//                     fillColor: c.colours.surface,
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(2))))),
//         SizedBox(height: 8),
//         Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Align(
//                 alignment: Alignment.centerRight,
//                 child: GestureDetector(
//                     onTap: () {
//                       c.read<BtcSendAddressCubit>().pasteAddress();
//                     },
//                     child: Text('PASTE FROM CLIPBOARD'.notLocalised(),
//                         style: c.fonts.button!
//                             .copyWith(color: c.colours.primaryVariant))))),
//         SizedBox(height: 32),
//         Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: Text('COMMENT ( OPTIONAL )'.notLocalised(),
//                 style:
//                     c.fonts.overline!.copyWith(fontWeight: FontWeight.bold))),
//         SizedBox(height: 8),
//         Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: TextField(
//                 controller: _commentController,
//                 onChanged: (text) {
//                   c.read<BtcSendAddressCubit>().commentChanged(text);
//                 },
//                 decoration: InputDecoration(
//                     errorText: addressState.commentError.nullIfEmpty(),
//                     fillColor: c.colours.surface,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(2),
//                     )))),
//         SizedBox(height: 48),
//         MainButton(
//             text: 'CONFIRM',
//             onTapped: () {
//               c.read<BtcSendCubit>().nextClicked();
//             })
//       ]);
//     });
//   }
// }
