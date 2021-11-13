import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sats/cubit/new-wallet/inheritance-timer.dart';
import 'package:sats/navigation.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/back-button.dart';
import 'package:sats/view/common/loading.dart';
import 'package:sats/view/common/log-button.dart';
import 'package:sats/view/common/step-line.dart';
import 'package:sats/view/new-wallet/seed-generate.dart';
import 'package:sats/view/new-wallet/xpub-import.dart';

class InheritanceStepper extends StatelessWidget {
  const InheritanceStepper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<InteritanceTimerCubit, InheritanceTimerState>(
      builder: (context, state) {
        // final stepLabel = state.currentStepLabel();
        final steps = InteritanceTimerWalletSteps.values.length;
        final idx = state.currentStep.index;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text(
            //   stepLabel,
            //   style: c.fonts.headline6!.copyWith(color: Colors.white),
            // ),
            // const SizedBox(height: 24),
            StepLine(length: steps, idx: idx),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}

class InheritanceWalletInfo extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        Text(
          'STEPS'.toUpperCase(),
          style: c.fonts.headline5!.copyWith(
            color: Colors.white,
            // fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          '''

STEPS
STEPS




      ''',
          style: c.fonts.caption!.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 24),
        TextButton(
          onPressed: () {
            c.read<InteritanceTimerCubit>().nextClicked();
          },
          child: Text(
            'I Understand'.toUpperCase().notLocalised(),
          ),
        ),
      ],
    );
  }
}

class TimerSettings extends StatelessWidget {
  const TimerSettings({Key? key}) : super(key: key);

  void _selectDate(BuildContext c, {DateTime? date}) async {
    final dt = await showDatePicker(
      context: c,
      initialDate: date ?? DateTime(2022),
      firstDate: DateTime(2022),
      lastDate: DateTime(3000),
    );

    if (dt != null && dt != date) {
      c.read<InteritanceTimerCubit>().dateSelected(dt);
    }
  }

  @override
  Widget build(BuildContext c) {
    final date = c.select((InteritanceTimerCubit itc) => itc.state.date);
    final err = c.select((InteritanceTimerCubit itc) => itc.state.errDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        if (date == null)
          const Text('No Date Selected')
        else
          Text(date.toString()),
        const SizedBox(height: 24),
        TextButton(
          onPressed: () {
            _selectDate(c, date: date);
          },
          child: const Text(
            'Select Inheritance Unlock Date',
          ),
        ),
        const SizedBox(height: 80),
        if (err != '') ...[
          Text(
            err,
            style: c.fonts.caption!.copyWith(
              color: c.colours.error,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextButton(
          onPressed: () {
            c.read<InteritanceTimerCubit>().nextClicked();
          },
          child: const Text(
            'Confirm',
          ),
        ),
      ],
    );
  }
}

class InheritanceWalletLabel extends StatelessWidget {
  const InheritanceWalletLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<InteritanceTimerCubit, InheritanceTimerState>(
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state.savingWallet,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Text(
                'Label your wallet',
                style: c.fonts.headline4!.copyWith(
                  color: Colors.white,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.zero,
                child: TextField(
                  onChanged: (text) {
                    c.read<InteritanceTimerCubit>().labelChanged(text);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Wallet Name',
                    labelStyle: TextStyle(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              if (state.errSavingWallet != '')
                Text(
                  state.errSavingWallet,
                  style: c.fonts.caption!.copyWith(color: c.colours.error),
                ),
              if (!state.savingWallet)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                    onPressed: () {
                      c.read<InteritanceTimerCubit>().nextClicked();
                    },
                    child: const Text('Confirm'),
                  ),
                )
              else
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Loading(text: 'Saving Wallet'),
                )
            ],
          ),
        );
      },
    );
  }
}

class InheritancePage extends StatefulWidget {
  const InheritancePage({Key? key}) : super(key: key);

  @override
  State<InheritancePage> createState() => _InheritancePageState();
}

class _InheritancePageState extends State<InheritancePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext c) {
    return BlocConsumer<InteritanceTimerCubit, InheritanceTimerState>(
      listenWhen: (previous, current) =>
          previous.currentStep != current.currentStep ||
          previous.newWalletSaved != current.newWalletSaved,
      listener: (context, state) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.bounceIn,
        );

        if (state.newWalletSaved) {
          Navigator.pushReplacementNamed(context, Routes.home);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    // elevation: 2,
                    floating: true,
                    snap: true,
                    forceElevated: innerBoxIsScrolled,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      systemNavigationBarColor: c.colours.onBackground,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                    // leading: const Back(),
                    leadingWidth: 100,
                    toolbarHeight: 64,
                    leading: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Back(),
                    ),

                    actions: [
                      LogButton(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.lightbulb_outline_sharp,
                            size: 32,
                            // color: Colors.blue[400],
                            color: c.colours.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const InheritanceStepper(),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: c.colours.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: () {
                        switch (state.currentStep) {
                          case InteritanceTimerWalletSteps.info:
                            return InheritanceWalletInfo();
                          case InteritanceTimerWalletSteps.settings:
                            return const TimerSettings();
                          case InteritanceTimerWalletSteps.seed:
                            return const SeedGenerateStepSelect();
                          case InteritanceTimerWalletSteps.import:
                            return const XpubFieldsImport();
                          case InteritanceTimerWalletSteps.label:
                            return const InheritanceWalletLabel();
                        }
                      }(),
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
