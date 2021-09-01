import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/style.dart';
import 'package:sats/zold/cubit/security-tfa.dart';

class SecurityTfaPinField extends StatefulWidget {
  const SecurityTfaPinField({Key? key}) : super(key: key);

  @override
  _SecurityTfaPinFieldState createState() => _SecurityTfaPinFieldState();
}

class _SecurityTfaPinFieldState extends State<SecurityTfaPinField> {
  TextEditingController? _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext c) {
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) =>
          buttonToLoaderTransition(animation: animation, child: child),
      duration: Duration(milliseconds: 800),
      child: BlocBuilder<SecurityTfaCubit, SecurityTfaState>(
          //buildWhen: (previous, current) =>
          //    previous.keyGenerated.not(current.keyGenerated) ||
          //    previous.verifyingPin.not(current.verifyingPin),
          builder: (context, state) {
        if (!state.keyGenerated) return Container();

        if (state.verifyingPin) return Container();

        if (state.pin != _controller!.text) _controller!.text = state.pin;

        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text('CONFIRM 2FA CODE'.notLocalised())),
                  SizedBox(height: 8),
                  Container(
                      width: context.width * 0.8,
                      child: PinInputTextField(
                          controller: _controller,
                          pinLength: 6,
                          onChanged: (value) {
                            c.read<SecurityTfaCubit>().tfaCodeChanged(value);
                          },
                          decoration: BoxLooseDecoration(
                              strokeColorBuilder: PinListenColorBuilder(
                                context.colours.secondary.withAlpha(20),
                                context.colours.secondary.withAlpha(50),
                              ),
                              radius: Radius.circular(2)))),
                  SizedBox(height: 8),
                  if (state.pinError != '') ...[
                    Center(
                        child: Text(state.pinError,
                            style: c.fonts.caption!
                                .copyWith(color: c.colours.error))),
                    SizedBox(height: 16),
                  ],
                  Row(children: [
                    SizedBox(
                        width: context.width / 3,
                        child: Opacity(
                          opacity: state.showVerify() ? 1 : 0.3,
                          child: ElevatedButton(
                              onPressed: () {
                                if (state.showVerify())
                                  c.read<SecurityTfaCubit>().verifyCode();
                              },
                              child: Text('VERIFY'.notLocalised())),
                        )),
                    //Spacer(),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          c.read<SecurityTfaCubit>().pasteCode();
                        },
                        child: Text('Paste from clipboard'.notLocalised(),
                            textAlign: TextAlign.end,
                            style: c.fonts.button!.copyWith(
                              color: c.colours.primaryVariant,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    )
                  ])
                ]));
      }),
    );
  }
}
