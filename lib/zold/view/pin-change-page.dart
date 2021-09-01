import 'package:flutter/material.dart';
import 'package:sats/zold/view/pin-change/button.dart';
import 'package:sats/zold/view/pin-change/header.dart';
import 'package:sats/zold/view/pin-change/keyboard.dart';
import 'package:sats/zold/view/pin-change/pin-field.dart';

class PinChangePage extends StatelessWidget {
  const PinChangePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      PinChangeHeader(),
      SizedBox(height: 32),
      PinChangeField(),
      SizedBox(height: 32),
      PinChangeButton(),
      Spacer(),
      PinChangeKeyboard(),
    ])));
  }
}
