import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/style.dart';
import 'package:sats/zold/view/common/loading.dart';
import 'package:sats/zold/view/common/main-button.dart';
import 'package:sats/zold/cubit/pin/pin-keyboard.dart';
import 'package:sats/zold/cubit/pin/pin-setup.dart';

class PinSetupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) =>
          buttonToLoaderTransition(child: child, animation: animation),
      duration: Duration(milliseconds: 800),
      child: BlocBuilder<PinKeyboardCubit, PinKeyboardState>(
          buildWhen: (previous, current) =>
              previous.fourKeysEntered().not(current.fourKeysEntered()),
          builder: (context, keyboardState) {
            final buttonOpacity = keyboardState.fourKeysEntered() ? 1.0 : 0.3;

            return BlocBuilder<PinSetupCubit, PinSetupState>(
              buildWhen: (previous, current) =>
                  previous.pinEntered.not(current.pinEntered) ||
                  previous.savingPin.not(current.savingPin),
              builder: (context, pinState) {
                if (pinState.savingPin)
                  return Loading(text: 'Saving Pin'.notLocalised());
                else if (!pinState.pinEntered)
                  return Opacity(
                    opacity: buttonOpacity,
                    child: MainButton(
                        text: 'Confirm Pin'.notLocalised(),
                        onTapped: () {
                          if (keyboardState.fourKeysEntered())
                            context
                                .read<PinSetupCubit>()
                                .confirmPinBackClicked();
                        }),
                  );
                else
                  return Opacity(
                    opacity: buttonOpacity,
                    child: MainButton(
                        text: 'Confirm Pin'.notLocalised(),
                        onTapped: () {
                          if (keyboardState.fourKeysEntered())
                            context
                                .read<PinSetupCubit>()
                                .confirmButtonPressed();
                        }),
                  );
              },
            );
          }),
    );
  }
}
