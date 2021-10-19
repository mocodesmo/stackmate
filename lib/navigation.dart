import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sats/api/rates.dart';
import 'package:sats/api/reddit.dart';
import 'package:sats/cubit/_state.dart';
import 'package:sats/cubit/calculator.dart';
import 'package:sats/cubit/new-wallet/network.dart';
import 'package:sats/cubit/new-wallet/seed-generate.dart';
import 'package:sats/cubit/new-wallet/seed-import.dart';
import 'package:sats/cubit/new-wallet/xpub-import.dart';
import 'package:sats/cubit/reddit.dart';
import 'package:sats/cubit/wallet/receive.dart';
import 'package:sats/cubit/wallet/send.dart';
import 'package:sats/cubit/wallet/wallet.dart';
import 'package:sats/pkg/_deps.dart';
import 'package:sats/pkg/bitcoin.dart';
import 'package:sats/pkg/clipboard.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/pkg/launcher.dart';
import 'package:sats/pkg/share.dart';
import 'package:sats/pkg/storage.dart';
import 'package:sats/pkg/vibrate.dart';
import 'package:sats/view/add-wallet-page.dart';
import 'package:sats/view/address-book-page.dart';
import 'package:sats/view/calculator-page.dart';
import 'package:sats/view/home-page.dart';
import 'package:sats/view/logs-page.dart';
import 'package:sats/view/qr-page.dart';
import 'package:sats/view/settings-page.dart';
import 'package:sats/view/wallet-new-seedgenerate-page.dart';
import 'package:sats/view/wallet-new-seedimport-page.dart';
import 'package:sats/view/wallet-new-xpub-page.dart';
import 'package:sats/view/wallet-page.dart';
import 'package:sats/view/wallet-receive-page.dart';
import 'package:sats/view/wallet-send-page.dart';

class Routes {
  static const home = '/';
  static const addWallet = 'add-wallet';
  static const generateSeed = 'generate-seed';
  static const importSeed = 'import-seed';
  static const watchOnly = 'watch-only';
  static const calc = 'calc';
  static const setting = 'settings';
  static const logs = 'logs';
  static const wallet = 'wallet';
  static const receive = 'receive';
  static const send = 'send';
  static const sendFromQR = 'send-from-qr';
  static const qr = 'qr';
  static const addressBook = 'address-book';

  static Route<dynamic>? setupRoutes(RouteSettings settings, BuildContext c) {
    Widget page = Container();

    switch (settings.name) {
      case home:
        final redditBloc = RedditCubit(
          locator<IRedditAPI>(),
          loggerCubit,
          locator<ILauncher>(),
          // locator<IStorage>(),
        );

        page = BlocProvider.value(
          value: redditBloc,
          child: NewHomePage(),
        );

        break;

      case Routes.addWallet:
        page = const AddWalletPage();
        break;

      case generateSeed:
        final networkCubit = NetworkCubit(loggerCubit);
        final seedGenerateCubit = SeedGenerateCubit(
          networkCubit,
          locator<IBitcoin>(),
          locator<IStorage>(),
          // walletCubit,
          // testNetCubit,
          loggerCubit,
          walletsCubit,
          blockchainCubit,
        );

        page = MultiBlocProvider(
          providers: [
            BlocProvider.value(value: networkCubit),
            BlocProvider.value(value: seedGenerateCubit)
          ],
          child: SeedGeneratePage(),
        );
        break;

      case importSeed:
        final networkCubit = NetworkCubit(loggerCubit);
        final seedImportCubit = SeedImportCubit(
          networkCubit,
          locator<IBitcoin>(),
          locator<IStorage>(),
          // walletCubit,
          // testNetCubit,
          walletsCubit,
          blockchainCubit,
          loggerCubit,
        );

        page = MultiBlocProvider(
          providers: [
            BlocProvider.value(value: networkCubit),
            BlocProvider.value(value: seedImportCubit)
          ],
          child: SeedImportPage(),
        );
        break;

      case watchOnly:
        final xpubCubit = XpubImportCubit(
          locator<IBitcoin>(),
          loggerCubit,
          locator<IClipBoard>(),
          locator<IStorage>(),
          walletsCubit,
          blockchainCubit,
        );

        page = BlocProvider.value(
          value: xpubCubit,
          child: XpubImportPage(),
        );
        break;

      case calc:
        final calcCubit = CalculatorCubit(
          // locator<IStorage>(),
          loggerCubit,
          locator<IVibrate>(),
          locator<IRatesAPI>(),
        );

        page = BlocProvider.value(
          value: calcCubit,
          child: const CalcPage(),
        );
        break;

      case setting:
        page = const SettingsPage();
        break;

      case logs:
        page = BlocProvider.value(
          value: loggerCubit,
          child: LogsPage(),
        );

        break;

      case wallet:
        final history = WalletCubit(
          walletsCubit,
          // locator<IBitcoin>(),
          locator<IStorage>(),
          loggerCubit,
          // blockchainCubit,
          locator<ILauncher>(),
          locator<IShare>(),
          locator<IVibrate>(),
          nodeAddressCubit,
        );

        page = BlocProvider.value(
          value: history,
          child: const WalletPage(),
        );

        // scheduleMicrotask(() async {
        //   await Future.delayed(const Duration(milliseconds: 1000));
        //   history.getHistory();
        // });

        break;

      case receive:
        final r = ReceiveCubit(
          walletsCubit,
          // locator<IBitcoin>(),
          blockchainCubit,
          loggerCubit,
          locator<IClipBoard>(),
          locator<IShare>(),
          locator<IVibrate>(),
          nodeAddressCubit,
        );

        page = BlocProvider.value(
          value: r,
          child: const ReceivePage(),
        );
        break;

      case send:
        final s = SendCubit(
          false,
          walletsCubit,
          // locator<IBitcoin>(),
          blockchainCubit,
          loggerCubit,
          locator<IClipBoard>(),
          locator<IShare>(),
          nodeAddressCubit,
        );

        page = BlocProvider.value(
          value: s,
          child: const WalletSendPage(),
        );

        break;

      case sendFromQR:
        final s = SendCubit(
          true,
          walletsCubit,
          // locator<IBitcoin>(),
          blockchainCubit,
          loggerCubit,
          locator<IClipBoard>(),
          locator<IShare>(),
          nodeAddressCubit,
        );

        page = BlocProvider.value(
          value: s,
          child: const WalletSendPage(),
        );

        break;

      case qr:
        page = const QRPage();
        break;

      case addressBook:
        page = const AddressBookPage();
        break;
    }

    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (_, anim, anim2, child) {
        return FadeThroughTransition(
          fillColor: Colors.transparent,
          animation: anim,
          secondaryAnimation: anim2,
          child: child,
        );
      },
    );

