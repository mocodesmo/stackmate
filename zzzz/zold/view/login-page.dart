// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/view/common/header-text.dart';
// import 'package:sats/zold/view/common/header.dart';
// import 'package:sats/zold/cubit/user.dart';
// import 'package:sats/zold/cubit/email-login.dart';
// import 'package:sats/zold/view/common/loading.dart';
// import 'package:sats/zold/view/email-login/button.dart';
// import 'package:sats/zold/view/email-login/email-field.dart';
// import 'package:sats/zold/view/email-login/header.dart';
// import 'package:sats/zold/view/email-login/policy-text.dart';
// import 'package:sats/zold/view/home-settings/testnet-cell.dart';

// class EmailLoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext c) {
//     return BlocListener<EmailCubit, EmailState>(listener: (context, state) {
//       if (state.loggedIn) c.read<UserCubit>().getUser();
//     }, child: BlocBuilder<UserCubit, UserState>(builder: (context, userState) {
//       return Scaffold(
//           body: SafeArea(
//               bottom: false,
//               child: SingleChildScrollView(
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                     if (userState.gettingUser || userState.authenticated) ...[
//                       Header(cornerTitle: 'STACKMATE', children: [
//                         SizedBox(height: 24),
//                         HeaderText(text: 'Logging In')
//                       ]),
//                       Loading(text: ''),
//                       //SizedBox(height: 48),
//                       ////Spacer(),
//                       //Center(
//                       //    child: Loading(
//                       //        text: 'Authenticating ..'.notLocalised())),
//                       SizedBox(height: 80),
//                       //Spac,'er(),
//                     ] else if (userState.errorOnGet != '') ...[
//                       Header(cornerTitle: 'STACKMATE', children: [
//                         SizedBox(height: 24),
//                         HeaderText(text: 'Login Error')
//                       ]),
//                       SizedBox(height: 48),
//                       //Spacer(),
//                       Center(
//                           child: Text(userState.errorOnGet,
//                               style: c.fonts.headline6)),
//                       SizedBox(height: 16),
//                       Center(
//                           child: GestureDetector(
//                               onTap: () {
//                                 c.read<UserCubit>().getUser();
//                               },
//                               child: Text('Retry',
//                                   style: c.fonts.button!.copyWith(
//                                       color: c.colours.primaryVariant)))),
//                       SizedBox(height: 80),
//                     ] else ...[
//                       EmailTitle(),
//                       SizedBox(height: 8),
//                       TestNetCell(isHome: true),
//                       SizedBox(height: 32),
//                       EmailField(),
//                       SizedBox(height: 48),
//                       EmailButton(),
//                       SizedBox(height: 56),
//                       PolicyText(),
//                       SizedBox(height: 48),
//                     ]
//                   ]))));
//     }));
//   }
// }
