import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sats/cubit/new-wallet/xpub-import.dart';
import 'package:sats/pkg/extensions.dart';

class XPubImportStepper extends StatelessWidget {
  const XPubImportStepper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<XpubImportCubit, XpubImportState>(
      builder: (context, state) {
        final percent = state.completePercent();
        final percentStr = state.completePercentLabel();
        final stepLabel = state.currentStepLabel();
        final steps = XpubImportStep.values.length;
        final idx = state.currentStep.index;

        return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                stepLabel,
                style: c.fonts.headline6!.copyWith(color: Colors.white),
              ),
              SizedBox(height: 24),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                for (var i = 0; i < steps; i++)
                  Container(
                    height: 8,
                    width: 130,
                    decoration: BoxDecoration(
                        color: i <= idx
                            ? Colors.blue.withOpacity(0.4)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                  ),
              ]),
              // Text(
              //   percentStr + '% Completed',
              //   style: c.fonts.subtitle2!.copyWith(color: c.colours.background),
              // ),
              // SizedBox(height: 8),
              // Container(
              //   decoration:
              //       BoxDecoration(borderRadius: BorderRadius.circular(2)),
              //   clipBehavior: Clip.hardEdge,
              //   child: LinearProgressIndicator(
              //     value: percent,
              //     minHeight: 10,
              //   ),
              // ),
              SizedBox(height: 24),
              // Text(
              //   'Current Step: ' + stepLabel,
              //   style: c.fonts.caption!.copyWith(color: c.colours.background),
              // )
            ]);
      },
    );
  }
}
