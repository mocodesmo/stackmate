import 'package:flutter/material.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/zold/view/common/loading.dart';
import 'package:sats/zold/view/common/main-button.dart';
import 'package:sats/zold/cubit/security-tfa.dart';

class SecurityTfaButton extends StatelessWidget {
  const SecurityTfaButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 800),
      child: BlocBuilder<SecurityTfaCubit, SecurityTfaState>(
          buildWhen: (previous, current) =>
              previous.generatingKey.not(current.generatingKey) ||
              previous.verifyingPin.not(current.verifyingPin) ||
              previous.keyGenerated.not(current.keyGenerated),
          builder: (context, state) {
            if (state.generatingKey && !state.keyGenerated)
              return Loading(text: 'Generating Key');

            if (state.verifyingPin && state.keyGenerated)
              return Loading(text: 'Verifying');

            if (!state.keyGenerated)
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('I Understand,')),
                    SizedBox(height: 16),
                    MainButton(
                        text: 'Generate Secret Key'.notLocalised(),
                        onTapped: () {
                          c.read<SecurityTfaCubit>().generateKey();
                        }),
                    if (state.keyGenerateError != '') ...[
                      SizedBox(height: 16),
                      Center(
                          child: Text(state.keyGenerateError,
                              style: c.fonts.caption!
                                  .copyWith(color: c.colours.error)))
                    ],
                  ]);

            return Container();
          }),
    );
  }
}
