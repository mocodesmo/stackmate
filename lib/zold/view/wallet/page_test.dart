////

//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_test/flutter_test.dart';
//import 'package:sats/zold/model/btc-transaction.dart';
//import 'package:sats/zold/model/btc-wallet.dart';
//import 'package:sats/zold/model/inr-wallet.dart';
//import 'package:sats/zold/model/wallet.dart';
//import 'package:sats/pkg/tester.dart';
//import 'package:sats/zold/view/btc-wallet/page.dart';
//import 'package:sats/zold/view/common/wallet-bloc/bloc.dart';
//import 'package:mockito/mockito.dart';
//import 'package:bloc_test/bloc_test.dart';

//class _MockWalletBloc extends MockBloc<WalletEvent, WalletState>
//    implements WalletBloc {}

//void main() {
//  setupDeviceSize();

//  group('BTC Wallet', () {
//    WalletBloc bloc;

//    setUp(() {
//      bloc = _MockWalletBloc();
//    });

//    tearDown(() {
//      bloc.close();
//    });

//    testWidgets(
//      'should render wallet page properly with all transaction types',
//      (WidgetTester tester) async {
//        when(bloc.state).thenReturn(WalletState(
//            wallet: Wallet(
//                inrActive: true,
//                inrWallet: InrWallet(balance: 1000.0),
//                btcWallet: BtcWallet(
//                    p2sh: '',
//                    p2pkh: '',
//                    bech32: '',
//                    created: 1,
//                    satsBalance: 100000,
//                    transactions: [
//                      //BtcOrder(orderType: BtcOrderType.buy),
//                      //BtcOrder(orderType: BtcOrderType.sell),
//                      BtcOrder(
//                          confirmed: true,
//                          currency: '',
//                          confirmations: 1,
//                          genesis: 1,
//                          counterParty: '',
//                          comment: '',
//                          feeSats: 1,

//                          //orderType: BtcOrderType.receive,
//                          satsAmount: 9999999,
//                          txId: 'iiii',
//                          type: 'in'),
//                      BtcOrder(
//                          confirmed: true,
//                          currency: '',
//                          confirmations: 1,
//                          genesis: 1,
//                          counterParty: '',
//                          comment: '',
//                          feeSats: 1,
//                          //orderType: BtcOrderType.send,
//                          satsAmount: 999999,
//                          txId: 'uuuuu',
//                          type: 'out')
//                    ]))));

//        await tester.pumpWidget(BlocProvider.value(
//            value: bloc, child: MaterialApp(home: new BtcWalletPage())));
//        await tester.pump();

//        expect(find.byKey(kBtcWalletHeader), findsOneWidget);

//        expect(find.byKey(kBtcWalletReceiveButton), findsOneWidget);
//        expect(find.byKey(kBtcWalletSendButtonActive), findsOneWidget);

//        //expect(find.byKey(kBtcWalletBuyCell), findsOneWidget);
//        //expect(find.byKey(kBtcWalletSellCell), findsOneWidget);
//        expect(find.byKey(kBtcWalletReceiveCell), findsOneWidget);
//        expect(find.byKey(kBtcWalletSendCell), findsOneWidget);
//      },
//    );

//    testWidgets(
//      'should show no transactions',
//      (WidgetTester tester) async {
//        when(bloc.state).thenReturn(WalletState(
//            wallet: Wallet(
//                inrActive: true,
//                inrWallet: InrWallet(balance: 1000.0),
//                btcWallet: BtcWallet(
//                    p2sh: '',
//                    p2pkh: '',
//                    bech32: '',
//                    created: 1,
//                    satsBalance: 200000,
//                    transactions: []))));

//        await tester.pumpWidget(BlocProvider.value(
//            value: bloc, child: MaterialApp(home: new BtcWalletPage())));
//        await tester.pump();

//        expect(find.byKey(kBtcWalletHeader), findsOneWidget);
//        //expect(find.byKey(kBtcWalletBuyButtonActive), findsOneWidget);
//        //expect(find.byKey(kBtcWalletSellButtonActive), findsOneWidget);
//        //expect(find.byKey(kBtcWalletReceiveButton), findsOneWidget);
//        //expect(find.byKey(kBtcWalletSendButtonActive), findsOneWidget);

//        expect(find.byKey(kBtcWalletNoTransactions), findsOneWidget);
//      },
//    );

//    //testWidgets(
//    //  'should show no fiat balance',
//    //  (WidgetTester tester) async {
//    //    when(bloc.state).thenReturn(WalletState(
//    //        wallet: Wallet(
//    //            inrActive: true,
//    //            inrWallet: InrWallet(balance: 0.0),
//    //            btcWallet: BtcWallet(satsBalance: 200000, transactions: []))));

//    //    await tester.pumpWidget(BlocProvider.value(
//    //        value: bloc, child: MaterialApp(home: new BtcWalletPage())));
//    //    await tester.pump();

//    //    expect(find.byKey(kBtcWalletHeader), findsOneWidget);
//    //    expect(find.byKey(kBtcWalletBuyButtonDisabled), findsOneWidget);
//    //    expect(find.byKey(kBtcWalletSellButtonActive), findsOneWidget);
//    //    expect(find.byKey(kBtcWalletReceiveButton), findsOneWidget);
//    //    expect(find.byKey(kBtcWalletSendButtonActive), findsOneWidget);

//    //    expect(find.byKey(kBtcWalletNoTransactions), findsOneWidget);
//    //  },
//    //);

//    //testWidgets(
//    //  'should show no balance',
//    //  (WidgetTester tester) async {
//    //    when(bloc.state).thenReturn(WalletState(
//    //        wallet: Wallet(
//    //            inrActive: true,
//    //            inrWallet: InrWallet(balance: 10000.0),
//    //            btcWallet: BtcWallet(satsBalance: 0, transactions: []))));

//    //    await tester.pumpWidget(BlocProvider.value(
//    //        value: bloc, child: MaterialApp(home: new BtcWalletPage())));
//    //    await tester.pump();

//    //    expect(find.byKey(kBtcWalletHeader), findsOneWidget);
//    //    expect(find.byKey(kBtcWalletBuyButtonActive), findsOneWidget);
//    //    expect(find.byKey(kBtcWalletSellButtonDisabled), findsOneWidget);
//    //    expect(find.byKey(kBtcWalletReceiveButton), findsOneWidget);
//    //    expect(find.byKey(kBtcWalletSendButtonDisabled), findsOneWidget);

//    //    expect(find.byKey(kBtcWalletNoTransactions), findsOneWidget);
//    //  },
//    //);
//  });
//}
