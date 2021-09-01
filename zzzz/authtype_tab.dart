//import 'package:sats/view/authentication/bloc/auth_bloc.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';

//class AuthTypeTab extends StatelessWidget {
//  AuthTypeTab({Key key}) : super(key: key);

//  @override
//  Widget build(BuildContext context) {
//    final loginType = context.select((AuthBloc bloc) => bloc.state.loginType);

//    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//      GestureDetector(
//          onTap: () {
//            if (loginType != LoginType.phone)
//              context.read<AuthBloc>().add(ChangeLoginType(LoginType.phone));
//          },
//          child: Text('Phone Number',
//              style: Theme.of(context).textTheme.button.copyWith(
//                  color: loginType != LoginType.phone
//                      ? Theme.of(context).colorScheme.primaryVariant
//                      : null))),
//      GestureDetector(
//          onTap: () {
//            if (loginType != LoginType.email)
//              context.read<AuthBloc>().add(ChangeLoginType(LoginType.email));
//          },
//          child: Text('Email Address',
//              style: Theme.of(context).textTheme.button.copyWith(
//                  color: loginType != LoginType.email
//                      ? Theme.of(context).colorScheme.primaryVariant
//                      : null)))
//    ]);
//  }
//}
