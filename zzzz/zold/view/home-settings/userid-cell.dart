//import 'package:flutter/material.dart';
//import 'package:sats/zold/model/identification.dart';
//import 'package:sats/pkg/extensions.dart';
//import 'package:sats/zold/cubit/user.dart';
//import 'package:sats/zold/view/home-settings/settings-cell.dart';
//import 'package:sats/zold/view/home-settings/page.dart';

//class UserIDCell extends StatelessWidget {
//  const UserIDCell({Key? key}) : super(key: key);

//  @override
//  Widget build(BuildContext c) {
//    final id = c.select((UserBloc bloc) => bloc.state.user!.id);

//    if (id!.idStatus == IdStatus.verified) {
//      return SettingsCell(
//        title: 'USER IDENTIFICATION'.notLocalised(),
//        description: 'Welcome back,\n'.notLocalised() + id.name,
//        largeText: 'VERIFIED'.notLocalised(),
//        key: kUserIdConfirmedCell,
//        onTap: () {},
//      );
//    } else if (id.idStatus == IdStatus.ready)
//      return SettingsCell(
//        title: 'USER IDENTIFICATION'.notLocalised(),
//        description: 'Your documents\nhave been reviewed.'.notLocalised(),
//        largeText: 'READY\nTO CONFIRM'.notLocalised(),
//        key: kUserIdReadyCell,
//        onTap: () {},
//        alertColor: true,
//        bottomRowText: 'Please confirm that all information is accurate.',
//        bottomRowButtonText: 'REVIEW DOCUMENT INFORMATION',
//        bottomRowButtonPressed: () {},
//      );
//    else if (id.idStatus == IdStatus.rejected)
//      return SettingsCell(
//        title: 'USER IDENTIFICATION'.notLocalised(),
//        description: id.rejectedReason,
//        largeText: 'REJECTED'.notLocalised(),
//        key: kUserIdRejectedCell,
//        onTap: () {},
//        alertColor: true,
//        bottomRowText: 'Please submit your documents',
//        bottomRowButtonText: 'RESUBMIT KYC DOCUMENTS',
//        bottomRowButtonPressed: () {},
//      );
//    else if (id.idStatus == IdStatus.inReview)
//      return SettingsCell(
//        title: 'USER IDENTIFICATION'.notLocalised(),
//        description:
//            'Your document has been submitted.\nReview times can take upto 2 working days.'
//                .notLocalised(),
//        largeText: 'IN REVIEW'.notLocalised(),
//        key: kUserIdInReviewCell,
//        onTap: () {},
//      );
//    else if (id.idStatus == IdStatus.notVerified) {
//      return Container(
//          key: kUserIdNotVerifiedCell,
//          margin: EdgeInsets.all(8),
//          padding: EdgeInsets.all(16),
//          decoration: BoxDecoration(
//            color: c.colours.error.withAlpha(180),
//            borderRadius: BorderRadius.circular(16),
//          ),
//          child: Column(
//              mainAxisAlignment: MainAxisAlignment.start,
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              children: [
//                Row(children: [
//                  Expanded(
//                    child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//                          Text('USER VERIFICATION'.notLocalised(),
//                              style: c.fonts.subtitle2!.copyWith(
//                                  fontWeight: FontWeight.bold,
//                                  color: c.colours.surface)),
//                          SizedBox(height: 16),
//                          Text(
//                              'Submit KYC documents to\ndeposit and withdraw funds.'
//                                  .notLocalised(),
//                              style: c.fonts.caption!.copyWith(
//                                  fontWeight: FontWeight.bold,
//                                  color: c.colours.surface))
//                        ]),
//                  ),
//                  //Spacer(),
//                  Text('NOT\nVERIFIED'.notLocalised(),
//                      style:
//                          c.fonts.headline6!.copyWith(color: c.colours.surface),
//                      textAlign: TextAlign.end),
//                ]),
//                SizedBox(height: 16),
//                Text(
//                  'Bitcoin wallet services are already active\nand do not require government identification.',
//                  style: c.fonts.caption!.copyWith(color: c.colours.surface),
//                  textAlign: TextAlign.left,
//                ),
//                SizedBox(height: 24),
//                Text('UPLOAD KYC DOCUMENTS'.notLocalised(),
//                    style: c.fonts.button!.copyWith(
//                        color: c.colours.surface,
//                        decoration: TextDecoration.underline)),
//              ]));
//    }

//    return Container();
//  }
//}
