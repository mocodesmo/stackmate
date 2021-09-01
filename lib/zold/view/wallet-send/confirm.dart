import 'package:flutter/material.dart';
import 'package:sats/zold/cubit/btc-send/address.dart';
import 'package:sats/zold/cubit/btc-send/fee.dart';
import 'package:sats/zold/cubit/user.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/zold/cubit/btc-send/amount.dart';
import 'package:sats/zold/cubit/btc-send/send.dart';
import 'package:sats/zold/cubit/btc-send/confirm.dart';
import 'package:sats/zold/view/common/back-button.dart';
import 'package:sats/zold/view/common/header-text.dart';
import 'package:sats/zold/view/common/header.dart';
import 'package:sats/zold/view/common/pin-row.dart';
import 'package:sats/zold/view/security-tfa/open-auth-button.dart';

class BtcSendAuth extends StatefulWidget {
  const BtcSendAuth({Key? key}) : super(key: key);

  @override
  _BtcSendAuthState createState() => _BtcSendAuthState();
}

class _BtcSendAuthState extends State<BtcSendAuth> {
  @override
  Widget build(BuildContext c) {
    final tfaComplete = c.select((UserCubit u) => u.state.user!.tfaStatus);

    return BlocBuilder<BtcSendAddressCubit, BtcSendAddressState>(
        builder: (context, addressState) {
      return BlocBuilder<BtcSendFeesCubit, BtcSendFeesState>(
          builder: (context, feeState) {
        return BlocBuilder<BtcSendAmountCubit, BtcSendAmountState>(
            builder: (context, amountState) {
          return BlocBuilder<BtcSendTfaCubit, BtcSendTfaState>(
              builder: (context, tfaState) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Header(cornerTitle: 'SEND BITCOIN', children: [
                    BckButton(
                        text: 'BACK',
                        onTapped: () {
                          c.read<BtcSendCubit>().backClicked();
                        }),
                    SizedBox(height: 24),
                    HeaderText(text: 'Authorize\nPayment'),
                    SizedBox(height: 24),
                    Text('TO',
                        style: c.fonts.overline!
                            .copyWith(color: c.colours.surface)),
                    Text(addressState.address,
                        style: c.fonts.caption!.copyWith(
                          color: c.colours.surface,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 24),
                    Text('AMOUNT',
                        style: c.fonts.overline!
                            .copyWith(color: c.colours.surface)),
                    Text(amountState.amountEntered + ' sats',
                        style: c.fonts.headline5!
                            .copyWith(color: c.colours.surface)),
                    Text(amountState.amountEnteredSmall + ' BTC',
                        style: c.fonts.caption!
                            .copyWith(color: c.colours.surface)),
                    SizedBox(height: 24),
                    Text('FEES',
                        style: c.fonts.overline!
                            .copyWith(color: c.colours.surface)),
                    Text(feeState.feeEntered + ' sats',
                        style: c.fonts.headline5!
                            .copyWith(color: c.colours.surface)),
                    Text(feeState.feeEnteredSmall + ' BTC',
                        style: c.fonts.caption!
                            .copyWith(color: c.colours.surface)),
                    SizedBox(height: 24),
                    Text('TOTAL',
                        style: c.fonts.overline!
                            .copyWith(color: c.colours.surface)),
                    Text(amountState.finalAmountSats() + ' sats',
                        style: c.fonts.headline5!
                            .copyWith(color: c.colours.surface)),
                    Text(amountState.finalAmountBtc() + ' BTC',
                        style: c.fonts.caption!
                            .copyWith(color: c.colours.surface)),
                    if (tfaComplete) ...[
                      SizedBox(height: 24),
                      Text('Open your authenticator app',
                          style: c.fonts.bodyText2!.copyWith(
                              color: c.colours.surface,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      SecurityTfaOpenAuthButton(),
                      SizedBox(height: 16),
                    ],
                  ]),
                  if (tfaComplete) ...[
                    SizedBox(height: 24),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Enter 2FA CODE',
                            style: c.fonts.subtitle2!
                                .copyWith(fontWeight: FontWeight.bold))),
                    SizedBox(height: 8),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(height: 40, child: TfaPin())),
                    SizedBox(height: 8),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: GestureDetector(
                                onTap: () {
                                  c.read<BtcSendTfaCubit>().pasteClicked();
                                },
                                child: Text('Paste from clipboard',
                                    style: c.fonts.button!.copyWith(
                                        color: c.colours.primaryVariant))))),
                  ],
                  SizedBox(height: 24),
                  if (tfaState.error != '')
                    Center(
                      child: Text(tfaState.error,
                          style: c.fonts.caption!
                              .copyWith(color: c.colours.error)),
                    ),
                  SizedBox(height: 16),
                  if (!tfaComplete)
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ElevatedButton(
                            onPressed: () {
                              c.read<BtcSendCubit>().nextClicked();
                            },
                            child: Text('Send Payment'))),
                  SizedBox(height: 48)
                ]);
          });
        });
      });
    });
  }
}

class TfaPin extends StatefulWidget {
  const TfaPin({Key? key}) : super(key: key);

  @override
  _TfaPinState createState() => _TfaPinState();
}

class _TfaPinState extends State<TfaPin> {
  TextEditingController? _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<BtcSendTfaCubit, BtcSendTfaState>(
        builder: (context, tfaState) {
      if (tfaState.code != _controller!.text) _controller!.text = tfaState.code;

      return Stack(children: [
        PinRowSix(count: tfaState.code.length),
        Container(
          width: c.width,
          child: Opacity(
              opacity: 0,
              child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  //scrollPadding: EdgeInsets.only(top: 100),
                  onChanged: (text) {
                    c.read<BtcSendTfaCubit>().tfaCodeChanged(text);
                  })),
        )
      ]);
    });
  }
}
