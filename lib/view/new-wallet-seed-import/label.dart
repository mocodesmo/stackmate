import 'package:flutter/material.dart';
import 'package:sats/cubit/new-wallet/seed-import.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/header-text.dart';

class SeedImportLabel extends StatefulWidget {
  const SeedImportLabel({Key? key}) : super(key: key);

  @override
  State<SeedImportLabel> createState() => _SeedImportLabelState();
}

class _SeedImportLabelState extends State<SeedImportLabel> {
  TextEditingController? _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<SeedImportCubit, SeedImportState>(
        buildWhen: (previous, current) =>
            previous.walletLabelError != current.walletLabelError,
        builder: (context, state) {
          if (state.walletLabel != _controller!.text)
            _controller!.text = state.walletLabel;

          final isFixed = state.labelFixed;

          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 24),
                if (!isFixed) HeaderTextDark(text: 'Label your wallet'),
                if (isFixed) HeaderTextDark(text: 'Label'),
                SizedBox(height: 24),
                Padding(
                    padding: EdgeInsets.all(0),
                    child: IgnorePointer(
                      ignoring: isFixed,
                      child: TextField(
                          controller: _controller,
                          onChanged: (text) {
                            if (!isFixed)
                              c.read<SeedImportCubit>().labelChanged(text);
                          },
                          decoration: InputDecoration(
                            labelText: 'Wallet Name',
                            //errorText: state.walletLabelError.nullIfEmpty(),
                          )),
                    )),
                SizedBox(height: 40),
                if (state.walletLabelError != '')
                  Text(state.walletLabelError,
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
