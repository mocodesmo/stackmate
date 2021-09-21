import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:sats/navigation.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/back-button.dart';
import 'package:sats/view/common/log-button.dart';

class HeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        // right: 0,
        top: 8,
        bottom: 32,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Back(),
              const SizedBox(height: 60),
              Text(
                ' Select Wallet'.toUpperCase(),
                style: c.fonts.headline4!.copyWith(
                  color: Colors.white,
                  // color: Colors.blue[400],
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
          const Spacer(),
          LogButton(
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.lightbulb_outline_sharp,
                size: 32,
                // color: Colors.blue[400],
                color: c.colours.primary,
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}

class WalletSelection extends StatelessWidget {
  const WalletSelection({
    Key? key,
    required this.text,
    required this.description,
    required this.colour,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final String description;
  final Color colour;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        // borderRadius: BorderRadius.circular(8),
        // shadowColor: Colors.,
        // color: colour,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        primary: colour,
      ),
      child: Container(
        height: 100,
        padding: const EdgeInsets.only(
          // left: 0,
          top: 16,
          bottom: 16,
          // right: 0,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: context.fonts.button!.copyWith(
                    color: context.colours.primary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 240,
                  // height: 45,
                  child: Text(
                    description,
                    maxLines: 3,
                    // softWrap: true,
                    // overflow: TextOverflow.fade,
                    style: context.fonts.caption!.copyWith(
                      color: context.colours.onSurface.withOpacity(0.7),
                      // fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.navigate_next_sharp,
              size: 40,
              color: context.colours.primary,
            ),
          ],
        ),
      ),
    );
  }
}

const lorem =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';

class AddWalletPage extends StatelessWidget {
  const AddWalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // SizedBox(height: 48),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child:
              HeaderRow(),
              // ),
              // SizedBox(height: 32),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'SIGNLE SIGNATURE',
                  style: c.fonts.overline!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              WalletSelection(
                text: 'Generate Seed',
                description: lorem,
                colour: c.colours.surface,
                onPressed: () {
                  Navigator.pushNamed(c, Routes.generateSeed);
                },
              ),
              const SizedBox(height: 16),
              WalletSelection(
                text: 'Import Seed',
                description: lorem,
                colour: c.colours.surface,
                onPressed: () {
                  Navigator.pushNamed(c, Routes.importSeed);
                },
              ),
              const SizedBox(height: 16),
              WalletSelection(
                text: 'Import Watch-only Wallet',
                description: lorem,
                colour: c.colours.surface,
                onPressed: () {
                  Navigator.pushNamed(c, Routes.watchOnly);
                },
              ),
              const SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Coming soon'.toUpperCase(),
                  style: c.fonts.overline!.copyWith(
                    color: c.colours.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Opacity(
                opacity: 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'MULTI SIGNATURE',
                        style: c.fonts.overline!.copyWith(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    WalletSelection(
                      text: 'Raft Policy',
                      description: lorem,
                      colour: c.colours.surface,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 16),
                    WalletSelection(
                      text: 'Corporate Settings',
                      description: lorem,
                      colour: c.colours.surface,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }
}
