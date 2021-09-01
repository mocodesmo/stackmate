import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sats/cubit/new-wallet/xpub-import.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/header-text.dart';
import 'package:sats/view/common/loading.dart';

class XpubLabel extends StatelessWidget {
  const XpubLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<XpubImportCubit, XpubImportState>(
        builder: (context, state) {
      return IgnorePointer(
        ignoring: state.savingWallet,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SizedBox(height: 24),
          HeaderTextDark(text: 'Label your wallet'),
          SizedBox(height: 24),
          Padding(
              padding: EdgeInsets.all(0),
              child: TextField(
                  onChanged: (text) {
                    c.read<XpubImportCubit>().labelChanged(text);
                  },
                  decoration: InputDecoration(
                    labelText: 'Wallet Name',
                    //errorText: state.walletLabelError.nullIfEmpty(),
                  ))),
          SizedBox(height: 40),
          if (state.errSavingWallet != '')
            Text(state.errSavingWallet,
                style: c.fonts.caption!.copyWith(color: c.colours.error)),
          if (!state.savingWallet)
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                    onPressed: () {
                      c.read<XpubImportCubit>().nextClicked();
                    },
                    child: Text('Confirm')))
          else
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Loading(text: 'Saving Wallet'))
        ]),
      );
    });
  }
}
