import 'package:flutter/material.dart';
import 'package:sats/pkg/extensions.dart';

class NewWalletCard extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
            color: c.colours.onBackground,
            borderRadius: BorderRadius.circular(16),
            elevation: 4,
            child: Container(
                width: c.width - 32,
                height: c.width * 0.55,
                padding: EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('NEW WALLET'.notLocalised(),
                          style: c.fonts.subtitle1!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: c.colours.background)),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(right: 32),
                        child: Text(
                            'Generate a new wallet, import from existing seed or\nimport an xpub to watch your wallet.'
                                .notLocalised(),
                            style: c.fonts.caption!
                                .copyWith(color: c.colours.background)),
                      ),
                      Spacer(),
                      //Center(
                      //    child: Text('Full Wallet',
                      //        style: c.fonts.subtitle1!
                      //            .copyWith(color: c.colours.background))),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(c, '/seed-generate');
                                },
                                child: Text('GENERATE'.notLocalised(),
                                    style: c.fonts.button!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: c.colours.primary))),
                            Container(
                                width: 1,
                                height: 24,
                                color: c.colours.background),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(c, '/seed-import');
                                },
                                child: Text('IMPORT SEED'.notLocalised(),
                                    style: c.fonts.button!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: c.colours.primary))),
                            Container(
                                width: 1,
                                height: 24,
                                color: c.colours.background),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(c, '/import-xpub');
                                },
                                child: Text('IMPORT XPUB'.notLocalised(),
                                    style: c.fonts.button!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: c.colours.primary))),
                          ]),
                      SizedBox(height: 16)
                    ]))));
  }
}