    // return CupertinoPageRoute(
    //   builder: (context) {
    //     return page;
    //   },
    // );
  }
}

final homeNavigator = GlobalKey<NavigatorState>();

//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

// zsetupRoutes(RouteSettings settings, BuildContext c) {
//   late Widget page;

//   switch (settings.name) {
//     case '/btc-receive':
//       final generateAddressCubit = AddressGenerateCubit(
//         locator<IStorage>(),
//         locator<ISoloWalletAPI>(),
//         walletCubit,
//         loggerCubit,
//       );

//       page = BlocProvider.value(
//         value: generateAddressCubit,
//         child: BtcReceivePage(),
//       );
//       break;

//     case '/wallet-bitcoin':
//       final historyCubit = WalletHistoryCubit(
//         walletCubit,
//         locator<IStorage>(),
//         locator<ISoloWalletAPI>(),
//         locator<IShare>(),
//         locator<ILauncher>(),
//         loggerCubit,
//       );

//       page = BlocProvider.value(
//         value: historyCubit,
//         child: BtcWalletPage(),
//       );
//       break;

//     case '/btc-send':
//       final addressBloc = BtcSendAddressCubit(
//         locator<IClipBoard>(),
//         loggerCubit,
//       );

//       final trafficBloc = TrafficCubit(
//         locator<IStorage>(),
//         locator<INetworkAPI>(),
//         loggerCubit,
//       );

//       final feeCubit = BtcSendFeesCubit(
//         trafficBloc,
//         locator<IStorage>(),
//         locator<IWalletAPI>(),
//         locator<INetworkAPI>(),
//         loggerCubit,
//       );

//       final amountBloc = BtcSendAmountCubit(
//         walletCubit,
//         locator<IStorage>(),
//         locator<IWalletAPI>(),
//         feeCubit,
//         loggerCubit,
//       );

//       final tfaBloc = BtcSendTfaCubit(
//         locator<IClipBoard>(),
//         loggerCubit,
//       );

//       final sendBloc = BtcSendCubit(
//         walletCubit,
//         addressBloc,
//         feeCubit,
//         amountBloc,
//         tfaBloc,
//         locator<IStorage>(),
//         locator<ISoloWalletAPI>(),
//         userCubit,
//         locator<INetworkAPI>(),
//         locator<IBitcoin>(),
//         loggerCubit,
//       );

//       page = MultiBlocProvider(providers: [
//         BlocProvider.value(value: addressBloc),
//         BlocProvider.value(value: trafficBloc),
//         BlocProvider.value(value: amountBloc),
//         BlocProvider.value(value: tfaBloc),
//         BlocProvider.value(value: sendBloc),
//         BlocProvider.value(value: feeCubit),
//       ], child: BtcSendPage());

//       break;

//     case '/home':
//       walletCubit.getWallets();
//       final redditBloc = RedditCubit(
//         locator<IRedditAPI>(),
//         loggerCubit,
//         locator<ILauncher>(),
//       );

