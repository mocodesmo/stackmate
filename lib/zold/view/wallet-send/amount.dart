import 'package:flutter/material.dart';
import 'package:sats/zold/cubit/btc-send/fee.dart';
import 'package:sats/zold/cubit/wallet.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/zold/cubit/btc-send/amount.dart';
import 'package:sats/zold/cubit/btc-send/send.dart';
import 'package:sats/zold/view/wallet-send/fee.dart';
import 'package:sats/zold/view/common/back-button.dart';
import 'package:sats/zold/view/common/header-text.dart';
import 'package:sats/zold/view/common/header.dart';
import 'package:sats/zold/view/common/loading.dart';
import 'package:sats/zold/view/common/main-button.dart';

class BtcSendAmount extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    final wallet = c.select((WalletCubit w) => w.state.selectedWallet!);
    //final isConfirming = c.select((BtcSendBloc s) => s.state.confirming);

    return BlocBuilder<BtcSendCubit, BtcSendState>(
        buildWhen: (previous, current) =>
            previous.confirming.not(current.confirming),
        builder: (context, sendState) {
          return BlocBuilder<BtcSendFeesCubit, BtcSendFeesState>(
              builder: (context, feeState) {
            return BlocBuilder<BtcSendAmountCubit, BtcSendAmountState>(
                builder: (context, amountState) {
              return IgnorePointer(
                  ignoring: sendState.confirming,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Header(
                            cornerTitle: 'SEND BITCOIN'.notLocalised(),
                            children: [
                              BckButton(
                                  text: 'BACK',
                                  onTapped: () {
                                    c.read<BtcSendCubit>().backClicked();
                                  }),
                              SizedBox(height: 16),
                              HeaderText(text: 'Enter amount\nto send'),
                              SizedBox(height: 16),
                              Row(children: [
                                Column(children: [
                                  Text('AVAILABLE BALANCE'.notLocalised(),
                                      style: c.fonts.overline!
                                          .copyWith(color: c.colours.surface)),
                                  Text(
                                      wallet.balances.confirmed.toString() +
                                          ' sats',
                                      style: c.fonts.headline6!
                                          .copyWith(color: c.colours.surface))
                                ]),
                                Spacer(),
                                //Column(
                                //    crossAxisAlignment:
                                //        CrossAxisAlignment.center,
                                //    children: [
                                //      Text('Send All',
                                //          style: c.fonts.overline!.copyWith(
                                //              color: c.colours.surface)),
                                //      Switch(
                                //          thumbColor: MaterialStateProperty.all(
                                //            fullOrange,
                                //          ),
                                //          //trackColor: MaterialStateProperty.all(
                                //          //  c.colours.background,
                                //          //),
                                //          activeColor: c.colours.error,
                                //          inactiveTrackColor:
                                //              c.colours.background,
                                //          value: useMax,
                                //          onChanged: (b) {
                                //            c
                                //                .read<BtcSendAmountCubit>()
                                //                .toggleMaxBalance(b);
                                //          })
                                //    ])
                              ]),
                              SizedBox(height: 16),
                              Text('ENTER AMOUNT'.notLocalised(),
                                  style: c.fonts.overline!
                                      .copyWith(color: c.colours.surface)),
                              SizedBox(height: 8),
                              AmountField(),
                              SizedBox(height: 16),
                              if (amountState.amountError != '')
                                Center(
                                  child: Text(amountState.amountError,
                                      style: c.fonts.subtitle2!
                                          .copyWith(color: c.colours.error)),
                                ),
                              SizedBox(height: 16),
                              Text('MINER FEE'.notLocalised(),
                                  style: c.fonts.overline!
                                      .copyWith(color: c.colours.surface)),
                              SizedBox(height: 8),
                              FeeField(),
                              if (feeState.feeError != '')
                                Center(
                                    child: Text(feeState.feeError,
                                        style: c.fonts.subtitle2!
                                            .copyWith(color: c.colours.error))),
                              SizedBox(height: 24),
                              Row(children: [
                                Text('NETWORK TRAFFIC STATUS: ',
                                    style: c.fonts.bodyText2!
                                        .copyWith(color: c.colours.surface)),
                                Text(feeState.networkInfo.traffic,
                                    style: c.fonts.bodyText2!
                                        .copyWith(color: c.colours.error))
                              ]),
                              SizedBox(height: 8)
                            ]),
                        if (!sendState.confirming) ...[
                          SizedBox(height: 24),
                          if (sendState.confirmingError != '')
                            Center(
                                child: Text(sendState.confirmingError,
                                    style: c.fonts.caption!
                                        .copyWith(color: c.colours.error))),
                          SizedBox(height: 24),
                          MainButton(
                              text: 'CONFIRM',
                              onTapped: () {
                                c.read<BtcSendCubit>().nextClicked();
                              })
                        ] else
                          Loading(text: 'Building Transaction'),
                        SizedBox(height: 54)
                      ]));
            });
          });
        });
  }
}

class AmountField extends StatefulWidget {
  const AmountField({
    Key? key,
  }) : super(key: key);

  @override
  _AmountFieldState createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountField> {
  TextEditingController? _controller;
  FocusNode? _focusNode;

  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  _updateController(String text) {
    _controller!.text = text;
    _controller!.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller!.text.length));
  }

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<BtcSendAmountCubit, BtcSendAmountState>(
        builder: (context, state) {
      if (state.amountEntered != _controller!.text)
        _updateController(state.amountEntered);

      return GestureDetector(
          onTap: () {
            if (!_focusNode!.hasFocus) _focusNode!.requestFocus();
          },
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              width: double.infinity,
              color: c.colours.primary.withAlpha(100),
              child: Column(children: [
                Stack(children: [
                  Row(children: [
                    SizedBox(width: c.width / 6),
                    Expanded(
                        child: TextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            onChanged: (value) {
                              c.read<BtcSendAmountCubit>().amountEntered(value);
                            },
                            textAlign: TextAlign.center,
                            style: c.fonts.headline5!
                                .copyWith(color: c.colours.surface),
                            showCursor: _controller!.text.length > 1,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: '0',
                                hintStyle: c.fonts.headline5!
                                    .copyWith(color: c.colours.surface),
                                fillColor: Colors.transparent,
                                contentPadding: EdgeInsets.only(bottom: 0),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none))),
                    SizedBox(width: c.width / 6)
                  ]),
                  PositionedDirectional(
                      top: 5,
                      end: 16,
                      child: Text('sats',
                          style: c.fonts.headline5!
                              .copyWith(color: c.colours.surface)))
                ]),
                Text(state.amountEnteredSmall + ' BTC',
                    style: c.fonts.caption!.copyWith(color: c.colours.surface)),
                SizedBox(height: 8)
              ])));
    });
  }
}
