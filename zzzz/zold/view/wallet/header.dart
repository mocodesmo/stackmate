import 'package:flutter/material.dart';
import 'package:sats/zold/cubit/wallet-history.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/pkg/validation.dart';
import 'package:sats/zold/view/wallet/button-row.dart';
import 'package:sats/zold/view/wallet/header-info.dart';
import 'package:sats/zold/view/common/back-button.dart';
import 'package:sats/zold/view/common/header.dart';
import 'package:sats/zold/cubit/wallet.dart';
import 'package:sats/zold/view/common/loading.dart';

class BtcWalletHeader extends StatelessWidget {
  const BtcWalletHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<WalletHistoryCubit, WalletHistoryState>(
        buildWhen: (previous, current) =>
            previous.loadingHistory.not(current.loadingHistory),
        builder: (context, hstate) {
          return BlocBuilder<WalletCubit, WalletState>(
              builder: (context, wstate) {
            final wallet = wstate.selectedWallet;
            if (wallet == null) return Container();

            final loading = wstate.loadingWallets || hstate.loadingHistory;
            final balances = wstate.selectedWallet!.balances;

            return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Header(cornerTitle: 'WALLET'.notLocalised(), children: [
                    BckButton(
                        text: 'BACK',
                        onTapped: () {
                          Navigator.pop(c);
                        }),
                    SizedBox(height: 16),
                    //SizedBox(height: 16),
                    HeaderInfo(wallet: wallet),
                    SizedBox(height: 16),
                    if (balances.hasUnconfirmed()) ...[
                      SizedBox(height: 8),
                      Text('UNCONFIRMED BALANCE'.notLocalised(),
                          style: c.fonts.overline!
                              .copyWith(color: c.colours.surface)),
                      Text(
                          Validation.addCommas(
                                balances.unconfirmed.toString(),
                              ) +
                              ' sats',
                          style: c.fonts.headline5!
                              .copyWith(color: c.colours.surface)),
                      Text(' ' + balances.unconfirmedToBtc() + ' BTC',
                          style: c.fonts.caption!.copyWith(
                              color: c.colours.surface.withAlpha(200))),
                      SizedBox(height: 8),
                    ],
                    if (!wallet.watchOnly)
                      BtcWalletButtonRow()
                    else
                      WatchOnlyHeaderRow(wallet: wallet)
                  ]),
                  if (loading) Loading(text: 'Loading History')
                ]);
          });
        });
  }
}
