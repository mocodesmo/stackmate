//import 'package:sats/view/authentication/bloc/phone_bloc.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';

//class PhoneField extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final phoneNumberError =
//        context.select((PhoneBloc bloc) => bloc.state.phoneNumberError);

//    return Padding(
//        padding: const EdgeInsets.all(8.0),
//        child: TextField(
//            onChanged: (value) {
//              context.read<PhoneBloc>().add(PhoneNumberChanged(value));
//            },
//            decoration: InputDecoration(
//              errorText: phoneNumberError != '' ? phoneNumberError : null,
//              enabledBorder: OutlineInputBorder(
//                borderRadius: BorderRadius.circular(4),
//                borderSide: BorderSide.none,
//              ),
//              prefixText: '+91 | ',
//              filled: true,
//              fillColor: Theme.of(context).colorScheme.background,
//              focusColor: Theme.of(context).colorScheme.background,
//            )));
//  }
//}
