//import 'package:sats/view/authentication/authtype_tab.dart';
//import 'package:sats/view/authentication/bloc/auth_bloc.dart';
//import 'package:sats/view/authentication/bloc/email_bloc.dart';
//import 'package:sats/view/authentication/bloc/phone_bloc.dart';
//import 'package:sats/view/authentication/email.dart';
//import 'package:sats/view/authentication/phone.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';

//class AuthBox extends StatelessWidget {
//  const AuthBox({Key key}) : super(key: key);

//  @override
//  Widget build(BuildContext context) {
//    return BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
//   return BlocBuilder<EmailBloc, EmailState>(
//            buildWhen: (previous, current) {
//          return previous.sendingEmail != current.sendingEmail ||
//              previous.checkingLink != current.checkingLink;
//        }, builder: (context, emailState) {
//          final showTabs = !phoneState.otpSent ||
//              !phoneState.sendingOtp ||
//              !phoneState.otpVerified ||
//              !emailState.emailSent ||
//              !emailState.sendingEmail ||
//              !emailState.checkingLink;

//          final showLoading = phoneState.sendingOtp ||
//              emailState.sendingEmail ||
//              emailState.checkingLink;

//          return Material(
//              elevation: 4,
//              borderRadius: BorderRadius.circular(4),
//              child: AnimatedContainer(
//                  duration: Duration(milliseconds: 400),
//                  height: showLoading
//                      ? MediaQuery.of(context).size.height / 3
//                      : MediaQuery.of(context).size.height / 4,
//                  child: Column(
//                    children: [
//                      SizedBox(height: 8),
//                      if (showTabs) ...[AuthTypeTab(), SizedBox(height: 8)],
//                      if (authState.loginType == LoginType.phone) Phone(),
//                      if (authState.loginType == LoginType.email) Email()
//                    ],
//                  )));
//        });
//      });
//    });
//  }
//}
