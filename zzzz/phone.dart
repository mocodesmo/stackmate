//import 'package:sats/view/authentication/bloc/phone_bloc.dart';
//import 'package:sats/view/authentication/phone_field.dart';
//import 'package:sats/view/authentication/phone_otp_field.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';

//class Phone extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return BlocBuilder<PhoneBloc, PhoneState>(builder: (context, phoneState) {
//      return Expanded(
//          child: Column(children: [
//        Spacer(),
//        if (phoneState.showPhoneField) PhoneField(),
//        if (phoneState.showPhoneOtpField) PhoneOtpField(),
//        if (phoneState.showLoading) Center(child: CircularProgressIndicator()),
//        Spacer(),
//        if (phoneState.showButton)
//          ElevatedButton(
//              onPressed: () {
//                if (!phoneState.otpSent)
//                  context.read<PhoneBloc>().add(SendOtp());
//                else
//                  context.read<PhoneBloc>().add(VerifyOtp());
//              },
//              style: ElevatedButton.styleFrom(
//                  elevation: 0,
//                  primary: Theme.of(context).colorScheme.primary,
//                  shape: RoundedRectangleBorder()),
//              child: Container(
//                  height: 44,
//                  child: Expanded(
//                      child: Center(
//                          child: Text(
//                    phoneState.buttonText,
//                    style: Theme.of(context).textTheme.button.copyWith(
//                        color: Theme.of(context).colorScheme.onPrimary),
//                  )))))
//      ]));
//    });
//  }
//}
