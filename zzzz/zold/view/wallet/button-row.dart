import 'package:flutter/material.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/zold/cubit/wallet.dart';

class BtcWalletButtonRow extends StatelessWidget {
  const BtcWalletButtonRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        child:
            BlocBuilder<WalletCubit, WalletState>(builder: (context, wstate) {
          if (wstate.selectedWallet!.watchOnly) return Container();

          final balances = wstate.selectedWallet!.balances;

          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/btc-receive');
                  },
                  child: Column(children: [
                    Icon(Icons.keyboard_arrow_down_rounded,
                        color: c.colours.primary, size: 40),
                    Text('Receive'.notLocalised(),
                        style:
                            c.fonts.button!.copyWith(color: c.colours.primary))
                  ]),
                ),
                Container(height: 32, width: 1, color: c.colours.background),
                if (!balances.zeroBalance())
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/btc-send');
                      },
                      child: Column(children: [
                        Icon(Icons.keyboard_arrow_up_rounded,
                            color: c.colours.primary, size: 40),
                        Text('Send'.notLocalised(),
                            style: c.fonts.button!
                                .copyWith(color: c.colours.primary))
                      ]))
                else
                  Column(children: [
                    Icon(Icons.keyboard_arrow_up_rounded,
                        color: c.colours.primary, size: 40),
                    Text('Send'.notLocalised(),
                        style:
                            c.fonts.button!.copyWith(color: c.colours.primary))
                  ])
              ]);
        }));
  }
}
