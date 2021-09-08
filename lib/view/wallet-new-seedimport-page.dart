import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sats/cubit/new-wallet/seed-import.dart';
import 'package:sats/navigation.dart';

import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/back-button2.dart';
import 'package:sats/view/common/header-text.dart';
import 'package:sats/view/common/header.dart';
import 'package:sats/view/common-new-wallet/network-off.dart';
import 'package:sats/view/common-new-wallet/network-on.dart';

class NewImportStepper extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return BlocBuilder<SeedImportCubit, SeedImportState>(
        buildWhen: (previous, current) =>
            previous.currentStep != current.currentStep,
        builder: (context, state) {
          final stepLabel = state.currentStepLabel();
          final steps = SeedImportSteps.values.length;
          final idx = state.currentStep.index;

          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  stepLabel,
                  style: c.fonts.headline6!.copyWith(color: Colors.white),
                ),
                SizedBox(height: 24),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (var i = 0; i < steps; i++)
                        Container(
                          height: 8,
                          width: 40,
                          decoration: BoxDecoration(
                              color: i <= idx
                                  ? Colors.blue.withOpacity(0.4)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                    ]),
                SizedBox(height: 24),
              ]);
        });
  }
}

class SeedImportWarning extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      HeaderTextDark(text: 'Security Information'),
      SizedBox(height: 24),
      Text('''
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
              ''',
          style: c.fonts.caption!.copyWith(
            color: Colors.white,
          )),
      SizedBox(height: 24),
      TextButton(
          onPressed: () {
            c.read<SeedImportCubit>().nextClicked();
          },
          child: Text('I Understand'))
    ]));
  }
}

class SeedImportPassphrase extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return BlocBuilder<SeedImportCubit, SeedImportState>(
        buildWhen: (previous, current) =>
            previous.errPassPhrase != current.errPassPhrase,
        builder: (context, state) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 24),
                HeaderTextDark(text: 'Enter an optional\npassphrase'),
                SizedBox(height: 24),
                Padding(
                    padding: EdgeInsets.all(0),
                    child: TextField(
                        enableSuggestions: false,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        onChanged: (text) {
                          c.read<SeedImportCubit>().passPhraseChanged(text);
                        },
                        decoration: InputDecoration(labelText: 'Passphrase'))),
                SizedBox(height: 40),
                HeaderTextDark(text: 'Select an\naccount number'),
                SizedBox(height: 24),
                Padding(
                    padding: EdgeInsets.all(0),
                    child: TextField(
                        enableSuggestions: false,
                        autocorrect: false,
                        onChanged: (text) {
                          c.read<SeedImportCubit>().accountNumberChanged(text);
                        },
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(labelText: 'Account Number'))),
                SizedBox(height: 40),
                if (state.errPassPhrase != '')
                  Text(state.errPassPhrase,
                      style: c.fonts.caption!.copyWith(color: c.colours.error)),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextButton(
                        onPressed: () {
                          c.read<SeedImportCubit>().nextClicked();
                        },
                        child: Text('Confirm')))
              ]);
        });
  }
}

class SeedImportLabel extends StatefulWidget {
  const SeedImportLabel({Key? key}) : super(key: key);

  @override
  State<SeedImportLabel> createState() => _SeedImportLabelState();
}

class _SeedImportLabelState extends State<SeedImportLabel> {
  TextEditingController? _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<SeedImportCubit, SeedImportState>(
        buildWhen: (previous, current) =>
            previous.walletLabelError != current.walletLabelError,
        builder: (context, state) {
          if (state.walletLabel != _controller!.text)
            _controller!.text = state.walletLabel;

          final isFixed = state.labelFixed;

          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 24),
                if (!isFixed) HeaderTextDark(text: 'Label your wallet'),
                if (isFixed) HeaderTextDark(text: 'Label'),
                SizedBox(height: 24),
                Padding(
                    padding: EdgeInsets.all(0),
                    child: IgnorePointer(
                      ignoring: isFixed,
                      child: TextField(
                          controller: _controller,
                          onChanged: (text) {
                            if (!isFixed)
                              c.read<SeedImportCubit>().labelChanged(text);
                          },
                          decoration: InputDecoration(
                            labelText: 'Wallet Name',
                            labelStyle: TextStyle(color: Colors.transparent),
                          )),
                    )),
                SizedBox(height: 40),
                if (state.walletLabelError != '')
                  Text(state.walletLabelError,
                      style: c.fonts.caption!.copyWith(color: c.colours.error)),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextButton(
                        onPressed: () {
                          c.read<SeedImportCubit>().nextClicked();
                        },
                        child: Text('Confirm')))
              ]);
        });
  }
}

class SeedImportPhrase extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return BlocBuilder<SeedImportCubit, SeedImportState>(
        builder: (context, state) {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        HeaderTextDark(text: 'Enter your seed\nphrase'.notLocalised()),
        SizedBox(height: 24),
        Padding(
            padding: const EdgeInsets.all(0.0),
            child: TextField(
                enableSuggestions: false,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onChanged: (text) {
                  c.read<SeedImportCubit>().seedTextChanged(text);
                },
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: 'Seed Phrase',
                  fillColor: c.colours.surface,
                  errorText: state.seedError.nullIfEmpty(),
                ))),
        SizedBox(height: 24),
        AnimatedOpacity(
          opacity: state.showSeedCompleteButton() ? 1 : 0.3,
          duration: Duration(milliseconds: 300),
          child: TextButton(
              onPressed: () {
                if (state.showSeedCompleteButton())
                  c.read<SeedImportCubit>().nextClicked();
              },
              child: Text('Next')),
        ),
        SizedBox(height: 24),
      ]);
    });
  }
}

class SeedImportPage extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return BlocConsumer<SeedImportCubit, SeedImportState>(
        listenWhen: (previous, current) =>
            previous.currentStep != current.currentStep ||
            previous.newWalletSaved != current.newWalletSaved,
        listener: (context, state) {
          if (state.newWalletSaved) {
            Navigator.pushReplacementNamed(context, Routes.home);
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
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: NewImportStepper()),
                    FadeInLeft(
                      key: Key(state.currentStepLabel()),
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 24),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: c.colours.surface,
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
