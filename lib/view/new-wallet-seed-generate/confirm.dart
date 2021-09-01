import 'package:flutter/material.dart';
import 'package:sats/cubit/new-wallet/seed-generate.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/zold/view/common/header-text.dart';
import 'package:sats/view/new-wallet-common/step.dart';
import 'package:sats/view/new-wallet-seed-generate/seed-word.dart';

class SeedConfirm extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    final answerIdx =
        c.select((SeedGenerateCubit c) => c.state.quizSeedAnswerIdx.toString());

    final completedIdx =
        c.select((SeedGenerateCubit c) => c.state.quizSeedCompleted);

    final words = c.select((SeedGenerateCubit c) => c.state.quizSeedList);

    final error = c.select((SeedGenerateCubit c) => c.state.quizSeedError);

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: HeaderTextDark(text: 'Confirm seed\nphrase'),
      ),
      SizedBox(height: 8),
      Container(
          margin: EdgeInsets.all(24),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(width: 2)),
          child: SizedBox(
              height: 88,
              child: Center(
                  child: Text(answerIdx + '.',
                      style: c.fonts.headline5!
                          .copyWith(fontWeight: FontWeight.bold))))),
      if (error != '')
        Center(
            child: Text(error,
                style: c.fonts.caption!.copyWith(color: c.colours.error))),
      SizedBox(height: 8),
      Center(
          child: Text('Select the correct answer',
              style:
                  c.fonts.subtitle1!.copyWith(color: c.colours.onBackground))),
      SizedBox(height: 16),
      for (var i = 0; i < words.length; i++)
        if (i % 2 == 0)
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            SeedWord(
                text: words[i],
                onTap: () {
                  c.read<SeedGenerateCubit>().seedWordSelected(words[i]);
                }),
            SizedBox(width: 8),
            SeedWord(
                text: words[i + 1],
                onTap: () {
                  c.read<SeedGenerateCubit>().seedWordSelected(words[i + 1]);
                })
          ]),
      SizedBox(height: 32),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        StepCell(isOn: true, isSelected: true, text: ''),
        StepCell(isOn: completedIdx > 1, isSelected: true, text: ''),
        StepCell(isOn: completedIdx > 2, isSelected: true, text: '')
      ])
    ]);
  }
}
