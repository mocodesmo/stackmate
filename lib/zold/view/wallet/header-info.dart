import 'package:flutter/material.dart';
import 'package:sats/zold/model/wallet-solo.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/pkg/validation.dart';

class HeaderInfo extends StatelessWidget {
  const HeaderInfo({
    Key? key,
    required this.wallet,
  }) : super(key: key);

  final SoloWallet wallet;

  @override
  Widget build(BuildContext c) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('BALANCE'.notLocalised(),
            style: c.fonts.overline!.copyWith(color: c.colours.surface)),
        Text(
            Validation.addCommas(wallet.balances.confirmed.toString()) +
                ' sats',
            style: c.fonts.headline5!.copyWith(color: c.colours.surface)),
        Text(' ' + wallet.balances.confirmedToBtc() + ' BTC',
            style: c.fonts.caption!
                .copyWith(color: c.colours.surface.withAlpha(200)))
      ])),
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        //Text('WALLET'.notLocalised(),
        //    style: c.fonts.overline!.copyWith(color: c.colours.surface)),
        Text(wallet.nickname,
            style: c.fonts.headline6!.copyWith(color: c.colours.surface)),
        Text(wallet.time(),
            style: c.fonts.caption!
                .copyWith(color: c.colours.surface.withAlpha(200)))
      ]),
    ]);
  }
}

class WatchOnlyHeaderRow extends StatelessWidget {
  const WatchOnlyHeaderRow({Key? key, required this.wallet}) : super(key: key);

  final SoloWallet wallet;

  @override
  Widget build(BuildContext c) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('INFO'.notLocalised(),
              style: c.fonts.overline!.copyWith(color: c.colours.surface)),
          Text(
              'This wallet is ‘Watch Only’\nImport seed for full access’'
                  .notLocalised(),
              style: c.fonts.caption!.copyWith(color: c.colours.surface))
        ]),
        Container(height: 32, width: 1, color: c.colours.background),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(c, '/seed-import-label');
          },
          child: Column(children: [
            Icon(Icons.keyboard_arrow_down_rounded,
                color: c.colours.primary, size: 40),
            Text('Import Seed'.notLocalised(),
                style: c.fonts.button!.copyWith(color: c.colours.primary))
          ]),
        ),
      ],
    );
  }
}
