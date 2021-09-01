import 'package:flutter/material.dart';
import 'package:sats/cubit/new-wallet/seed-import.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/header-text.dart';

class SeedImportPassphrase extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return BlocBuilder<SeedImportCubit, SeedImportState>(
        buildWhen: (previous, current) =>
            previous.errPassPhrase != current.errPassPhrase,
        builder: (context, state) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 24),
                HeaderTextDark(text: 'Enter an optional\npassphrase'),
                SizedBox(height: 24),
                Padding(
                    padding: EdgeInsets.all(0),
                    child: TextField(
                        enableSuggestions: false,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        onChanged: (text) {
                          c.read<SeedImportCubit>().passPhraseChanged(text);
                        },
                        decoration: InputDecoration(labelText: 'Passphrase'))),
                SizedBox(height: 40),
                HeaderTextDark(text: 'Select an\naccount number'),
                SizedBox(height: 24),
                Padding(
                    padding: EdgeInsets.all(0),
                    child: TextField(
                        enableSuggestions: false,
                        autocorrect: false,
                        onChanged: (text) {
                          c.read<SeedImportCubit>().accountNumberChanged(text);
                        },
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(labelText: 'Account Number'))),
                SizedBox(height: 40),
                if (state.errPassPhrase != '')
                  Text(state.errPassPhrase,
                      style: c.fonts.caption!.copyWith(color: c.colours.error)),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                        onPressed: () {
                          c.read<SeedImportCubit>().nextClicked();
                        },
                        child: Text('Confirm')))
              ]);
        });
  }
}
