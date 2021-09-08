import 'dart:async';
import 'dart:developer';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sats/pkg/bitcoin.dart';
import 'package:sats/pkg/storage.dart';
import 'package:sats/state.dart';
import 'package:sats/deps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sats/navigation.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  await initializeHive();
  testBitcoin();
  await setupDependencies(useDummies: true);
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  runZonedGuarded(
    () => runApp(const SatsApp()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

class SatsApp extends StatelessWidget {
  const SatsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return Cubits(
        child: OKToast(
      duration: Duration(milliseconds: 600),
      position: ToastPosition.bottom,
      textStyle: c.fonts.caption!.copyWith(color: c.colours.onBackground),
      child: MaterialApp(
          locale: null,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          builder: (context, child) {
            final mediaQueryData = MediaQuery.of(context);
            return MediaQuery(
                data: mediaQueryData.copyWith(textScaleFactor: 1.0),
                child: child!);
          },
          navigatorKey: homeNavigator,
          debugShowCheckedModeBanner: false,
          theme: derivedTheme(mainTheme()),
          onGenerateRoute: (settings) => Routes.setupRoutes(settings, c)),
    ));
  }
}

testBitcoin() async {
  print("\n\n::::::::::::::::::::::\n\n");
  try {
    BitcoinFFI b = BitcoinFFI();
    final res =
        await b.generateMaster(mnemonic: '12', passphrase: '', network: '');
    print(res);
  } catch (e) {
    print(e.toString());
  }
  print("\n\n::::::::::::::::::::::\n\n");
}


//   //await SentryFlutter.init(
//   //  (options) {
//   //    options.dsn =
//   //        'https://b8c61aa2776f41648864c32584a24d83@o500228.ingest.sentry.io/5670241';
//   //  },
//   //  appRunner: () => runApp(MyApp()),
//   //);
//   //try {
//   //  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
//   //  Hive.init(directory.path);
//   //} catch (e, s) {
//   //  logger.addExpectionToLog(e, 'main.HiveINIT', s);
//   //}

//   //try {
//   //  if (Platform.isAndroid || Platform.isIOS) {
//   //    FlutterStatusbarcolor.setStatusBarColor(Color(0xFF13161f));
//   //    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
//   //  }
//   //} catch (e, s) {
//   //  logger.addExpectionToLog(e, 'main.FlutterStatusbarcolor', s);
//   //}