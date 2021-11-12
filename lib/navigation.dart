import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sats/api/rates.dart';
import 'package:sats/api/reddit.dart';
import 'package:sats/cubit/_state.dart';
import 'package:sats/cubit/calculator.dart';
import 'package:sats/cubit/new-wallet/seed-generate.dart';
import 'package:sats/cubit/new-wallet/seed-import.dart';
import 'package:sats/cubit/new-wallet/timed.dart';
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
  static const calc = 'calc';
  static const setting = 'settings';
  static const logs = 'logs';
  static const wallet = 'wallet';
  static const receive = 'receive';
  static const send = 'send';
  static const sendFromQR = 'send-from-qr';
  static const qr = 'qr';
  static const addressBook = 'address-book';

  static const generateSeed = 'generate-seed';
  static const importSeed = 'import-seed';
  static const watchOnly = 'watch-only';
  static const inheritance = 'inheritance';

  static Route<dynamic>? setupRoutes(RouteSettings settings, BuildContext c) {
    late Widget page;

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
        // final networkCubit = NetworkCubit(loggerCubit);
        final seedGenerateCubit = SeedGenerateCubit(
          // networkCubit,
          locator<IFFFI>(),
          locator<IStorage>(),
          // walletCubit,
          // testNetCubit,
          loggerCubit,
          walletsCubit,
          blockchainCubit,
        );

        page = MultiBlocProvider(
          providers: [
            // BlocProvider.value(value: networkCubit),
            BlocProvider.value(value: seedGenerateCubit)
          ],
          child: SeedGeneratePage(),
        );
        break;

      case importSeed:
        // final networkCubit = NetworkCubit(loggerCubit);
        final seedImportCubit = SeedImportCubit(
          // networkCubit,
          locator<IFFFI>(),
          locator<IStorage>(),
          // walletCubit,
          // testNetCubit,
          walletsCubit,
          blockchainCubit,
          loggerCubit,
        );

        page = MultiBlocProvider(
          providers: [
            // BlocProvider.value(value: networkCubit),
            BlocProvider.value(value: seedImportCubit)
          ],
          child: SeedImportPage(),
        );
        break;

      case watchOnly:
        final xpubCubit = XpubImportCubit(
          locator<IFFFI>(),
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

      case inheritance:
        page =const InheritancePage();
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
          blockchainCubit,
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
