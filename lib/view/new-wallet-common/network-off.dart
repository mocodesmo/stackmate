import 'package:flutter/material.dart';
import 'package:sats/cubit/new-wallet/network.dart';
import 'package:sats/cubit/new-wallet/seed-generate.dart';
import 'package:sats/cubit/new-wallet/seed-import.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/header-text.dart';

class SeedNetworkOff extends StatelessWidget {
  const SeedNetworkOff({Key? key, required this.isImport}) : super(key: key);

  final bool isImport;

  @override
  Widget build(BuildContext c) {
    final network = c.select((NetworkCubit c) => c.state);

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      HeaderTextDark(text: 'Turn off all\nnetworking'.notLocalised()),
      SizedBox(height: 16),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              'For maximum security, turn off all\nnetworking on your device.'
                  .notLocalised(),
              style: c.fonts.subtitle2!.copyWith(color: Colors.white))),
      SizedBox(height: 8),
      SizedBox(height: 48),
      NetworkRow(
        isOnline: network.mobileOnline,
        shouldTurnOn: false,
        text: 'Mobile Network',
      ),
      SizedBox(height: 24),
      NetworkRow(
        isOnline: network.wifiOnline,
        shouldTurnOn: false,
        text: 'WiFi Network    ',
      ),
      SizedBox(height: 24),
      NetworkRow(
        isOnline: network.bluetoothOnline,
        shouldTurnOn: false,
        text: 'Bluetooth           ',
      ),
      SizedBox(height: 40),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimatedOpacity(
            opacity: network.hasOffError() != '' ? 0.3 : 1,
            duration: Duration(milliseconds: 500),
            child: TextButton(
                onPressed: () {
                  if (network.hasOffError() != '') return;
                  if (isImport)
                    c.read<SeedImportCubit>().nextClicked();
                  else
                    c.read<SeedGenerateCubit>().nextClicked();
                },
                child: Text('Next'))),
      ),
    ]);
  }
}

class NetworkRow extends StatelessWidget {
  const NetworkRow({
    Key? key,
    required this.isOnline,
    required this.shouldTurnOn,
    required this.text,
  }) : super(key: key);

  final bool isOnline;
  final bool shouldTurnOn;
  final String text;

  @override
  Widget build(BuildContext c) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Text(text,
          textAlign: TextAlign.left,
          style: c.fonts.subtitle2!.copyWith(color: Colors.white)),
      SizedBox(width: 16),
      if (!shouldTurnOn)
        if (isOnline)
          Text('ONLINE'.notLocalised(),
              style: c.fonts.subtitle1!.copyWith(color: c.colours.error))
        else
          Text('OFFLINE'.notLocalised(),
              style: c.fonts.subtitle1!.copyWith(color: Colors.green))
      else if (isOnline)
        Text('ONLINE'.notLocalised(),
            style: c.fonts.subtitle1!.copyWith(color: Colors.green))
      else
        Text('OFFLINE'.notLocalised(),
            style: c.fonts.subtitle1!.copyWith(color: c.colours.error))
    ]);
  }
}
