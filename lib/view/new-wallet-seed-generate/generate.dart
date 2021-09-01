import 'package:flutter/material.dart';
import 'package:sats/cubit/new-wallet/seed-generate.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/zold/view/common/header-text.dart';
import 'package:sats/view/new-wallet-seed-generate/seed-word.dart';

class SeedGenerate extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    final words = c.select((SeedGenerateCubit c) => c.state.seed);

    return SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      HeaderTextDark(text: 'Write down your\nseed phrase'.notLocalised()),
      SizedBox(height: 16),
      Text(
        'Make sure that no one can view,\nwhat you are writing'.notLocalised(),
        style: c.fonts.caption!.copyWith(color: c.colours.onBackground),
      ),
      SizedBox(height: 16),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            if (words != null)
              for (var i = 0; i < words.length; i++)
                if (i % 2 == 0 && i < 12)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (i == 0)
                            SeedWord(text: '1. ' + words[i])
                          else
                            SeedWord(
                                text: (i + 1).toString() + '. ' + words[i]),
                          SizedBox(width: 8),
                          SeedWord(
                              text: (i + 2).toString() + '. ' + words[i + 1])
                        ]),
                  )
          ])),
      SizedBox(height: 24),
      Padding(
          padding: EdgeInsets.all(16),
          child: ElevatedButton(
              onPressed: () {
                c.read<SeedGenerateCubit>().nextClicked();
              },
              child: Text('Next'))),
      SizedBox(height: 24)
    ]));
  }
}
