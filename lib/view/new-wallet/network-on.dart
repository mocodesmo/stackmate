import 'package:flutter/material.dart';
import 'package:sats/cubit/new-wallet/network.dart';
import 'package:sats/cubit/new-wallet/seed-generate.dart';
import 'package:sats/cubit/new-wallet/seed-import.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/header-text.dart';
import 'package:sats/view/common/loading.dart';
import 'package:sats/view/new-wallet/network-off.dart';

class ImportSaveButton extends StatelessWidget {
  const ImportSaveButton({
    Key? key,
    required this.hasOnError,
  }) : super(key: key);

  final bool hasOnError;

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<SeedImportCubit, SeedImportState>(
        builder: (context, state) {
      if (state.savingWallet)
        return Padding(
            padding: EdgeInsets.all(16), child: Loading(text: 'Saving'));

      if (state.newWalletSaved) return Container();

      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: AnimatedOpacity(
                opacity: hasOnError ? 0.3 : 1,
                duration: Duration(milliseconds: 500),
                child: TextButton(
                    onPressed: () {
                      if (hasOnError) return;
                      c.read<SeedImportCubit>().nextClicked();
                    },
                    child: Text('Done')))),
        SizedBox(height: 8),
        if (state.savingWalletError != '')
          Text(state.savingWalletError,
              style: c.fonts.caption!.copyWith(color: c.colours.error))
      ]);
    });
  }
}

class GenerateSaveButton extends StatelessWidget {
  const GenerateSaveButton({
    Key? key,
    required this.hasOnError,
  }) : super(key: key);

  final bool hasOnError;

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<SeedGenerateCubit, SeedGenerateState>(
        builder: (context, state) {
      if (state.savinngWallet)
        return Padding(
            padding: EdgeInsets.all(16), child: Loading(text: 'Saving'));

      if (state.newWalletSaved) return Container();

      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: AnimatedOpacity(
                opacity: hasOnError ? 0.3 : 1,
                duration: Duration(milliseconds: 500),
                child: TextButton(
                    onPressed: () {
                      if (hasOnError) return;
                      c.read<SeedGenerateCubit>().nextClicked();
                    },
                    child: Text('Done')))),
        SizedBox(height: 8),
        if (state.savingWalletError != '')
          Text(state.savingWalletError,
              style: c.fonts.caption!.copyWith(color: c.colours.error))
      ]);
    });
  }
}

class SeedNetworkOn extends StatelessWidget {
  const SeedNetworkOn({Key? key, required this.isImport}) : super(key: key);

  final bool isImport;

  @override
  Widget build(BuildContext c) {
    final network = c.select((NetworkCubit c) => c.state);

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      HeaderTextDark(text: 'Turn on\nnetworking'.notLocalised()),
      SizedBox(height: 16),
      Padding(
          padding: const EdgeInsets.all(0.0),
          child: Text(
              'For maximum security, turn off all\nnetworking on your device.'
                  .notLocalised(),
              style: c.fonts.subtitle2!.copyWith(
                color: Colors.white,
              ))),
      SizedBox(height: 40),
      NetworkRow(
        isOnline: network.mobileOnline,
        shouldTurnOn: true,
        text: 'Mobile Network',
      ),
      SizedBox(height: 24),
      NetworkRow(
        isOnline: network.wifiOnline,
        shouldTurnOn: true,
        text: 'WiFi Network    ',
      ),
      SizedBox(height: 32),
      if (isImport)
        ImportSaveButton(hasOnError: network.hasOnError() != '')
      else
        GenerateSaveButton(hasOnError: network.hasOnError() != ''),
      SizedBox(height: 16)
    ]);
  }
}
