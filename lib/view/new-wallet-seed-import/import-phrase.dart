import 'package:flutter/material.dart';
import 'package:sats/cubit/new-wallet/seed-import.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/header-text.dart';

class SeedImportPhrase extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return BlocBuilder<SeedImportCubit, SeedImportState>(
        builder: (context, state) {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        HeaderTextDark(text: 'Enter your seed\nphrase'.notLocalised()),
        SizedBox(height: 24),
        Padding(
            padding: const EdgeInsets.all(0.0),
            child: TextField(
                enableSuggestions: false,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onChanged: (text) {
                  c.read<SeedImportCubit>().seedTextChanged(text);
                },
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: 'Seed Phrase',
                  fillColor: c.colours.surface,
                  errorText: state.seedError.nullIfEmpty(),
                ))),
        SizedBox(height: 24),
        AnimatedOpacity(
          opacity: state.showSeedCompleteButton() ? 1 : 0.3,
          duration: Duration(milliseconds: 300),
          child: TextButton(
              onPressed: () {
                if (state.showSeedCompleteButton())
                  c.read<SeedImportCubit>().nextClicked();
              },
              child: Text('Next')),
        ),
        SizedBox(height: 24),
      ]);
    });
  }
}
