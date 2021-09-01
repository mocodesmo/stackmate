import 'package:flutter/material.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/zold/view/common/back-button.dart';
import 'package:sats/zold/view/common/header-text.dart';
import 'package:sats/zold/view/common/header.dart';
import 'package:sats/zold/cubit/pin/pin-change.dart';

class PinChangeHeader extends StatelessWidget {
  const PinChangeHeader({Key? key}) : super(key: key);

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
              return Header(cornerTitle: 'CHANGE\nSECURITY PIN', children: [
                BckButton(text: 'BACK', onTapped: () {}),
                SizedBox(height: 24),
                HeaderText(text: 'Enter Current\nSecurity Pin'),
              ]);
            if (state.currentPinChecked && !state.newPinComplete)
              return Header(cornerTitle: 'CHANGE\nSECURITY PIN', children: [
                BckButton(text: 'BACK', onTapped: () {}),
                SizedBox(height: 24),
                HeaderText(text: 'Enter New\nSecurity Pin'),
              ]);
            if (state.newPinComplete)
              return Header(cornerTitle: 'CHANGE\nSECURITY PIN', children: [
                BckButton(text: 'BACK', onTapped: () {}),
                SizedBox(height: 24),
                HeaderText(text: 'Confirm New\nSecurity Pin'),
              ]);

            return Container();
          }),
    );
  }
}
