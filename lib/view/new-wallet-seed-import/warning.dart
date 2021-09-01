import 'package:flutter/material.dart';
import 'package:sats/cubit/new-wallet/seed-import.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/header-text.dart';

class SeedImportWarning extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      HeaderTextDark(text: 'Security Information'),
      SizedBox(height: 24),
      Text('''
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
              ''',
          style: c.fonts.caption!.copyWith(
            color: Colors.white,
          )),
      SizedBox(height: 24),
      TextButton(
          onPressed: () {
            c.read<SeedImportCubit>().nextClicked();
          },
          child: Text('I Understand'))
    ]));
  }
}
