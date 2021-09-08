import 'package:flutter/material.dart';
import 'package:sats/cubit/new-wallet/xpub-import.dart';
import 'package:sats/navigation.dart';

import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/back-button2.dart';
import 'package:sats/view/common/header-text.dart';
import 'package:sats/view/common/header.dart';
import 'package:sats/view/common/loading.dart';

class XPubImportStepper extends StatelessWidget {
  const XPubImportStepper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<XpubImportCubit, XpubImportState>(
      builder: (context, state) {
        final stepLabel = state.currentStepLabel();
        final steps = XpubImportStep.values.length;
        final idx = state.currentStep.index;

        return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                stepLabel,
                style: c.fonts.headline6!.copyWith(color: Colors.white),
              ),
              SizedBox(height: 24),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                for (var i = 0; i < steps; i++)
                  Container(
                    height: 8,
                    width: 130,
                    decoration: BoxDecoration(
                        color: i <= idx
                            ? Colors.blue.withOpacity(0.4)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                  ),
              ]),
              SizedBox(height: 24),
            ]);
      },
    );
  }
}

class XpubImport extends StatefulWidget {
  const XpubImport({Key? key}) : super(key: key);

  @override
  _XpubImportState createState() => _XpubImportState();
}

class _XpubImportState extends State<XpubImport> {
  TextEditingController? _xpubController;
  TextEditingController? _fingerPrintController;
  TextEditingController? _pathController;

  @override
  void initState() {
    _xpubController = TextEditingController();
    _fingerPrintController = TextEditingController();
    _pathController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<XpubImportCubit, XpubImportState>(
        builder: (context, state) {
      if (_xpubController!.text != state.xpub)
        _xpubController!.text = state.xpub;

      if (_fingerPrintController!.text != state.fingerPrint)
        _fingerPrintController!.text = state.fingerPrint;

      if (_pathController!.text != state.path)
        _pathController!.text = state.path;

      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SizedBox(height: 24),
        HeaderTextDark(text: 'Enter your XPub'),
        SizedBox(height: 24),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(children: [
              Expanded(
                  child: Text('ADDRESS'.notLocalised(),
                      style: c.fonts.overline!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ))),
              TextButton(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text('SCAN'),
                  ),
                  onPressed: () {
                    c.read<XpubImportCubit>().toggleCamera();
                  })
            ])),
        Padding(
            padding: EdgeInsets.all(0),
            child: TextField(
              controller: _xpubController,
              maxLines: 4,
              onChanged: (text) {
                c.read<XpubImportCubit>().xpubChanged(text);
              },
            )),
        SizedBox(height: 8),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    onTap: () {
                      c.read<XpubImportCubit>().xpubPasteClicked();
                    },
                    child: Text('PASTE'.notLocalised(),
                        style: c.fonts.button!
                            .copyWith(color: c.colours.primary))))),
        SizedBox(height: 40),
        if (state.showOtherDetails()) ...[
          Text('Fingerprint'.toUpperCase().notLocalised(),
              style: c.fonts.overline!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          SizedBox(height: 8),
          Padding(
              padding: EdgeInsets.all(0),
              child: TextField(
                controller: _fingerPrintController,
                onChanged: (text) {
                  c.read<XpubImportCubit>().fingerPrintChanged(text);
                },
              )),
          SizedBox(height: 8),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () {
                        c.read<XpubImportCubit>().fingerPrintPastedClicked();
                      },
                      child: Text('PASTE'.notLocalised(),
                          style: c.fonts.button!
                              .copyWith(color: c.colours.primary))))),
          SizedBox(height: 40),
          Text('Path'.toUpperCase().notLocalised(),
              style: c.fonts.overline!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          SizedBox(height: 8),
          Padding(
              padding: EdgeInsets.all(0),
              child: TextField(
                controller: _pathController,
                onChanged: (text) {
                  c.read<XpubImportCubit>().pathChanged(text);
                },
              )),
          SizedBox(height: 8),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () {
                        c.read<XpubImportCubit>().pathPasteClicked();
                      },
                      child: Text('PASTE'.notLocalised(),
                          style: c.fonts.button!
                              .copyWith(color: c.colours.primary))))),
          SizedBox(height: 40),
        ],
        if (state.errXpub != '')
          Text(state.errXpub,
              style: c.fonts.caption!.copyWith(color: c.colours.error)),
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
                onPressed: () {
                  c.read<XpubImportCubit>().nextClicked();
                },
                child: Text('CONFIRM')))
      ]);
    });
  }
}

class XpubLabel extends StatelessWidget {
  const XpubLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<XpubImportCubit, XpubImportState>(
        builder: (context, state) {
      return IgnorePointer(
        ignoring: state.savingWallet,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SizedBox(height: 24),
          HeaderTextDark(text: 'Label your wallet'),
          SizedBox(height: 24),
          Padding(
              padding: EdgeInsets.all(0),
              child: TextField(
                  onChanged: (text) {
                    c.read<XpubImportCubit>().labelChanged(text);
                  },
                  decoration: InputDecoration(
                      labelText: 'Wallet Name',
                      labelStyle: TextStyle(color: Colors.transparent)))),
          SizedBox(height: 40),
          if (state.errSavingWallet != '')
            Text(state.errSavingWallet,
                style: c.fonts.caption!.copyWith(color: c.colours.error)),
          if (!state.savingWallet)
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                    onPressed: () {
                      c.read<XpubImportCubit>().nextClicked();
                    },
                    child: Text('Confirm')))
          else
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Loading(text: 'Saving Wallet'))
        ]),
      );
    });
  }
}

class XpubImportPage extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return BlocConsumer<XpubImportCubit, XpubImportState>(
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
                  c.read<XpubImportCubit>().backClicked();
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
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: XPubImportStepper()),
                    Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: c.colours.surface,
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
