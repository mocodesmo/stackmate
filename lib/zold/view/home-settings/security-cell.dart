import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/zold/cubit/user.dart';
import 'package:sats/zold/view/home-settings/settings-cell.dart';

class SecurityCell extends StatelessWidget {
  const SecurityCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    //final security = c.select((UserBloc bloc) => bloc.state.user.security);
    final user = c.select((UserCubit bloc) => bloc.state.user);
    if (user == null) return Container();

    final isComplete = user.tfaStatus;

    if (!isComplete) //security.noSecurity)
      return SettingsCell(
        title: 'SECURITY'.notLocalised(),
        description:
            'Setup security to start\nusing important features.'.notLocalised(),
        largeText: 'SETUP\nSECURITY'.notLocalised(),
        alertColor: true,
        onTap: () {
          Navigator.pushNamed(c, '/security-home');
        },
      );

    //if (security.otpSelected)
    //  return SettingsCell(
    //    title: 'SECURITY'.notLocalised(),
    //    description: 'Lower security protocol\nis being used.'.notLocalised(),
    //    largeText: 'OTP VIA\nPHONE'.notLocalised(),
    //    alertColor: true,
    //    key: kSecurityLowCell,
    //    onTap: () {
    //      Navigator.pushNamed(c, '/security-home');
    //    },
    //  );

    if (isComplete) //security.tfaSelected)
      return SettingsCell(
        title: 'SECURITY'.notLocalised(),
        description: 'Maximum security protocol\nis being used.'.notLocalised(),
        largeText: '2-FA\nVERIFICATION'.notLocalised(),
        onTap: () {
          Navigator.pushNamed(c, '/security-home');
        },
      );

    return Container();
  }
}
