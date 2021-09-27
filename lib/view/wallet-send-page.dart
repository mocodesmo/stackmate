import 'package:flutter/material.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/back-button.dart';
import 'package:sats/view/common/log-button.dart';

class WalletSendPage extends StatelessWidget {
  const WalletSendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Row(
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
                const SizedBox(height: 40),
                Text(
                  'MyBank1',
                  style: context.fonts.headline5!.copyWith(
                    color: context.colours.onBackground,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Balance'.toUpperCase(),
                  style: context.fonts.overline!.copyWith(
                    color: context.colours.onBackground,
                  ),
                ),
                Text(
                  '1000000' + ' sats',
                  style: context.fonts.headline6!.copyWith(
                    color: context.colours.onBackground,
                  ),
                ),
                Text(
                  '0.03' + ' BTC',
                  style: context.fonts.caption!.copyWith(
                    color: context.colours.onBackground,
                  ),
                ),
                const SizedBox(height: 80),
                Text(
                  'To Address'.toUpperCase(),
                  style: context.fonts.overline!.copyWith(
                    color: context.colours.onBackground,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  style: TextStyle(color: context.colours.onBackground),
                  decoration: InputDecoration(
                    hintText: 'Enter Address'.toUpperCase(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('PASTE'),
                    ),
                    IconButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, Routes.qr);
                      },
                      icon: Icon(
                        Icons.qr_code,
                        size: 32,
                        color: context.colours.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Text(
                  'Amount'.toUpperCase(),
                  style: context.fonts.overline!.copyWith(
                    color: context.colours.onBackground,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  style: TextStyle(color: context.colours.onBackground),
                  decoration: InputDecoration(
                    hintText: 'Enter SATS Amount'.toUpperCase(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '    BTC: 0.08855490',
                      style: context.fonts.caption!.copyWith(
                        color: context.colours.onBackground.withOpacity(0.7),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Empty Wallet'.toUpperCase()),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Text(
                  'Network Fee'.toUpperCase(),
                  style: context.fonts.overline!.copyWith(
                    color: context.colours.onBackground,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Opacity(
                          opacity: 0.6,
                          child: TextButton(
                            onPressed: () {},
                            child: Text('slow'.toUpperCase()),
                          ),
                        ),
                        Text(
                          '~ 30 minutes\n(1.00 sat / vbyte)',
                          textAlign: TextAlign.center,
                          style: context.fonts.caption!.copyWith(
                            fontSize: 10,
                            color:
                                context.colours.onBackground.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text('medium'.toUpperCase()),
                        ),
                        Text(
                          '~ 30 minutes\n(1.00 sat / vbyte)',
                          textAlign: TextAlign.center,
                          style: context.fonts.caption!.copyWith(
                            fontSize: 10,
                            color:
                                context.colours.onBackground.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Opacity(
                          opacity: 0.6,
                          child: TextButton(
                            onPressed: () {},
                            child: Text('Fast'.toUpperCase()),
                          ),
                        ),
                        Text(
                          '~ 30 minutes\n(1.00 sat / vbyte)',
                          textAlign: TextAlign.center,
                          style: context.fonts.caption!.copyWith(
                            fontSize: 10,
                            color:
                                context.colours.onBackground.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                TextField(
                  style: TextStyle(color: context.colours.onBackground),
                  decoration: InputDecoration(
                    hintText: 'Enter custom fee rate'.toUpperCase(),
                  ),
                ),
                const SizedBox(height: 100),
                TextButton(onPressed: () {}, child: const Text('CONFIRM')),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