//       page = BlocProvider.value(
//           value: redditBloc,
//           child: BlocProvider(
//               create: (_) => CalculatorCubit(
//                     locator<IStorage>(),
//                     locator<IExchangeAPI>(),
//                     loggerCubit,
//                     locator<IVibrate>(),
//                   ),
//               child: HomePage()));
//       break;

//     case '/':
//       page = BlocProvider.value(
//         value: emailCubit,
//         child: EmailLoginPage(),
//       );
//       break;

//     case '/pin-setup':
//       final keyboardBloc = PinKeyboardCubit(
//         locator<IVibrate>(),
//         loggerCubit,
//       );
//       final pinSetupBloc = PinSetupCubit(
//         keyboardBloc,
//         locator<IAuthAPI>(),
//         locator<IStorage>(),
//         loggerCubit,
//       );

//       page = BlocProvider.value(
//         value: keyboardBloc,
//         child: BlocProvider.value(value: pinSetupBloc, child: PinSetupPage()),
//       );
//       break;

//     case '/pin-login':
//       final keyboardBloc = PinKeyboardCubit(
//         locator<IVibrate>(),
//         loggerCubit,
//       );
//       final pinLoginBloc = PinLoginCubit(
//         keyboardBloc,
//         locator<IAuthAPI>(),
//         locator<IStorage>(),
//         loggerCubit,
//       );

//       page = BlocProvider.value(
//         value: keyboardBloc,
//         child: BlocProvider.value(value: pinLoginBloc, child: PinLoginPage()),
//       );
//       break;

//     case '/pin-change':
//       break;

//     case '/home-settings':
//       break;

//     case '/security-home':
//       page = SecurityHomePage();
//       break;

//     case '/security-tfa':
//       SecurityTfaCubit bloc = SecurityTfaCubit(
//         locator<IAuthAPI>(),
//         locator<IStorage>(),
//         locator<IClipBoard>(),
//         loggerCubit,
//       );

//       page = BlocProvider.value(
//         value: bloc,
//         child: SecurityTfaPage(),
//       );

//       break;

//     case '/home-wallets':
//       break;

//     case '/seed-generate':
//       final networkCubit = NetworkCubit(loggerCubit);
//       final seedGenerateCubit = SeedGenerateCubit(
//         networkCubit,
//         locator<IBitcoin>(),
//         locator<ISoloWalletAPI>(),
//         locator<IStorage>(),
//         walletCubit,
//         testNetCubit,
//         loggerCubit,
//       );

//       page = MultiBlocProvider(
//         providers: [
//           BlocProvider.value(value: networkCubit),
//           BlocProvider.value(value: seedGenerateCubit)
//         ],
//         child: SeedGeneratePage(),
//       );
//       break;

//     case '/seed-import':
//       final networkCubit = NetworkCubit(loggerCubit);
//       final seedImportCubit = SeedImportCubit(
//         networkCubit,
//         locator<IBitcoin>(),
//         locator<ISoloWalletAPI>(),
//         locator<IStorage>(),
//         walletCubit,
//         testNetCubit,
//         loggerCubit,
//       );

//       page = MultiBlocProvider(
//         providers: [
//           BlocProvider.value(value: networkCubit),
//           BlocProvider.value(value: seedImportCubit)
//         ],
//         child: SeedImportPage(),
//       );
//       break;

//     case '/seed-import-label':
//       final walletLabel = walletCubit.state.selectedWallet!.label;

//       final networkCubit = NetworkCubit(loggerCubit);
//       final seedImportCubit = SeedImportCubit(
//         networkCubit,
//         locator<IBitcoin>(),
//         locator<ISoloWalletAPI>(),
//         locator<IStorage>(),
//         walletCubit,
//         testNetCubit,
//         loggerCubit,
//         walletLabel: walletLabel,
//       );

//       page = MultiBlocProvider(
//         providers: [
//           BlocProvider.value(value: networkCubit),
//           BlocProvider.value(value: seedImportCubit)
//         ],
//         child: SeedImportPage(),
//       );
//       break;

//     case '/import-xpub':
//       final xpubCubit = XpubImportCubit(
//         locator<ISoloWalletAPI>(),
//         loggerCubit,
//         locator<IClipBoard>(),
//         locator<IStorage>(),
//       );

//       page = BlocProvider.value(
//         value: xpubCubit,
//         child: XpubImportPage(),
//       );
//       break;

//     case '/logs':
//       page = BlocProvider.value(
//         value: loggerCubit,
//         child: LogList(),
//       );

//       break;
//   }
//   return CupertinoPageRoute(
//     builder: (context) {
//       return page;
//     },
//   );
//   //return PageRouteBuilder(
//   //    pageBuilder: (_, __, ___) => page!,
//   //    transitionDuration: Duration(milliseconds: 400),
//   //    transitionsBuilder: (_, anim, anim2, child) {
//   //      return FadeThroughTransition(
//   //          fillColor: c.colours.secondary,
//   //          animation: anim,
//   //          secondaryAnimation: anim2,
//   //          child: child);
//   //    });
// }
