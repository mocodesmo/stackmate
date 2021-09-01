// import 'package:flutter/material.dart';
// import 'package:sats/zold/cubit/btc-send/fee.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/view/wallet-send/address.dart';
// import 'package:sats/zold/view/wallet-send/amount.dart';
// import 'package:sats/zold/view/wallet-send/complete.dart';
// import 'package:sats/zold/view/wallet-send/confirm.dart';
// import 'package:sats/zold/cubit/btc-send/amount.dart';
// import 'package:sats/zold/cubit/btc-send/send.dart';
// import 'package:sats/zold/view/common/back-button.dart';
// import 'package:sats/zold/view/common/header-text.dart';
// import 'package:sats/zold/view/common/header.dart';
// import 'package:sats/zold/cubit/wallet.dart';
// import 'package:sats/zold/view/common/loading.dart';

// class BtcSendPage extends StatefulWidget {
//   const BtcSendPage({Key? key}) : super(key: key);

//   @override
//   _BtcSendPageState createState() => _BtcSendPageState();
// }

// class _BtcSendPageState extends State<BtcSendPage> {
//   ScrollController? _scroll;

//   @override
//   void initState() {
//     _scroll = ScrollController();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext c) {
//     return BlocConsumer<BtcSendCubit, BtcSendState>(listener: (context, state) {
//       _scroll!.animateTo(0,
//           duration: Duration(milliseconds: 400), curve: Curves.easeInCubic);

//       if (state.submitted) context.read<WalletCubit>().getWallets();
//     }, builder: (context, state) {
//       return WillPopScope(
//         onWillPop: () async {
//           if (state.step == BtcSendSteps.address || state.submitted)
//             return true;

//           c.read<BtcSendCubit>().backClicked();
//           return false;
//         },
//         child: Scaffold(
//             body: GestureDetector(
//           onTap: () {
//             FocusScope.of(c).requestFocus(new FocusNode());
//           },
//           child: SafeArea(
//               child: SingleChildScrollView(
//                   controller: _scroll,
//                   child: AnimatedSwitcher(
//                     duration: Duration(milliseconds: 3),
//                     child: () {
//                       if (state.submitted) return BtcSendComplete();

//                       if (state.submitting)
//                         return Column(children: [
//                           Header(cornerTitle: 'SEND BITCOIN', children: [
//                             HeaderText(text: 'SENDING\nPAYMENT'),
//                           ]),
//                           Loading(text: 'Sending')
//                         ]);

//                       switch (state.step) {
//                         case BtcSendSteps.address:
//                           return BtcSendAddress();
//                         case BtcSendSteps.amount:
//                           return BlocBuilder<BtcSendFeesCubit,
//                                   BtcSendFeesState>(
//                               buildWhen: (previous, current) =>
//                                   previous.fetchingFee
//                                       .not(current.fetchingFee) ||
//                                   previous.fetchFeeError
//                                       .not(current.fetchFeeError),
//                               builder: (context, feeState) {
//                                 return BlocBuilder<BtcSendAmountCubit,
//                                         BtcSendAmountState>(
//                                     builder: (context, amountState) {
//                                   if (feeState.fetchingFee)
//                                     return Column(children: [
//                                       Header(
//                                           cornerTitle: 'SEND BITCOIN',
//                                           children: [
//                                             HeaderText(text: 'Fetching\nFees'),
//                                           ]),
//                                       Loading(text: 'Fetching'),
//                                     ]);
//                                   if (feeState.fetchFeeError != '')
//                                     return Column(children: [
//                                       Header(
//                                           cornerTitle: 'SEND BITCOIN',
//                                           children: [
//                                             BckButton(
//                                                 text: 'BACK',
//                                                 onTapped: () {
//                                                   c
//                                                       .read<BtcSendCubit>()
//                                                       .backClicked();
//                                                 }),
//                                             SizedBox(height: 24),
//                                             HeaderText(
//                                                 text: 'Fetching\nFees Error'),
//                                             SizedBox(height: 8),
//                                             Text(feeState.fetchFeeError,
//                                                 style: c.fonts.caption!
//                                                     .copyWith(
//                                                         color:
//                                                             c.colours.surface)),
//                                             SizedBox(height: 24),
//                                             GestureDetector(
//                                                 onTap: () {
//                                                   c
//                                                       .read<BtcSendFeesCubit>()
//                                                       .fetchFee();
//                                                 },
//                                                 child: Text('Try Again',
//                                                     style: c.fonts.button!
//                                                         .copyWith(
//                                                             color: c.colours
//                                                                 .primaryVariant)))
//                                           ])
//                                     ]);
//                                   return BtcSendAmount();
//                                 });
//                               });
//                         case BtcSendSteps.confirm:
//                           return BtcSendAuth();
//                       }
//                     }(),
//                   ))),
//         )),
//       );
//     });
//   }
// }
