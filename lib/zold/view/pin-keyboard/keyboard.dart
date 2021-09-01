import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/zold/cubit/pin/pin-keyboard.dart';
import 'package:sats/zold/view/pin-keyboard/key.dart';

class PinKeyBoard extends StatelessWidget {
  const PinKeyBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PinKeyboardCubit, PinKeyboardState>(
        builder: (context, state) {
      final numberList = state.numberList;

      return Material(
          elevation: 0,
          color: context.colours.background,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              PinKey(number: numberList[0]),
              PinKey(number: numberList[1]),
              PinKey(number: numberList[2])
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              PinKey(number: numberList[3]),
              PinKey(number: numberList[4]),
              PinKey(number: numberList[5])
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              PinKey(number: numberList[6]),
              PinKey(number: numberList[7]),
              PinKey(number: numberList[8])
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              PinKey(number: ''),
              PinKey(number: numberList[9]),
              PinKey(number: 'x')
            ]),
            SizedBox(height: 8)
          ]));
    });
  }
}
