import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sats/cubit/calculator.dart';
import 'package:sats/model/rate.dart';
import 'package:sats/pkg/validation.dart';
import 'package:sats/view/common/back-button.dart';
import 'package:sats/view/common/header.dart';
import 'package:sats/view/common/loading.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/style.dart';

class RatesHeader extends StatelessWidget {
  const RatesHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        transitionBuilder: (child, animation) =>
            buttonToLoaderTransition(child: child, animation: animation),
        child: BlocBuilder<CalculatorCubit, CalculatorState>(
            builder: (context, calcState) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 32),
                if (!calcState.loadingRates && calcState.rates != null) ...[
                  FadeIn(
                    duration: Duration(milliseconds: 800),
                    child: GestureDetector(
                        onTap: () {
                          c.read<CalculatorCubit>().fieldSelected(false);
                        },
                        child: Row(children: [
                          Expanded(
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(calcState.satsAmt,
                                      style: c.fonts.headline5!.copyWith(
                                          color: c.colours.primary)))),
                          SizedBox(width: 8),
                          DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                  iconEnabledColor: c.colours.primary,
                                  dropdownColor: c.colours.secondary,
                                  value: calcState.btcSelected ? 'BTC' : 'sats',
                                  onTap: () {
                                    print('eerrree');
                                  },
                                  onChanged: (text) {
                                    c
                                        .read<CalculatorCubit>()
                                        .btcTypeChanged(text == 'BTC');
                                  },
                                  items: [
                                DropdownMenuItem(
                                    value: 'BTC',
                                    child: Text('BTC',
                                        style: c.fonts.button!.copyWith(
                                            color: c.colours.primary))),
                                DropdownMenuItem(
                                    value: 'sats',
                                    child: Text('sats',
                                        style: c.fonts.button!.copyWith(
                                            color: c.colours.primary.withAlpha(
                                                calcState.editingBtc
                                                    ? 255
                                                    : 160))))
                              ]))
                        ])),
                  ),
                  FadeIn(
                      duration: Duration(milliseconds: 800),
                      delay: Duration(milliseconds: 400),
                      child: Divider(color: c.colours.primary)),
                  FadeIn(
                    duration: Duration(milliseconds: 800),
                    delay: Duration(milliseconds: 600),
                    child: GestureDetector(
                        onTap: () {
                          c.read<CalculatorCubit>().fieldSelected(true);
                        },
                        child: Row(children: [
                          Expanded(
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(calcState.currencyAmt,
                                      style: c.fonts.headline5!.copyWith(
                                          color: c.colours.primary.withAlpha(
                                              calcState.editingBtc
                                                  ? 160
                                                  : 255))))),
                          SizedBox(width: 8),
                          DropdownButtonHideUnderline(
                              child: DropdownButton<Rate>(
                                  iconEnabledColor: c.colours.primary,
                                  dropdownColor: c.colours.surface,
                                  onTap: () {},
                                  onChanged: (rate) {
                                    c
                                        .read<CalculatorCubit>()
                                        .currencyTypeChanged(rate!);
                                  },
                                  value: calcState.selectedRate!,
                                  items: [
                                for (var rate in calcState.rates!)
                                  DropdownMenuItem(
                                      value: rate,
                                      child: Text(rate.symbol,
                                          style: c.fonts.button!.copyWith(
                                              color: c.colours.primary)))
                              ]))
                        ])),
                  )
                ]
              ]);
        }));
  }
}

class CalcKey extends StatefulWidget {
  const CalcKey({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  _CalcKeyState createState() => _CalcKeyState();
}

class _CalcKeyState extends State<CalcKey> {
  double _elevation = 2.0;

  @override
  Widget build(BuildContext c) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _elevation = 0;
        });
      },
      onTapUp: (details) {
        setState(() {
          _elevation = 2;
        });
      },
      onTapCancel: () {
        setState(() {
          _elevation = 0;
        });
      },
      onTap: () {
        c.read<CalculatorCubit>().calcKeyPressed(widget.text);
      },
      child: Container(
        width: (c.width / 5) - 5,
        height: (c.width / 5) - 5,
        child: Material(
          elevation: _elevation,
          color: (Validation.isNumeric(widget.text)
                  ? Colors.transparent
                  : c.colours.background.withOpacity(1))
              .withOpacity(0.4),
          child: Center(
            child: Text(
              widget.text,
              style: c.fonts.headline6!.copyWith(color: c.colours.primary),
            ),
          ),
        ),
      ),
    );
  }
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  //static Widget _w = SizedBox(width: 4);
  static Widget _h = SizedBox(height: 4);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      _h,
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        //_w,
        CalcKey(text: 'C'),
        //_w,
        CalcKey(text: 'del'),
        //_w,
        CalcKey(text: '1'),
        //_w,
        CalcKey(text: '2'),
        //_w,
        CalcKey(text: '3'),
        //_w,
      ]),
      _h,
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        //_w,
        CalcKey(text: '('),
        //_w,
        CalcKey(text: ')'),
        //_w,
        CalcKey(text: '4'),
        //_w,
        CalcKey(text: '5'),
        //_w,
        CalcKey(text: '6'),
        //_w,
      ]),
      _h,
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        //_w,
        CalcKey(text: '+'),
        //_w,
        CalcKey(text: '-'),
        //_w,
        CalcKey(text: '7'),
        //_w,
        CalcKey(text: '8'),
        //_w,
        CalcKey(text: '9'),
        //_w,
      ]),
      _h,
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        //_w,
        CalcKey(text: 'x'),
        //_w,
        CalcKey(text: '/'),
        //_w,
        CalcKey(text: '.'),
        //_w,
        CalcKey(text: '='),
        //_w,
        CalcKey(text: '0'),
        //_w,
      ]),
      // SizedBox(height: 200)
    ]);
  }
}

class CalcPage extends StatelessWidget {
  const CalcPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    final loading = c.select((CalculatorCubit c) => c.state.loadingRates);

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(children: [
        if (loading) LinearProgressIndicator(),
        if (!loading)
          Header(cornerTitle: 'STACKMATE', children: [
            SizedBox(height: 8),
            Back(),
            SizedBox(height: 24),
            RatesHeader(),
          ]),
        SizedBox(height: 40),
        if (!loading)
          FadeIn(delay: Duration(milliseconds: 800), child: Calculator())
      ]))),
    );
  }
}
