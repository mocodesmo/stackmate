////

//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_test/flutter_test.dart';
//import 'package:sats/zold/model/identification.dart';
//import 'package:sats/zold/model/security.dart';
//import 'package:sats/zold/model/user.dart';
//import 'package:sats/pkg/tester.dart';
//import 'package:sats/zold/view/common/user-bloc/bloc.dart';
//import 'package:sats/zold/view/home-settings/page.dart';
//import 'package:mockito/mockito.dart';

//import 'package:bloc_test/bloc_test.dart';

//class _MockUserBloc extends MockBloc<UserEvent, UserState> implements UserBloc {
//}

//void main() {
//  setupDeviceSize();

//  group('Home Settings', () {
//    UserBloc bloc;

//    setUp(() {
//      bloc = _MockUserBloc();
//    });

//    tearDown(() {
//      bloc.close();
//    });

//    testWidgets(
//      'renders settings page properly',
//      (WidgetTester tester) async {
//        when(bloc.state).thenReturn(UserState(
//            authenticated: true,
//            user: User(
//              tfaStatus: false,
//              email: 'mj@mj.mj',
//              id: Identification(
//                idStatus: IdStatus.verified,
//              ),
//              security: Security(
//                enabled: [
//                  SecurityType.otp,
//                  SecurityType.tfa,
//                ],
//                selected: SecurityType.tfa,
//              ),
//            )));

//        await tester.pumpWidget(BlocProvider.value(
//            value: bloc,
//            child: MaterialApp(
//              home: new HomeSettingsPage(),
//            )));

//        await tester.pump();
//        expect(find.byKey(kSettingsHeader), findsOneWidget);

//        //await tester.scrollUntilVisible(find.byKey(kSettingsPinChangeCell), 50);
//        //await tester.pump();
//        //expect(find.byKey(kSettingsPinChangeCell), findsOneWidget);

//        await tester.scrollUntilVisible(find.byKey(kSupportCell), 50);
//        await tester.pump();
//        expect(find.byKey(kSupportCell), findsOneWidget);

//        await tester.scrollUntilVisible(find.byKey(kShareCell), 50);
//        await tester.pump();
//        expect(find.byKey(kShareCell), findsOneWidget);

//        await tester.scrollUntilVisible(find.byKey(kLogOutButton), 50);
//        await tester.pump();
//        expect(find.byKey(kLogOutButton), findsOneWidget);
//      },
//    );

//    testWidgets(
//      'renders settings with no security',
//      (WidgetTester tester) async {
//        when(bloc.state).thenReturn(UserState(
//            authenticated: true,
//            user: User(
//                tfaStatus: false,
//                email: 'mj@mj.mj',
//                id: Identification(
//                  idStatus: IdStatus.verified,
//                ),
//                security: Security())));

//        await tester.pumpWidget(BlocProvider.value(
//            value: bloc,
//            child: MaterialApp(
//              home: new HomeSettingsPage(),
//            )));
//        await tester.pumpAndSettle();

//        expect(find.byKey(kSecuritySetupCell), findsOneWidget);
//      },
//    );

//    //testWidgets(
//    //  'renders settings with low security',
//    //  (WidgetTester tester) async {
//    //    when(bloc.state).thenReturn(UserState(
//    //        authenticated: true,
//    //        user: User(
//    //          tfaStatus: false,
//    //          email: 'mj@mj.mj',
//    //          id: Identification(
//    //            idStatus: IdStatus.verified,
//    //          ),
//    //          security: Security(
//    //            enabled: [
//    //              SecurityType.otp,
//    //            ],
//    //            selected: SecurityType.otp,
//    //          ),
//    //        )));

//    //    await tester.pumpWidget(BlocProvider.value(
//    //        value: bloc,
//    //        child: MaterialApp(
//    //          home: new HomeSettingsPage(),
//    //        )));
//    //    await tester.pump();

//    //    expect(find.byKey(kSecurityLowCell), findsOneWidget);
//    //  },
//    //);

//    testWidgets(
//      'renders settings with max security',
//      (WidgetTester tester) async {
//        when(bloc.state).thenReturn(UserState(
//            authenticated: true,
//            user: User(
//              tfaStatus: true,
//              email: 'mj@mj.mj',
//              id: Identification(
//                idStatus: IdStatus.verified,
//              ),
//              security: Security(
//                enabled: [
//                  SecurityType.otp,
//                  SecurityType.tfa,
//                ],
//                selected: SecurityType.tfa,
//              ),
//            )));

//        await tester.pumpWidget(BlocProvider.value(
//            value: bloc,
//            child: MaterialApp(
//              home: new HomeSettingsPage(),
//            )));
//        await tester.pump();

//        expect(find.byKey(kSecurityMaxCell), findsOneWidget);
//      },
//    );

