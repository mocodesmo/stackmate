import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/pkg/extensions.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({
    Key? key,
    required this.wallet,
  }) : super(key: key);

  final Wallet wallet;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Material(
            elevation: 4,
            // shadowColor: Colors.white24,
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: context.colours.background,
            child: BackdropFilter(
                // blendMode: BlendMode.srcOut,
                filter: ImageFilter.blur(
                    sigmaX: 0, sigmaY: 0, tileMode: TileMode.mirror),
                child: Container(
                  height: 180,
                  width: 150,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.centerRight,
                          stops: [
                        0.3,
                        0.99
                      ],
                          colors: [
                        context.colours.surface,
                        context.colours.surface,
                        // m.withOpacity(0.5),

                        // Colors.sir!.withOpacity(0.5),
                        // Colors.teal[900]!.withOpacity(0.5)
                      ])),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        wallet.label,
                        style: context.fonts.caption!.copyWith(
                          color: context.colours.onBackground,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        wallet.descriptor,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                        style: context.fonts.caption!.copyWith(
                            color: context.colours.onBackground, fontSize: 8),
                      ),
                    ],
                  ),
                ))));
  }
}
