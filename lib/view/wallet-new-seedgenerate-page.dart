import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sats/cubit/new-wallet/seed-generate.dart';
// import 'package:sats/zold/cubit/wallet.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/back-button.dart';
import 'package:sats/view/common/back-button2.dart';
import 'package:sats/view/common/header.dart';
import 'package:sats/view/new-wallet-common/network-on.dart';
import 'package:sats/view/new-wallet-common/network-off.dart';
import 'package:sats/view/new-wallet-seed-generate/confirm.dart';
import 'package:sats/view/new-wallet-seed-generate/generate.dart';
import 'package:sats/view/new-wallet-seed-generate/label.dart';
import 'package:sats/view/new-wallet-seed-generate/passphrase.dart';
import 'package:sats/view/new-wallet-seed-generate/stepper.dart';
import 'package:sats/view/new-wallet-seed-generate/warning.dart';

class SeedGeneratePage extends StatefulWidget {
  @override
  _SeedGeneratePageState createState() => _SeedGeneratePageState();
}

class _SeedGeneratePageState extends State<SeedGeneratePage> {
  ScrollController? _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext c) {
    return BlocConsumer<SeedGenerateCubit, SeedGenerateState>(
        listenWhen: (previous, current) =>
            previous.currentStep != current.currentStep ||
            previous.newWalletSaved != current.newWalletSaved,
        listener: (context, state) {
          _scrollController!.animateTo(0,
              duration: Duration(milliseconds: 300), curve: Curves.bounceIn);

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
                  c.read<SeedGenerateCubit>().backClicked();
                  return false;
                }
                return true;
              },
              child: Scaffold(
                  backgroundColor: c.colours.secondary,
                  body: SafeArea(
                      child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(children: [
                            Header(cornerTitle: 'Generate Seed', children: [
                              BckButton(
                                  text: 'EXIT',
                                  onTapped: () {
                                    if (!state.canGoBack()) {
                                      c.read<SeedGenerateCubit>().backClicked();
                                      return;
                                    }

                                    Navigator.pop(c);
                                  }),
                              SizedBox(height: 24),
                            ]),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0),
                                child: NewGenerateStepper()),
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
                                      case SeedGenerateSteps.warning:
                                        return SeedGenerateWarning();

                                      case SeedGenerateSteps.security:
                                        return SeedNetworkOff(isImport: false);

                                      case SeedGenerateSteps.generate:
                                        return SeedGenerate();

                                      case SeedGenerateSteps.confirm:
                                        return SeedConfirm();

                                      case SeedGenerateSteps.passphrase:
                                        return SeedGeneratePassphrase();

                                      case SeedGenerateSteps.label:
                                        return SeedGenerateLabel();

                                      case SeedGenerateSteps.networkOn:
                                        return SeedNetworkOn(isImport: false);
                                    }
                                  }()),
                            )
                          ])))));
        });
  }
}
