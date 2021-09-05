import 'package:flutter/material.dart';
import 'package:sats/cubit/new-wallet/xpub-import.dart';
// import 'package:sats/zold/cubit/wallet.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/back-button2.dart';
import 'package:sats/view/common/header.dart';
import 'package:sats/view/new-wallet-xpub-import/import-xpub.dart';
import 'package:sats/view/new-wallet-xpub-import/label.dart';
import 'package:sats/view/new-wallet-xpub-import/stepper.dart';

class XpubImportPage extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return BlocConsumer<XpubImportCubit, XpubImportState>(
        listenWhen: (previous, current) =>
            previous.currentStep != current.currentStep ||
            previous.newWalletSaved != current.newWalletSaved,
        listener: (context, state) {
          if (state.newWalletSaved) {
            // c.read<WalletCubit>().getWallets();
            Navigator.pop(context);
          }
        },
        buildWhen: (previous, current) =>
            previous.currentStep != current.currentStep,
        builder: (context, state) {
          return WillPopScope(
              onWillPop: () async {
                if (!state.canGoBack()) {
                  c.read<XpubImportCubit>().backClicked();
                  return false;
                }

                return true;
              },
              child: Scaffold(
                  backgroundColor: c.colours.onBackground,
                  body: SafeArea(
                      child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                        Header(cornerTitle: 'IMPORT XPUB', children: [
                          BckButton(
                              text: 'EXIT',
                              onTapped: () {
                                if (!state.canGoBack()) {
                                  c.read<XpubImportCubit>().backClicked();
                                  return;
                                }

                                Navigator.pop(c);
                              }),
                          SizedBox(height: 24),
                        ]),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: XPubImportStepper()),
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 24),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8)),
                            child: () {
                              switch (state.currentStep) {
                                case XpubImportStep.import:
                                  return XpubImport();

                                case XpubImportStep.label:
                                  return XpubLabel();
                              }
                            }())
                      ])))));
        });
  }
}
