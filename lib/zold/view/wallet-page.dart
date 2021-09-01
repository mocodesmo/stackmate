import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sats/zold/cubit/wallet.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/zold/view/wallet/header.dart';
import 'package:sats/zold/view/wallet/info.dart';
import 'package:sats/zold/view/wallet/transaction.dart';

class BtcWalletPage extends StatefulWidget {
  const BtcWalletPage({Key? key}) : super(key: key);

  @override
  _BtcWalletPageState createState() => _BtcWalletPageState();
}

class _BtcWalletPageState extends State<BtcWalletPage> {
  bool isHistory = true;

  @override
  Widget build(BuildContext c) {
    return WillPopScope(
        onWillPop: () async {
          c.read<WalletCubit>().clearSelectedWallet();
          return true;
        },
        child: Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
              BtcWalletHeader(),
              SizedBox(height: 16),
              Row(children: [
                SizedBox(width: 16),
                if (isHistory) ...[
                  TextButton(
                      onPressed: () {},
                      child: Text('HISTORY',
                          style: c.fonts.subtitle2!
                              .copyWith(fontWeight: FontWeight.bold))),
                  SizedBox(width: 16),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          isHistory = false;
                        });
                      },
                      child: Text('INFO', style: c.fonts.subtitle2))
                ] else ...[
                  TextButton(
                      onPressed: () {
                        setState(() {
                          isHistory = true;
                        });
                      },
                      child: Text('HISTORY', style: c.fonts.subtitle2)),
                  SizedBox(width: 16),
                  TextButton(
                      onPressed: () {},
                      child: Text('INFO',
                          style: c.fonts.subtitle2!
                              .copyWith(fontWeight: FontWeight.bold)))
                ]
              ]),
              SizedBox(height: 8),
              if (isHistory)
                FadeIn(
                    duration: Duration(milliseconds: 800),
                    child: Transactions())
              else
                FadeIn(
                    duration: Duration(milliseconds: 800), child: WalletInfo())
            ])))));
  }
}
