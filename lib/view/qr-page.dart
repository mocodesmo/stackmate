import 'package:flutter/material.dart';
import 'package:sats/cubit/wallet/wallets.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/back-button.dart';
import 'package:sats/view/common/log-button.dart';
import 'package:sats/view/home-page.dart';

class AccountsRowSelection extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    final wallets = c.select((WalletsCubit w) => w.state.wallets);
    if (wallets.isEmpty)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 66),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'No\nwallets\nadded',
              style: c.fonts.caption!.copyWith(
                color: c.colours.onBackground,
              ),
            ),
          ),
        ],
      );
    return Container(
      width: c.width,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 16),
            for (var w in wallets) WalletCard(wallet: w),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}

class QRPage extends StatelessWidget {
  const QRPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Back(),
                    LogButton(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.lightbulb_outline_sharp,
                          size: 32,
                          color: context.colours.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'select account'.toUpperCase(),
                  style: context.fonts.overline!.copyWith(
                    color: context.colours.onBackground,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AccountsRowSelection(),
              const SizedBox(height: 40),
              Center(
                child: Text(
                  'select action'.toUpperCase(),
                  style: context.fonts.overline!.copyWith(
                    color: context.colours.onBackground,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Opacity(
                opacity: 0.5,
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('receive'.toUpperCase()),
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () {},
                      child: Text('send'.toUpperCase()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
