import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sats/zold/model/rate.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/style.dart';
import 'package:sats/cubit/rates/calculator.dart';
import 'package:sats/zold/view/calculator/pad.dart';
import 'package:sats/zold/view/common/header.dart';
import 'package:sats/zold/cubit/wallet.dart';
import 'package:sats/zold/view/common/loading.dart';

class HomeCalc extends StatelessWidget {
  const HomeCalc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return SafeArea(
        child: SingleChildScrollView(
            child: Column(children: [
      Material(
          elevation: 4,
          child: Header(cornerTitle: 'STACKMATE', children: [
            HomeBuyHeader(),
          ])),
      BlocBuilder<CalculatorCubit, CalculatorState>(
        builder: (context, state) {
          if (state.loadingRates) return Loading(text: 'Loading Rates');

          return Container();
        },
      ),
      SizedBox(height: 40),
      Calculator()
    ])));
  }
}

class HomeBuyHeader extends StatelessWidget {
  const HomeBuyHeader({
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
          return BlocBuilder<WalletCubit, WalletState>(
              builder: (context, walletState) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (!walletState.loadingWallets) ...[
                    Text('BALANCE'.notLocalised(),
                        style: c.fonts.overline!
                            .copyWith(color: c.colours.surface)),
                    Text(walletState.totakWorthSatsStr() + ' sats',
                        style: c.fonts.headline5!
                            .copyWith(color: c.colours.surface)),
                    Text(' ' + walletState.totalWorthBtcStr() + ' BTC',
                        style: c.fonts.bodyText1!
                            .copyWith(color: c.colours.surface)),
                  ],
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
                                            color: c.colours.surface)))),
                            SizedBox(width: 8),
                            DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    iconEnabledColor: c.colours.surface,
                                    dropdownColor: c.colours.secondary,
                                    value:
                                        calcState.btcSelected ? 'BTC' : 'sats',
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
                                              color: c.colours.surface))),
                                  DropdownMenuItem(
                                      value: 'sats',
                                      child: Text('sats',
                                          style: c.fonts.button!.copyWith(
                                              color: c.colours.surface
                                                  .withAlpha(
                                                      calcState.editingBtc
                                                          ? 255
                                                          : 160))))
                                ]))
                          ])),
                    ),
                    FadeIn(
                        duration: Duration(milliseconds: 800),
                        delay: Duration(milliseconds: 400),
                        child: Divider(color: c.colours.surface)),
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
                                            color: c.colours.surface.withAlpha(
                                                calcState.editingBtc
                                                    ? 160
                                                    : 255))))),
                            SizedBox(width: 8),
                            DropdownButtonHideUnderline(
                                child: DropdownButton<Rate>(
                                    iconEnabledColor: c.colours.surface,
                                    dropdownColor: c.colours.secondary,
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
                                                color: c.colours.surface)))
                                ]))
                          ])),
                    )
                  ]
                ]);
          });
        }));
  }
}
