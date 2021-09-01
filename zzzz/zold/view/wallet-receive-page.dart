import 'package:flutter/material.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/zold/view/wallet-receive/addresses.dart';
import 'package:sats/zold/view/wallet-receive/generate-address.dart';
import 'package:sats/zold/view/common/back-button.dart';
import 'package:sats/zold/view/common/header-text.dart';
import 'package:sats/zold/view/common/header.dart';

class BtcReceivePage extends StatelessWidget {
  BtcReceivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    //final loadingWallet = c.select((WalletCubit b) => b.state.loadingWallets);

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(children: [
        Header(cornerTitle: 'RECEIVE\nBITCOIN'.notLocalised(), children: [
          BckButton(
              text: 'BACK',
              onTapped: () {
                Navigator.pop(c);
              }),
          SizedBox(height: 24),
          HeaderText(text: 'Select a\ntype of address'),
        ]),
        SizedBox(height: 2),
        GenerateAddressSection(),
        //SizedBox(height: 16),
        //if (loadingWallet) ...[
        //  SizedBox(height: 16),
        //  Loading(text: 'Loading Wallets . .'),
        //] else
        BtcReceieveAddresses(),
      ]),
    )));
  }
}
