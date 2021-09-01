import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/style.dart';
import 'package:sats/zold/cubit/pin/pin-change.dart';

class PinChangeField extends StatelessWidget {
  const PinChangeField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 800),
      child: BlocBuilder<PinChangeCubit, PinChangeState>(
          buildWhen: (previous, current) =>
              previous.currentPinChecked.not(current.currentPinChecked) ||
              previous.newPinComplete.not(current.newPinComplete),
          builder: (context, state) {
            if (!state.currentPinChecked)
              return Center(
                  child: Container(
                      width: context.width * 0.66,
                      child: PinInputTextField(
                          pinLength: 4, decoration: pinInputDecoration)));
            if (state.currentPinChecked && !state.newPinComplete)
              return Center(
                  child: Container(
                      width: context.width * 0.66,
                      child: PinInputTextField(
                          pinLength: 4, decoration: pinInputDecoration)));
            if (state.newPinComplete)
              return Center(
                  child: Container(
                      width: context.width * 0.66,
                      child: PinInputTextField(
                          pinLength: 4, decoration: pinInputDecoration)));

            return Container();
          }),
    );
  }
}
