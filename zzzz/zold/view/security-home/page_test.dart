//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_test/flutter_test.dart';
//import 'package:sats/zold/model/identification.dart';
//import 'package:sats/zold/model/security.dart';
//import 'package:sats/zold/model/user.dart';
//import 'package:sats/pkg/tester.dart';
//import 'package:sats/zold/cubit/user.dart';
//import 'package:sats/zold/view/security-home/page.dart';
//import 'package:mockito/mockito.dart';
//import 'package:bloc_test/bloc_test.dart';

//class _MockUserBloc extends MockBloc<UserState> implements UserBloc {}

//void main() {
//  setupDeviceSize();

//  group('Security Home', () {
//    UserBloc? bloc;
//    setUp(() {
//      bloc = _MockUserBloc();
//    });

//    tearDown(() {
//      bloc!.close();
//    });

//    testWidgets(
//      'renders page with no security completed',
//      (WidgetTester tester) async {
//        whenListen(
//            bloc!,
//            Stream.fromIterable([
//              UserState(
//                  authenticated: true,
//                  user: User(
//                      locked: false,
//                      pinStatus: true,
//                      tfaStatus: false,
//                      email: 'mj@mj.mj',
//                      id: Identification(idStatus: IdStatus.ready, name: 'mj'),
//                      security: Security(selected: SecurityType.none)))
//            ]));

//        //when(bloc!.state).thenReturn(UserState(
//        //    authenticated: true,
//        //    user: User(
//        //        locked: false,
//        //        pinStatus: true,
//        //        tfaStatus: false,
//        //        email: 'mj@mj.mj',
//        //        id: Identification(idStatus: IdStatus.ready, name: 'mj'),
//        //        security: Security(selected: SecurityType.none))));

//        await tester.pumpWidget(BlocProvider.value(
//            value: bloc!,
//            child: MaterialApp(
//              home: new SecurityHomePage(),
//            )));
//        await tester.pump();

//        expect(find.byKey(kSecurityHomeTitle), findsOneWidget);
//        //expect(find.byKey(kSecurityHomeBasicNotDone), findsOneWidget);
//        expect(find.byKey(kSecurityHomeMaxNotDone), findsOneWidget);
//      },
//    );

//    //testWidgets(
//    //  'renders page with only basic security',
//    //  (WidgetTester tester) async {
//    //    when(bloc.state).thenReturn(UserState(
//    //        authenticated: true,
//    //        user: User(
//    //            tfaStatus: true,
//    //            email: 'mj@mj.mj',
//    //            id: Identification(idStatus: IdStatus.ready, name: 'mj'),
//    //            security: Security(
//    //                enabled: [SecurityType.otp],
//    //                selected: SecurityType.otp,
//    //                phoneNumber: '+91 9999999999'))));

//    //    await tester.pumpWidget(BlocProvider.value(
//    //        value: bloc,
//    //        child: MaterialApp(
//    //          home: new SecurityHomePage(),
//    //        )));
//    //    await tester.pump();

//    //    expect(find.byKey(kSecurityHomeTitle), findsOneWidget);
//    //    expect(find.byKey(kSecurityHomeBasicSelected), findsOneWidget);
//    //    expect(find.byKey(kSecurityHomeMaxNotDone), findsOneWidget);
//    //  },
//    //);

//    testWidgets(
//      'renders page with max security selected',
//      (WidgetTester tester) async {
//        when(bloc!.state).thenReturn(UserState(
//            authenticated: true,
//            user: User(
//                locked: false,
//                pinStatus: true,
//                email: 'mj@mj.mj',
//                tfaStatus: true,
//                id: Identification(idStatus: IdStatus.ready, name: 'mj'),
//                security: Security(
//                    enabled: [SecurityType.otp, SecurityType.tfa],
//                    selected: SecurityType.tfa,
//                    phoneNumber: '+91 9999999999'))));

//        await tester.pumpWidget(BlocProvider.value(
//            value: bloc!,
//            child: MaterialApp(
//              home: new SecurityHomePage(),
//            )));
//        await tester.pump();

//        expect(find.byKey(kSecurityHomeTitle), findsOneWidget);
//        //expect(find.byKey(kSecurityHomeBasicNotSelected), findsOneWidget);
//        //expect(find.byKey(kSecurityHomeMaxSelected), findsOneWidget);
//        expect(find.byKey(kSecurityHomeMaxSelected), findsOneWidget);
//      },
//    );

//    //testWidgets(
//    //  'renders page with max security but basic selected',
//    //  (WidgetTester tester) async {
//    //    when(bloc.state).thenReturn(UserState(
//    //        authenticated: true,
//    //        user: User(
//    //            tfaStatus: true,
//    //            email: 'mj@mj.mj',
//    //            id: Identification(idStatus: IdStatus.ready, name: 'mj'),
//    //            security: Security(
//    //                enabled: [SecurityType.otp, SecurityType.tfa],
//    //                selected: SecurityType.otp,
//    //                phoneNumber: '+91 9999999999'))));

//    //    await tester.pumpWidget(BlocProvider.value(
//    //        value: bloc,
//    //        child: MaterialApp(
//    //          home: new SecurityHomePage(),
//    //        )));
//    //    await tester.pump();

//    //    expect(find.byKey(kSecurityHomeTitle), findsOneWidget);
//    //    expect(find.byKey(kSecurityHomeBasicSelected), findsOneWidget);
//    //    expect(find.byKey(kSecurityHomeMaxNotSelected), findsOneWidget);
//    //  },
//    //);
//  });
//}