//    //testWidgets(
//    //  'renders settings with user id verified',
//    //  (WidgetTester tester) async {
//    //    when(bloc.state).thenReturn(UserState(
//    //        authenticated: true,
//    //        user: User(
//    //          email: 'mj@mj.mj',
//    //          id: Identification(idStatus: IdStatus.verified, name: 'mj'),
//    //          security: Security(
//    //            enabled: [
//    //              SecurityType.otp,
//    //              SecurityType.tfa,
//    //            ],
//    //            selected: SecurityType.tfa,
//    //          ),
//    //        )));

//    //    await tester.pumpWidget(BlocProvider.value(
//    //        value: bloc,
//    //        child: MaterialApp(
//    //          home: new HomeSettingsPage(),
//    //        )));
//    //    await tester.pump();

//    //    expect(find.byKey(kUserIdConfirmedCell), findsOneWidget);
//    //  },
//    //);

//    //testWidgets(
//    //  'renders settings with user id not verified',
//    //  (WidgetTester tester) async {
//    //    when(bloc.state).thenReturn(UserState(
//    //        authenticated: true,
//    //        user: User(
//    //          email: 'mj@mj.mj',
//    //          id: Identification(
//    //            idStatus: IdStatus.notVerified,
//    //          ),
//    //          security: Security(
//    //            enabled: [
//    //              SecurityType.otp,
//    //              SecurityType.tfa,
//    //            ],
//    //            selected: SecurityType.tfa,
//    //          ),
//    //        )));

//    //    await tester.pumpWidget(BlocProvider.value(
//    //        value: bloc,
//    //        child: MaterialApp(
//    //          home: new HomeSettingsPage(),
//    //        )));
//    //    await tester.pump();

//    //    expect(find.byKey(kUserIdNotVerifiedCell), findsOneWidget);
//    //  },
//    //);

//    //testWidgets(
//    //  'renders settings with user id in review',
//    //  (WidgetTester tester) async {
//    //    when(bloc.state).thenReturn(UserState(
//    //        authenticated: true,
//    //        user: User(
//    //          email: 'mj@mj.mj',
//    //          id: Identification(
//    //            idStatus: IdStatus.inReview,
//    //          ),
//    //          security: Security(
//    //            enabled: [
//    //              SecurityType.otp,
//    //              SecurityType.tfa,
//    //            ],
//    //            selected: SecurityType.tfa,
//    //          ),
//    //        )));

//    //    await tester.pumpWidget(BlocProvider.value(
//    //        value: bloc,
//    //        child: MaterialApp(
//    //          home: new HomeSettingsPage(),
//    //        )));
//    //    await tester.pump();

//    //    expect(find.byKey(kUserIdInReviewCell), findsOneWidget);
//    //  },
//    //);

//    //testWidgets(
//    //  'renders settings with user id ready',
//    //  (WidgetTester tester) async {
//    //    when(bloc.state).thenReturn(UserState(
//    //        authenticated: true,
//    //        user: User(
//    //          email: 'mj@mj.mj',
//    //          id: Identification(
//    //            idStatus: IdStatus.ready,
//    //            link: 'www',
//    //          ),
//    //          security: Security(
//    //            enabled: [
//    //              SecurityType.otp,
//    //              SecurityType.tfa,
//    //            ],
//    //            selected: SecurityType.tfa,
//    //          ),
//    //        )));

//    //    await tester.pumpWidget(BlocProvider.value(
//    //        value: bloc,
//    //        child: MaterialApp(
//    //          home: new HomeSettingsPage(),
//    //        )));
//    //    await tester.pump();

//    //    expect(find.byKey(kUserIdReadyCell), findsOneWidget);
//    //    //expect(find.byKey(kUserIdReadyButton), findsOneWidget);
//    //  },
//    //);

//    //testWidgets(
//    //  'renders settings with user id rejected',
//    //  (WidgetTester tester) async {
//    //    when(bloc.state).thenReturn(UserState(
//    //        authenticated: true,
//    //        user: User(
//    //          email: 'mj@mj.mj',
//    //          id: Identification(
//    //            idStatus: IdStatus.rejected,
//    //            rejectedReason: 'ohh',
//    //          ),
//    //          security: Security(
//    //            enabled: [
//    //              SecurityType.otp,
//    //              SecurityType.tfa,
//    //            ],
//    //            selected: SecurityType.tfa,
//    //          ),
//    //        )));

//    //    await tester.pumpWidget(BlocProvider.value(
//    //        value: bloc,
//    //        child: MaterialApp(
//    //          home: new HomeSettingsPage(),
//    //        )));
//    //    await tester.pump();

//    //    expect(find.byKey(kUserIdRejectedCell), findsOneWidget);
//    //    //expect(find.byKey(kUserIdRejectButton), findsOneWidget);
//    //  },
//    //);
//  });
//}
