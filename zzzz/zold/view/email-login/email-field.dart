import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/zold/cubit/email-login.dart';

class EmailField extends StatelessWidget {
  const EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 800),
      child: BlocBuilder<EmailCubit, EmailState>(
          //buildWhen: (previous, current) =>
          //    previous.emailError.not(current.emailError) ||
          //    previous.sendingEmail.not(current.sendingEmail) ||
          //    previous.emailSent.not(current.emailSent),
          builder: (context, state) {
        final hideTextField =
            state.sendingEmail || state.emailSent || state.checkingLink;

        String? error = state.emailError.nullIfEmpty();
        if (error == null) error = state.linkError.nullIfEmpty();

        if (hideTextField) return Container();
        return Container(
            height: 88,
            width: context.width - 32,
            //padding: EdgeInsets.all(16),
            child: TextField(
                onChanged: (text) {
                  context.read<EmailCubit>().emailChanged(text);
                },
                decoration: InputDecoration(
                  errorText: error,
                  fillColor: context.colours.surface,
                )));
      }),
    );
  }
}
