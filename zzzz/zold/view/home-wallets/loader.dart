// import 'package:flutter/material.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/cubit/wallet.dart';
// import 'package:sats/zold/view/common/loading.dart';

// class HomeWalletsLoader extends StatelessWidget {
//   const HomeWalletsLoader({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext c) {
//     return AnimatedSwitcher(
//         duration: Duration(milliseconds: 800),
//         child: BlocBuilder<WalletCubit, WalletState>(
//           builder: (context, state) {
//             final loading = state.loadingWallets;
//             //c.select((WalletBloc bloc) => bloc.state.loadingWallets);

//             if (!loading) return Container();

//             return Loading(text: 'Loading Wallets');
//           },
//         ));
//   }
// }
