import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sats/cubit/new-wallet/seed-generate.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/zold/view/common/header-text.dart';

class SeedGeneratePassphrase extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return BlocBuilder<SeedGenerateCubit, SeedGenerateState>(
        buildWhen: (previous, current) =>
            previous.errPassphrase != current.errPassphrase,
        builder: (context, state) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 24),
                HeaderTextDark(text: 'Enter an\noptional\npassphrase'),
                SizedBox(height: 24),
                Padding(
                    padding: EdgeInsets.all(0),
                    child: TextField(
                        onChanged: (text) {
                          c.read<SeedGenerateCubit>().passPhrasedChanged(text);
                        },
                        decoration: InputDecoration(labelText: 'Passphrase'))),
                SizedBox(height: 40),
                if (state.errPassphrase != '')
                  Text(state.errPassphrase,
                      style: c.fonts.caption!.copyWith(color: c.colours.error)),
                SizedBox(height: 24),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                        onPressed: () {
                          c.read<SeedGenerateCubit>().nextClicked();
                        },
                        child: Text('Confirm')))
              ]);
        });
  }
}
