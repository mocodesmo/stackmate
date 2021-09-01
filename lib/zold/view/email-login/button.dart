import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/style.dart';
import 'package:sats/zold/view/common/loading.dart';
import 'package:sats/zold/view/common/main-button.dart';
import 'package:sats/zold/cubit/email-login.dart';

class EmailButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.fastOutSlowIn,
      transitionBuilder: (child, animation) =>
          buttonToLoaderTransition(child: child, animation: animation),
      duration: Duration(milliseconds: 800),
      child: BlocBuilder<EmailCubit, EmailState>(
          buildWhen: (previous, current) =>
              previous.sendingEmail.not(current.sendingEmail) ||
              previous.checkingLink.not(current.checkingLink),
          builder: (context, state) {
            if (state.checkingLink)
              return Loading(text: 'VERIFYING LINK'.notLocalised());
            else if (state.sendingEmail)
              return Loading(text: 'SENDING LINK'.notLocalised());
            else if (!state.emailSent)
              return MainButton(
                  text: 'Send One-Time Link'.notLocalised(),
                  onTapped: () {
                    context.read<EmailCubit>().sendEmail();
                  });
            else
              return MainButton(
                  text: 'Open Default Email App'.notLocalised(),
                  onTapped: () {
                    context.read<EmailCubit>().openEmailApp();
                  });
          }),
    );
  }
}
