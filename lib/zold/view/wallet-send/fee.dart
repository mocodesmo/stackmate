import 'package:flutter/material.dart';
import 'package:sats/zold/cubit/btc-send/fee.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/zold/cubit/btc-send/amount.dart';

class FeeField extends StatefulWidget {
  const FeeField({Key? key}) : super(key: key);

  @override
  _FeeFieldState createState() => _FeeFieldState();
}

class _FeeFieldState extends State<FeeField> {
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
    return BlocBuilder<BtcSendFeesCubit, BtcSendFeesState>(
        builder: (context, feeState) {
      return BlocBuilder<BtcSendAmountCubit, BtcSendAmountState>(
          builder: (context, state) {
        if (feeState.feeEntered != _controller!.text)
          _updateController(feeState.feeEntered);

        return GestureDetector(
            onTap: () {
              if (!_focusNode!.hasFocus) _focusNode!.requestFocus();
            },
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
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
                                      c
                                          .read<BtcSendFeesCubit>()
                                          .feeEntered(value);
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
                                        contentPadding:
                                            EdgeInsets.only(bottom: 0),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none))),
                            SizedBox(width: c.width / 6)
                          ]),
                          PositionedDirectional(
                              top: 5,
                              end: 16, //c.width / 11,
                              child: Text('sats/kb',
                                  style: c.fonts.headline5!
                                      .copyWith(color: c.colours.surface)))
                        ]),
                        Text(feeState.feesBtc() + ' BTC/kb',
                            style: c.fonts.caption!
                                .copyWith(color: c.colours.surface)),
                        SizedBox(height: 8)
                      ])),
                  SizedBox(height: 16),
                  PercentRow()
                ]));
      });
    });
  }
}

class PercentRow extends StatelessWidget {
  const PercentRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<BtcSendFeesCubit, BtcSendFeesState>(
        builder: (context, feeState) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        PercentButton(
            text: 'Slow',
            selected: feeState.feeSelected == Traffic.low,
            onTapped: () {
              c.read<BtcSendFeesCubit>().changeFee(Traffic.low);
            }),
        PercentButton(
            text: 'Medium',
            selected: feeState.feeSelected == Traffic.medium,
            onTapped: () {
              c.read<BtcSendFeesCubit>().changeFee(Traffic.medium);
            }),
        PercentButton(
            text: 'Fast',
            selected: feeState.feeSelected == Traffic.high,
            onTapped: () {
              c.read<BtcSendFeesCubit>().changeFee(Traffic.high);
            })
      ]);
    });
  }
}

class PercentButton extends StatelessWidget {
  const PercentButton(
      {Key? key, required this.text, required this.selected, this.onTapped})
      : super(key: key);

  final String text;
  final bool selected;
  final Function? onTapped;

  @override
  Widget build(BuildContext c) {
    if (!selected)
      return GestureDetector(
        onTap: () {
          if (onTapped != null) onTapped!();
        },
        child: Container(
            width: c.width / 4,
            padding: EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: c.colours.surface),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Center(
                child: Text(text,
                    style:
                        c.fonts.button!.copyWith(color: c.colours.surface)))),
      );

    return Container(
        width: c.width / 4,
        padding: EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
            color: c.colours.primary, borderRadius: BorderRadius.circular(2)),
        child: Center(
            child: Text(text,
                style: c.fonts.button!.copyWith(color: c.colours.surface))));
  }
}
