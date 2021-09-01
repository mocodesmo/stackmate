// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/cubit/network.dart';

// class TestNetCell extends StatelessWidget {
//   const TestNetCell({Key? key, this.isHome = false}) : super(key: key);

//   final bool isHome;

//   @override
//   Widget build(BuildContext c) {
//     return BlocBuilder<NetworkCubit, NetworkState>(builder: (context, state) {
//       final isTestNet = state.isTestNet;

//       return FadeIn(
//           child: GestureDetector(
//               onTap: () {
//                 c.read<NetworkCubit>().toggleTestNet(fromHome: isHome);
//               },
//               child: Container(
//                   margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(2),
//                       color: context.colours.surface),
//                   child: Column(children: [
//                     Row(children: [
//                       Expanded(
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                             Text('SELECT BLOCKCHAIN',
//                                 style: context.fonts.subtitle2!.copyWith(
//                                   fontWeight: FontWeight.bold,
//                                 )),
//                             SizedBox(height: 4),
//                             Text(
//                                 'Toggle between Bitcoin\'s\nTestnet and Mainnet',
//                                 style: context.fonts.caption)
//                           ])),
//                       Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             AbsorbPointer(
//                                 child: Switch(
//                                     value: isTestNet,
//                                     onChanged: (b) {},
//                                     thumbColor: MaterialStateProperty.all(
//                                         c.colours.surface),
//                                     activeColor: c.colours.error,
//                                     inactiveTrackColor: Colors.green)),
//                             Text(isTestNet ? 'TestNet' : 'MainNet',
//                                 style: context.fonts.subtitle2!.copyWith(
//                                     color: isTestNet
//                                         ? context.colours.error
//                                         : null),
//                                 textAlign: TextAlign.end)
//                           ])
//                     ])
//                   ]))));
//     });
//   }
// }
