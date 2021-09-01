import 'package:flutter/material.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/zold/cubit/wallet.dart';

import 'package:sats/zold/view/common/worth-header.dart';
import 'package:sats/zold/view/home-wallets/btc-card.dart';
import 'package:sats/zold/view/home-wallets/loader.dart';
import 'package:sats/zold/view/home-wallets/new-wallet-card.dart';

class HomeWalletsPage extends StatefulWidget {
  const HomeWalletsPage({Key? key}) : super(key: key);

  @override
  _HomeWalletsPageState createState() => _HomeWalletsPageState();
}

class _HomeWalletsPageState extends State<HomeWalletsPage> {
  ScrollController? _scroll;

  @override
  void initState() {
    _scroll = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext c) {
    return BlocListener<WalletCubit, WalletState>(
      listener: (context, state) {
        if (state.loadingWallets)
          _scroll!.animateTo(
            0,
            duration: Duration(milliseconds: 500),
            curve: Curves.linear,
          );
      },
      child: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        WorthHeader(),
        HomeWalletsLoader(),
        Expanded(
            child: RefreshIndicator(
          onRefresh: () async {
            c.read<WalletCubit>().getWallets();
            return;
          },
          child: SingleChildScrollView(
              controller: _scroll,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 24),
                    Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('WALLETS', style: c.fonts.subtitle2)),
                    //SizedBox(height: 16),
                    //HomeWalletsInrCard(),
                    SizedBox(height: 16),
                    HomeWalletsBtcCard(),
                    //SizedBox(height: 16),
                    NewWalletCard(),
                    SizedBox(height: 80),
                  ])),
        ))
      ])),
    );
  }
}
