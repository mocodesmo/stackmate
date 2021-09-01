import 'package:flutter/material.dart';
//import 'package:sats/zold/model/zsecurity.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/zold/cubit/user.dart';
import 'package:sats/zold/view/security-page.dart';

class SecurityHomeCell extends StatelessWidget {
  const SecurityHomeCell({required this.type});

  final SecurityType type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      //final selected = state.user.security.selected == type;
      //var isComplete = state.user.security.enabled.contains(type);
      final isComplete = state.user!.tfaStatus;

      //if (type == SecurityType.tfa) isComplete = tfaIsComplete;

      String title = '';
      String description = '';

      //if (type == SecurityType.otp) {
      //  title = 'Basic Security'.notLocalised();
      //  description = 'One-Time Pin sent to\nregistered phone number';
      //} else if (type == SecurityType.tfa) {
      title = 'Maximum Security'.notLocalised();
      description = 'Two-Factor Authentication\nusing an authenticator app';
      //}

      String largeText = '';
      //Key? key;
      //if (selected) {
      //  largeText = 'SELECTED';
      //  if (type == SecurityType.otp) key = kSecurityHomeBasicSelected;
      //  if (type == SecurityType.tfa) key = kSecurityHomeMaxSelected;
      //} else {
      //if (isComplete) {
      //  //isComplete) {
      //  largeText = '';
      //  //if (type == SecurityT .ype.otp) key = kSecurityHomeBasicNotSelected;
      //  //if (type == SecurityType.tfa)
      //    //key = kSecurityHomeMaxSelected; //kSecurityHomeMaxNotSelected;
      //} else {
      //  largeText = 'SETUP';
      //  if (type == SecurityType.otp) key = kSecurityHomeBasicNotDone;
      //  if (type == SecurityType.tfa) key = kSecurityHomeMaxNotDone;
      //}
      //}

      String bottomRowText = '';
      //bool bottomRowRed = false;
      if (type == SecurityType.tfa) {
        if (isComplete) {
          bottomRowText = 'PRIVATE KEY:  SHARED';
        } else {
          bottomRowText = 'PRIVATE KEY:  NOT GENERATED';
          //bottomRowRed = true;
        }
      } else {
        if (isComplete) {
          //bottomRowText = 'SENDING TO:   ' + state.user!.security!.phoneNumber;
        }
      }

      return GestureDetector(
          onTap: () {
            if (isComplete) return;
            //if (selected) return;
            //if (type == SecurityType.otp) {}
            if (type == SecurityType.tfa) {
              Navigator.pushNamed(context, '/security-tfa');
            }
          },
          child: Container(
              key: key,
              width: context.width - 8,
              margin: EdgeInsets.symmetric(vertical: 2),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: context.colours.surface),
              child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(title,
                                      style: context.fonts.subtitle2!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(height: 4),
                                  Text(description,
                                      style: context.fonts.caption)
                                ]),
                          ),
                          //Spacer(),
                          Column(mainAxisAlignment: MainAxisAlignment.start,
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(largeText,
                                    style: context.fonts.headline6!.copyWith(
                                        color: !isComplete //!selected
                                            ? context.colours.error
                                            : null),
                                    textAlign: TextAlign.end)
                              ])
                        ]),
                    if (bottomRowText != '') ...[
                      SizedBox(height: 16),
                      Text(bottomRowText, style: context.fonts.caption)
                    ]
                  ])));
    });
  }
}

//class SecurityHomeCell extends StatelessWidget {
//  const SecurityHomeCell({
//    Key key,
//    @required this.title,
//    @required this.description,
//    @required this.largeText,
//    this.onTap,
//    this.alertColor = false,
//    this.bottomRowWidget,
//  }) : super(key: key);

//  final String title;
//  final String description;
//  final String largeText;
//  final bool alertColor;
//  final Function onTap;

//  final Widget bottomRowWidget;

//  @override
//  Widget build(BuildContext context) {
//    return Container(
//        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//        padding: EdgeInsets.all(16),
//        decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(2),
//            color: context.colours.surface),
//        child: Column(
//            mainAxisAlignment: MainAxisAlignment.start,
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            children: [
//              Row(
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: [
//                    Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//                          Text(title,
//                              style: context.fonts.subtitle2.copyWith(
//                                fontWeight: FontWeight.bold,
//                              )),
//                          Text(description,
//                              style: context.fonts.caption.copyWith(
//                                  color: alertColor
//                                      ? context.colours.error
//                                      : null))
//                        ]),
//                    Spacer(),
//                    Column(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        crossAxisAlignment: CrossAxisAlignment.end,
//                        children: [
//                          Text(largeText,
//                              style: context.fonts.headline6,
//                              textAlign: TextAlign.end),
//                          //if (comingSoon) ...[
//                          //  SizedBox(height: 8),
//                          //  Text('COMING SOON',
//                          //      style: context.fonts.bodyText2
//                          //          .copyWith(color: context.colours.error))
//                          //]
//                        ])
//                  ]),
//              if (bottomRowWidget != null) ...[
//                SizedBox(height: 16),
//                Text(bottomRowText, style: context.fonts.caption)
//              ],
//            ]));
//  }
//}
