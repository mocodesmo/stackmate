import 'package:flutter/material.dart';
import 'package:sats/cubit/new-wallet/seed-generate.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/zold/view/common/header-text.dart';

class SeedGenerateWarning extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      HeaderTextDark(text: 'Security Information'),
      SizedBox(height: 24),
      Text('''
Write down your seed phrase on a piece of paper
and store in a safe place.

Don’t risk losing your funds. protect your wallet
by saving your Seed Phrase in a place you trust.

It’s the only way to recover your wallet if you are 
locked out of the app or get a new device.

For maximum security, you will be forced to turn off
all networking for your device during this process.
      ''', style: c.fonts.caption!.copyWith(color: Colors.white)),
      SizedBox(height: 24),
      TextButton(
          onPressed: () {
            c.read<SeedGenerateCubit>().nextClicked();
          },
          child: Text('I Understand'.notLocalised())),
    ]);
  }
}
