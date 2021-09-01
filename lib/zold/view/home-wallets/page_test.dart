////

//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_test/flutter_test.dart';
//import 'package:bloc_test/bloc_test.dart';
//import 'package:mockito/mockito.dart';
//import 'package:sats/zold/model/btc-wallet.dart';
//import 'package:sats/zold/model/wallet.dart';
//import 'package:sats/pkg/tester.dart';
//import 'package:sats/zold/view/common/wallet-bloc/bloc.dart';
//import 'package:sats/zold/view/home-wallets/page.dart';

//class _MockWalletBloc extends MockBloc<WalletEvent, WalletState>
//    implements WalletBloc {}

//void main() {
//  setupDeviceSize();

//  WalletBloc bloc;
//  group('Home Wallets', () {
//    setUp(() {
//      bloc = _MockWalletBloc();
//    });

//    tearDown(() {
//      bloc.close();
//    });

//    //testWidgets(
//    //  'should show inr card not active',
//    //  (WidgetTester tester) async {
//    //    when(bloc.state).thenReturn(WalletState(
//    //        wallet: Wallet(
//    //      inrActive: false,
//    //      btcWallet: BtcWallet(satsBalance: 100000),
//    //    )));

//    //    await tester.pumpWidget(BlocProvider.value(
//    //        value: bloc, child: MaterialApp(home: new HomeWalletsPage())));
//    //    await tester.pump();

//    //    expect(find.byKey(kHomeWalletsInactiveInrCard), findsOneWidget);
//    //  },
//    //);

//    //testWidgets(
//    //  'should show inr card with no balance',
//    //  (WidgetTester tester) async {
//    //    when(bloc.state).thenReturn(WalletState(
//    //      wallet: Wallet(
//    //        inrActive: true,
//    //        inrWallet: InrWallet(balance: 0),
//    //        btcWallet: BtcWallet(satsBalance: 100000),
//    //      ),
//    //    ));

//    //    await tester.pumpWidget(BlocProvider.value(
//    //        value: bloc, child: MaterialApp(home: new HomeWalletsPage())));
//    //    await tester.pump();

//    //    expect(find.byKey(kHomeWalletsActiveEmptyInrCard), findsOneWidget);
//    //  },
//    //);

//    //testWidgets(
//    //  'should show inr card with balance',
//    //  (WidgetTester tester) async {
//    //    when(bloc.state).thenReturn(WalletState(
//    //      wallet: Wallet(
//    //        inrActive: true,
//    //        inrWallet: InrWallet(balance: 1000.0),
//    //        btcWallet: BtcWallet(satsBalance: 100000),
//    //      ),
//    //    ));

//    //    await tester.pumpWidget(BlocProvider.value(
//    //        value: bloc, child: MaterialApp(home: new HomeWalletsPage())));
//    //    await tester.pump();

//    //    expect(find.byKey(kHomeWalletsActiveInrCard), findsOneWidget);
//    //  },
//    //);

//    testWidgets(
//      'should show btc wallet with no balance',
//      (WidgetTester tester) async {
//        when(bloc.state).thenReturn(WalletState(
//            wallet: Wallet(
//          inrActive: false,
//          btcWallet: BtcWallet(
//              bech32: '', created: 1, p2pkh: '', p2sh: '', satsBalance: 0),
//        )));

//        await tester.pumpWidget(BlocProvider.value(
//            value: bloc, child: MaterialApp(home: new HomeWalletsPage())));
//        await tester.pump();

//        expect(find.byKey(kHomeWalletsEmptyBtcCard), findsOneWidget);
//      },
//    );

//    testWidgets(
//      'should show btc wallet with balance',
//      (WidgetTester tester) async {
//        when(bloc.state).thenReturn(WalletState(
//            wallet: Wallet(
//          inrActive: false,
//          btcWallet: BtcWallet(
//              bech32: '', created: 1, p2pkh: '', p2sh: '', satsBalance: 100000),
//        )));

//        await tester.pumpWidget(BlocProvider.value(
//            value: bloc, child: MaterialApp(home: new HomeWalletsPage())));
//        await tester.pump();

//        expect(find.byKey(kHomeWalletsNotEmptyBtcCard), findsOneWidget);
//      },
//    );

//    testWidgets(
//      'should show loading wallets',
//      (WidgetTester tester) async {
//        when(bloc.state).thenReturn(WalletState(
//            loadingWallets: true,
//            wallet: Wallet(
//              inrActive: false,
//              btcWallet: BtcWallet(
//                  bech32: '',
//                  created: 1,
//                  p2pkh: '',
//                  p2sh: '',
//                  satsBalance: 100000),
//            )));
//        await tester.pumpWidget(
//          BlocProvider.value(
//              value: bloc,
//              child: MaterialApp(
//                home: new HomeWalletsPage(),
//              )),
//        );
//        await tester.pump();

//        expect(find.byKey(kHomeWalletsLoader), findsOneWidget);
//      },
//    );
//  });
//}
