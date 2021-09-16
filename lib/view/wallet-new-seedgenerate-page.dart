import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sats/cubit/new-wallet/seed-generate.dart';
import 'package:sats/navigation.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/back-button2.dart';
import 'package:sats/view/common/header-text.dart';
import 'package:sats/view/common/header.dart';
import 'package:sats/view/new-wallet/network-off.dart';
import 'package:sats/view/new-wallet/network-on.dart';
import 'package:sats/view/new-wallet/step.dart';

class NewGenerateStepper extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return BlocBuilder<SeedGenerateCubit, SeedGenerateState>(
      buildWhen: (previous, current) =>
          previous.currentStep != current.currentStep,
      builder: (context, state) {
        final stepLabel = state.currentStepLabel();
        final steps = SeedGenerateSteps.values.length;
        final idx = state.currentStep.index;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              stepLabel,
              style: c.fonts.headline6!.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 24),
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
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}

class SeedGenerateWarning extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const HeaderTextDark(text: 'Security Information'),
        const SizedBox(height: 24),
        Text(
          '''
Write down your seed phrase on a piece of paper
and store in a safe place.

Don’t risk losing your funds. protect your wallet
by saving your Seed Phrase in a place you trust.

It’s the only way to recover your wallet if you are 
locked out of the app or get a new device.

For maximum security, you will be forced to turn off
all networking for your device during this process.
      ''',
          style: c.fonts.caption!.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 24),
        TextButton(
          onPressed: () {
            c.read<SeedGenerateCubit>().nextClicked();
          },
          child: Text(
            'I Understand'.notLocalised(),
          ),
        ),
      ],
    );
  }
}

class SeedGeneratePassphrase extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return BlocBuilder<SeedGenerateCubit, SeedGenerateState>(
      buildWhen: (previous, current) =>
          previous.errPassphrase != current.errPassphrase,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const HeaderTextDark(text: 'Enter an\noptional\npassphrase'),
            const SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.zero,
              child: TextField(
                onChanged: (text) {
                  c.read<SeedGenerateCubit>().passPhrasedChanged(text);
                },
                decoration: const InputDecoration(labelText: 'Passphrase'),
              ),
            ),
            const SizedBox(height: 40),
            if (state.errPassphrase != '')
              Text(
                state.errPassphrase,
                style: c.fonts.caption!.copyWith(
                  color: c.colours.error,
                ),
              ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: () {
                  c.read<SeedGenerateCubit>().nextClicked();
                },
                child: const Text('Confirm'),
              ),
            )
          ],
        );
      },
    );
  }
}

class SeedWord extends StatelessWidget {
  const SeedWord({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  final String text;
  final Function? onTap;

  @override
  Widget build(BuildContext c) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (onTap == null) return;
          onTap!();
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: c.colours.secondary,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: c.fonts.subtitle2!.copyWith(
              color: onTap == null ? Colors.white : c.colours.primary,
            ),
          ),
        ),
      ),
    );
  }
}

class SeedGenerate extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    final words = c.select((SeedGenerateCubit c) => c.state.seed);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HeaderTextDark(text: 'Write down your\nseed phrase'.notLocalised()),
          const SizedBox(height: 16),
          Text(
            'Make sure that no one can view,\nwhat you are writing'
                .notLocalised(),
            style: c.fonts.caption!.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (words != null)
                  for (var i = 0; i < words.length; i++)
                    if (i % 2 == 0 && i < 12)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            if (i == 0)
                              SeedWord(text: '1. ' + words[i])
                            else
                              SeedWord(
                                text: (i + 1).toString() + '. ' + words[i],
                              ),
                            const SizedBox(width: 8),
                            SeedWord(
                              text: (i + 2).toString() + '. ' + words[i + 1],
                            )
                          ],
                        ),
                      )
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextButton(
              onPressed: () {
                c.read<SeedGenerateCubit>().nextClicked();
              },
              child: const Text('Next'),
            ),
          ),
          const SizedBox(height: 24)
        ],
      ),
    );
  }
}

