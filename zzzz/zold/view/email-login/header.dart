import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/zold/view/common/back-button.dart';
import 'package:sats/zold/view/common/header-text.dart';
import 'package:sats/zold/view/common/header.dart';
import 'package:sats/zold/cubit/email-login.dart';

class EmailTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 800),
      child: BlocBuilder<EmailCubit, EmailState>(
          buildWhen: (previous, current) =>
              previous.emailSent.not(current.emailSent),
          builder: (c, emailState) {
            if (!emailState.emailSent)
              return Header(cornerTitle: 'STACKMATE', children: [
                SizedBox(height: 48),
                HeaderText(text: 'Enter email to\nget started.'.notLocalised())
              ]);
            return Header(cornerTitle: 'STACKMATE', children: [
              BckButton(
                  text: 'BACK'.notLocalised(),
                  onTapped: () {
                    c.read<EmailCubit>().resetEmailBloc();
                  }),
              SizedBox(height: 48),
              HeaderText(text: 'Login link sent\nto email.'.notLocalised()),
              SizedBox(height: 8),
              Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                      'Email Address: '.notLocalised() + emailState.email,
                      style:
                          c.fonts.caption!.copyWith(color: c.colours.surface)))
            ]);
          }),
    );
  }
}
