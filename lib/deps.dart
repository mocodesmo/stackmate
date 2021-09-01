// import 'package:sats/zold/api/auth.dart';
// import 'package:sats/zold/api/exchange.dart';
// import 'package:sats/zold/api/firebase.dart';
// import 'package:sats/zold/api/network.dart';
// import 'package:sats/zold/api/profile.dart';
import 'package:sats/api/reddit.dart';
// import 'package:sats/zold/api/wallet-solo.dart';
// import 'package:sats/zold/api/wallet.dart';
import 'package:sats/pkg/bitcoin.dart';
import 'package:sats/pkg/clipboard.dart';
import 'package:sats/pkg/deep-link.dart';
import 'package:sats/pkg/launcher.dart';
import 'package:sats/pkg/share.dart';
import 'package:sats/pkg/storage.dart';
import 'package:sats/pkg/vibrate.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setupDependencies({bool useDummies = false}) {
  if (useDummies) {
    locator.registerLazySingleton<IStorage>(() => DummyStorage());
    // locator.registerLazySingleton<IAuthGateway>(() => DummyAuthGateway());
    // locator.registerLazySingleton<IAuthAPI>(() => DummyAuthAPI());
    locator.registerLazySingleton<IClipBoard>(() => ClipBoardd());
    // locator.registerLazySingleton<IWalletAPI>(() => DummyWalletAPI());
    locator.registerLazySingleton<IShare>(() => Sharer());
    // locator.registerLazySingleton<IExchangeAPI>(() => DummyExchangeAPI());
    // locator.registerLazySingleton<IProfileAPI>(() => DummyProfileAPI());
    locator.registerSingleton<ILauncher>(Launcher());
    // locator.registerLazySingleton<IDeepLink>(() => DummyDeepLink());
    locator.registerLazySingleton<IRedditAPI>(() => RedditAPI());
    locator.registerLazySingleton<IVibrate>(() => Vibrator());
    locator.registerLazySingleton<IBitcoin>(() => BitcoinFFI());
    // locator.registerLazySingleton<INetworkAPI>(() => DummyNetworkAPI());
    // locator.registerLazySingleton<ISoloWalletAPI>(() => DummySoloWalletAPI());

    return;
  }

  locator.registerLazySingleton<IShare>(() => Sharer());
  locator.registerLazySingleton<ILauncher>(() => Launcher());
  // locator.registerLazySingleton<IWalletAPI>(() => WalletAPI());
  locator.registerLazySingleton<IRedditAPI>(() => RedditAPI());
  locator.registerLazySingleton<IClipBoard>(() => ClipBoardd());
  locator.registerLazySingleton<IStorage>(() => SecureeStorage());
  // locator.registerLazySingleton<IAuthGateway>(() => FirebaseAuthGateway());
  // locator.registerLazySingleton<IProfileAPI>(() => ProfileAPI());
  // locator.registerLazySingleton<IAuthAPI>(() => AuthAPI());
  // locator.registerLazySingleton<IExchangeAPI>(() => ExchangeAPI());
  locator.registerLazySingleton<IBitcoin>(() => BitcoinFFI());
  // locator.registerLazySingleton<INetworkAPI>(() => NetworkAPI());
  // locator.registerLazySingleton<ISoloWalletAPI>(() => SoloWalletAPI());

  // locator.registerLazySingleton<IDeepLink>(() => DeepLink());
  locator.registerLazySingleton<IVibrate>(() => Vibrator());
}
