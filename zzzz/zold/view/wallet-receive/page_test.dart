////

//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_test/flutter_test.dart';
//import 'package:sats/zold/model/btc-wallet.dart';
//import 'package:sats/zold/model/wallet.dart';
//import 'package:sats/pkg/tester.dart';
//import 'package:bloc_test/bloc_test.dart';
//import 'package:mockito/mockito.dart';
//import 'package:sats/zold/view/btc-receive/page.dart';
//import 'package:sats/zold/view/common/wallet-bloc/bloc.dart';

//class _MockWalletBloc extends MockBloc<WalletEvent, WalletState>
//    implements WalletBloc {}

//void main() {
//  setupDeviceSize();

//  group('BTC receive', () {
//    WalletBloc bloc;
//    setUp(() {
//      bloc = _MockWalletBloc();
//    });

//    tearDown(() {
//      bloc.close();
//    });

//    testWidgets('should show only p2sh open', (WidgetTester tester) async {
//      when(bloc.state).thenReturn(WalletState(
//          wallet: Wallet(
//              btcWallet: BtcWallet(
//                  created: 1,
//                  satsBalance: 0,
//                  bech32: 'abc',
//                  p2pkh: 'xyz',
//                  p2sh: 'pqr'))));

//      await tester.pumpWidget(BlocProvider.value(
//          value: bloc, child: MaterialApp(home: new BtcReceivePage())));
//      await tester.pump();

//      expect(find.byKey(kBtcp2sOpen), findsOneWidget);
//      expect(find.byKey(kbtcb3Closed), findsOneWidget);
//      expect(find.byKey(kbtcp2pClosed), findsOneWidget);
//    });

//    testWidgets('should show only bech32 open', (WidgetTester tester) async {
//      when(bloc.state).thenReturn(WalletState(
//          wallet: Wallet(
//              btcWallet: BtcWallet(
//                  created: 1,
//                  satsBalance: 0,
//                  bech32: 'abc',
//                  p2pkh: 'xyz',
//                  p2sh: 'pqr'))));

//      await tester.pumpWidget(BlocProvider.value(
//          value: bloc, child: MaterialApp(home: new BtcReceivePage())));
//      await tester.pump();

//      expect(find.byKey(kBtcp2sOpen), findsOneWidget);
//      expect(find.byKey(kbtcb3Closed), findsOneWidget);
//      expect(find.byKey(kbtcp2pClosed), findsOneWidget);

//      await tester.tap(find.byKey(kbtcb3Closed));
//      await tester.pump();

//      expect(find.byKey(kBtcp2sClosed), findsOneWidget);
//      expect(find.byKey(kBtcb3Open), findsOneWidget);
//      expect(find.byKey(kbtcp2pClosed), findsOneWidget);
//    });

//    testWidgets('should show only p2pkh open', (WidgetTester tester) async {
//      when(bloc.state).thenReturn(WalletState(
//          wallet: Wallet(
//              btcWallet: BtcWallet(
//                  satsBalance: 0,
//                  created: 1,
//                  bech32: 'abc',
//                  p2pkh: 'xyz',
//                  p2sh: 'pqr'))));

//      await tester.pumpWidget(BlocProvider.value(
//          value: bloc, child: MaterialApp(home: new BtcReceivePage())));
//      await tester.pump();

//      expect(find.byKey(kBtcp2sOpen), findsOneWidget);
//      expect(find.byKey(kbtcb3Closed), findsOneWidget);
//      expect(find.byKey(kbtcp2pClosed), findsOneWidget);

//      await tester.tap(find.byKey(kbtcp2pClosed));
//      await tester.pump();

//      expect(find.byKey(kBtcp2sClosed), findsOneWidget);
//      expect(find.byKey(kbtcb3Closed), findsOneWidget);
//      expect(find.byKey(kBtcp2pOpen), findsOneWidget);
//    });
//  });
//}
