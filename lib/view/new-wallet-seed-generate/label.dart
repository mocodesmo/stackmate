import 'package:flutter/material.dart';
import 'package:sats/cubit/new-wallet/seed-generate.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/header-text.dart';

class SeedGenerateLabel extends StatelessWidget {
  const SeedGenerateLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<SeedGenerateCubit, SeedGenerateState>(
        buildWhen: (previous, current) =>
            previous.walletLabelError != current.walletLabelError,
        builder: (context, state) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 24),
                HeaderTextDark(text: 'Name your wallet'),
                SizedBox(height: 24),
                Padding(
                    padding: EdgeInsets.all(0),
                    child: TextField(
                        onChanged: (text) {
                          c.read<SeedGenerateCubit>().labelChanged(text);
                        },
                        decoration: InputDecoration(
                          labelText: 'Wallet Name',
                          //errorText: state.walletLabelError.nullIfEmpty()
                        ))),
                SizedBox(height: 40),
                if (state.walletLabelError != '')
                  Text(state.walletLabelError,
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
