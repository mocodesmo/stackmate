import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sats/cubit/wallet/receive.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/back-button.dart';
import 'package:sats/view/common/header.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QR extends StatelessWidget {
  const QR({
    Key? key,
    required this.address,
  }) : super(key: key);

  final String address;

  @override
  Widget build(BuildContext c) {
    return Center(
      child: Container(
        width: c.width * 0.7,
        height: c.width * 0.7,
        color: c.colours.onBackground,
        child: QrImage(
          data: address,
          version: QrVersions.auto,
        ),
      ),
    );
  }
}

class TextAddress extends StatelessWidget {
  const TextAddress({
    Key? key,
    required this.address,
  }) : super(key: key);

  final String address;
  @override
  Widget build(BuildContext c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: c.width / 3,
            child: Text(address,
                style: c.fonts.caption!.copyWith(
                  color: c.colours.onBackground,
                ))),
        TextButton(
            onPressed: () {
              c.read<ReceiveCubit>().copyAddress(address);
            },
            child: Text('COPY')),
        SizedBox(height: 48),
        SizedBox(
          width: c.width / 4,
          child: TextButton(
            onPressed: () {
              c.read<ReceiveCubit>().shareAddress(address);
            },
            child: Text(
              'SHARE'.notLocalised(),
            ),
          ),
        )
      ],
    );
  }
}

class ReceivePage extends StatelessWidget {
  const ReceivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    final state = c.select((ReceiveCubit h) => h.state);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (state.loadingAddress) LinearProgressIndicator(),
            Header(cornerTitle: 'STACKMATE', children: [
              SizedBox(height: 8),
              Back(),
              SizedBox(height: 60),
              Text(' RECEIVE',
                  style: c.fonts.headline4!.copyWith(
                    color: Colors.white,
                  )),
              SizedBox(height: 48),
            ]),
            if (state.address != null) ...[
              FadeIn(
                  delay: Duration(milliseconds: 400),
                  child: QR(address: state.address!)),
              SizedBox(height: 24),
              FadeIn(
                  delay: Duration(milliseconds: 800),
                  child: TextAddress(address: state.address!)),
              SizedBox(height: 48),
            ]
          ],
        ),
      )),
    );
  }
}
