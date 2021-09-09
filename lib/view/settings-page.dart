import 'package:flutter/material.dart';
import 'package:sats/cubit/wallet/blockchain.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/back-button.dart';
import 'package:sats/view/common/header.dart';
import 'package:sats/model/blockchain.dart';

class BlockchainRow extends StatelessWidget {
  const BlockchainRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    final blockchain = c.select((BlockchainCubit b) => b.state.blockchain);
    return ElevatedButton(
        onPressed: () {
          if (blockchain == Blockchain.mainNet)
            c.read<BlockchainCubit>().changeBlockchain(Blockchain.testNet);
          else
            c.read<BlockchainCubit>().changeBlockchain(Blockchain.mainNet);
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          primary: c.colours.surface,
        ),
        child: Container(
            height: 100,
            padding: EdgeInsets.only(left: 0, top: 16, bottom: 16, right: 0),
            child: Row(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Change Blockchain Network',
                      style: c.fonts.button!.copyWith(
                        color: c.colours.primary,
                        fontSize: 16,
                      )),
                  SizedBox(height: 4),
                  Container(
                    // width: 240,
                    child: Text(
                        'Only wallets from selected network will be displayed\n\nCurrent network: ' +
                            blockchain.displayName.toUpperCase(),
                        maxLines: 3,
                        style: c.fonts.caption!.copyWith(
                          color: c.colours.onSurface.withOpacity(0.7),
                        )),
                  ),
                ]),
                Spacer(),
              ],
            )));
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Header(cornerTitle: 'STACKMATE', children: [
              SizedBox(height: 8),
              Back(),
              SizedBox(height: 60),
              Text(' Settings'.toUpperCase(),
                  style: c.fonts.headline4!.copyWith(
                    color: Colors.white,
                  )),
              SizedBox(height: 48),
            ]),
            BlockchainRow(),
          ],
        ),
      ),
    );
  }
}
