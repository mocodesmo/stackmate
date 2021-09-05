import 'package:flutter/material.dart';
import 'package:sats/cubit/new-wallet/seed-generate.dart';
import 'package:sats/pkg/extensions.dart';
//import 'package:sats/zold/view/new-wallet-common/step.dart';

//class SeedGenerateStepper extends StatelessWidget {
//  @override
//  Widget build(BuildContext c) {
//    final step = c.select((SeedGenerateCubit c) => c.state.currentStep);

//    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//      StepCell(
//        isOn: true,
//        isSelected: step == SeedGenerateSteps.security,
//        text: 'Security',
//      ),
//      StepCell(
//        isOn: step.index >= SeedGenerateSteps.generate.index,
//        isSelected: step == SeedGenerateSteps.generate,
//        text: 'Generate',
//      ),
//      StepCell(
//        isOn: step.index >= SeedGenerateSteps.confirm.index,
//        isSelected: step == SeedGenerateSteps.confirm,
//        text: 'Confirm',
//      ),
//      StepCell(
//        isOn: step.index >= SeedGenerateSteps.label.index,
//        isSelected: step == SeedGenerateSteps.label,
//        text: 'Label',
//      )
//    ]);
//  }
//}

class NewGenerateStepper extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return BlocBuilder<SeedGenerateCubit, SeedGenerateState>(
        buildWhen: (previous, current) =>
            previous.currentStep != current.currentStep,
        builder: (context, state) {
          final stepLabel = state.currentStepLabel();
          final steps = SeedGenerateSteps.values.length;
          final idx = state.currentStep.index;

          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Text(
                //   percentStr + '% Completed',
                //   style:
                //       c.fonts.subtitle2!.copyWith(color: c.colours.background),
                // ),
                Text(
                  stepLabel,
                  style: c.fonts.headline6!.copyWith(color: Colors.white),
                ),
                SizedBox(height: 24),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (var i = 0; i < steps; i++)
                        Container(
                          height: 8,
                          width: 40,
                          decoration: BoxDecoration(
                              color: i <= idx
                                  ? Colors.blue.withOpacity(0.4)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                    ]),
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
              ]);
        });
  }
}
