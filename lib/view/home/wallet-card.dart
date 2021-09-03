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
            shadowColor: Colors.white24,
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  height: 180,
                  width: 150,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.centerRight,
                          stops: [
                        0.3,
                        0.99
                      ],
                          colors: [
                        Colors.blue[300]!.withOpacity(0.5),
                        Colors.teal[100]!.withOpacity(0.5)
                      ])),
                  child: Text(wallet.label, style: context.fonts.headline4),
                ))));
  }
}
