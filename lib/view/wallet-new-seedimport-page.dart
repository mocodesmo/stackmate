import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sats/cubit/new-wallet/seed-import.dart';
import 'package:sats/zold/cubit/wallet.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/zold/view/common/back-button.dart';
import 'package:sats/zold/view/common/header.dart';
import 'package:sats/view/new-wallet-common/network-off.dart';
import 'package:sats/view/new-wallet-common/network-on.dart';
import 'package:sats/view/new-wallet-seed-import/import-phrase.dart';
import 'package:sats/view/new-wallet-seed-import/label.dart';
import 'package:sats/view/new-wallet-seed-import/passphrase.dart';
import 'package:sats/view/new-wallet-seed-import/stepper.dart';
import 'package:sats/view/new-wallet-seed-import/warning.dart';

class SeedImportPage extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return BlocConsumer<SeedImportCubit, SeedImportState>(
        listenWhen: (previous, current) =>
            previous.currentStep != current.currentStep ||
            previous.newWalletSaved != current.newWalletSaved,
        listener: (context, state) {
          if (state.newWalletSaved) {
            c.read<WalletCubit>().getWallets();
            Navigator.pop(context);
          }
        },
        buildWhen: (previous, current) =>
            previous.currentStep != current.currentStep,
        builder: (context, state) {
          return WillPopScope(
              onWillPop: () async {
                if (!state.canGoBack()) {
                  c.read<SeedImportCubit>().backClicked();
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
                        Header(cornerTitle: 'IMPORT SEED', children: [
                          BckButton(
                              text: 'EXIT',
                              onTapped: () {
                                if (!state.canGoBack()) {
                                  c.read<SeedImportCubit>().backClicked();
                                  return;
                                }

                                Navigator.pop(c);
                              }),
                          SizedBox(height: 24),
                        ]),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: NewImportStepper()),
                        FadeInLeft(
                          key: Key(state.currentStepLabel()),
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 24),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: () {
                                switch (state.currentStep) {
                                  case SeedImportSteps.warning:
                                    return SeedImportWarning();

                                  case SeedImportSteps.security:
                                    return SeedNetworkOff(isImport: true);

                                  case SeedImportSteps.import:
                                    return SeedImportPhrase();

                                  case SeedImportSteps.passphrase:
                                    return SeedImportPassphrase();

                                  case SeedImportSteps.label:
                                    return SeedImportLabel();

                                  case SeedImportSteps.networkOn:
                                    return SeedNetworkOn(isImport: true);
                                }
                              }()),
                        )
                      ])))));
        });
  }
}