class SeedConfirm extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    final answerIdx =
        c.select((SeedGenerateCubit c) => c.state.quizSeedAnswerIdx.toString());

    final completedIdx =
        c.select((SeedGenerateCubit c) => c.state.quizSeedCompleted);

    final words = c.select((SeedGenerateCubit c) => c.state.quizSeedList);

    final error = c.select((SeedGenerateCubit c) => c.state.quizSeedError);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: HeaderTextDark(text: 'Confirm seed\nphrase'),
        ),
        const SizedBox(height: 8),
        Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(width: 2),
          ),
          child: SizedBox(
            height: 88,
            child: Center(
              child: Text(
                answerIdx + '.',
                style: c.fonts.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        if (error != '')
          Center(
            child: Text(
              error,
              style: c.fonts.caption!.copyWith(color: c.colours.error),
            ),
          ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            'Select the correct answer',
            style: c.fonts.subtitle1!.copyWith(color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),
        for (var i = 0; i < words.length; i++)
          if (i % 2 == 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SeedWord(
                  text: words[i],
                  onTap: () {
                    c.read<SeedGenerateCubit>().seedWordSelected(words[i]);
                  },
                ),
                const SizedBox(width: 8),
                SeedWord(
                  text: words[i + 1],
                  onTap: () {
                    c.read<SeedGenerateCubit>().seedWordSelected(words[i + 1]);
                  },
                )
              ],
            ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StepCell(isOn: true, isSelected: true, text: ''),
            StepCell(isOn: completedIdx > 1, isSelected: true, text: ''),
            StepCell(isOn: completedIdx > 2, isSelected: true, text: '')
          ],
        )
      ],
    );
  }
}

class SeedGenerateLabel extends StatelessWidget {
  const SeedGenerateLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<SeedGenerateCubit, SeedGenerateState>(
      buildWhen: (previous, current) =>
          previous.walletLabelError != current.walletLabelError,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const HeaderTextDark(text: 'Name your wallet'),
            const SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.zero,
              child: TextField(
                onChanged: (text) {
                  c.read<SeedGenerateCubit>().labelChanged(text);
                },
                decoration: const InputDecoration(
                  labelText: 'Wallet Name',
                  labelStyle: TextStyle(color: Colors.transparent),
                ),
              ),
            ),
            const SizedBox(height: 40),
            if (state.walletLabelError != '')
              Text(
                state.walletLabelError,
                style: c.fonts.caption!.copyWith(color: c.colours.error),
              ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: () {
                  c.read<SeedGenerateCubit>().nextClicked();
                },
                child: const Text('Confirm'),
              ),
            )
          ],
        );
      },
    );
  }
}

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
        _scrollController!.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.bounceIn,
        );

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
                child: Column(
                  children: [
                    Header(
                      cornerTitle: 'Generate Seed',
                      children: [
                        BckButton(
                          text: 'EXIT',
                          onTapped: () {
                            if (!state.canGoBack()) {
                              c.read<SeedGenerateCubit>().backClicked();
                              return;
                            }

                            Navigator.pop(c);
                          },
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: NewGenerateStepper(),
                    ),
                    FadeInLeft(
                      key: Key(state.currentStepLabel()),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 24,
                        ),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: c.colours.surface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: () {
                          switch (state.currentStep) {
                            case SeedGenerateSteps.warning:
                              return SeedGenerateWarning();

                            case SeedGenerateSteps.security:
                              return const SeedNetworkOff(isImport: false);

                            case SeedGenerateSteps.generate:
                              return SeedGenerate();

                            case SeedGenerateSteps.confirm:
                              return SeedConfirm();

                            case SeedGenerateSteps.passphrase:
                              return SeedGeneratePassphrase();

                            case SeedGenerateSteps.label:
                              return const SeedGenerateLabel();

                            case SeedGenerateSteps.networkOn:
                              return const SeedNetworkOn(isImport: false);
                          }
                        }(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
