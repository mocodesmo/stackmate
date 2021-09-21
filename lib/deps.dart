import 'package:get_it/get_it.dart';
import 'package:sats/api/reddit.dart';
import 'package:sats/pkg/bitcoin.dart';
import 'package:sats/pkg/clipboard.dart';
import 'package:sats/pkg/launcher.dart';
import 'package:sats/pkg/share.dart';
import 'package:sats/pkg/storage.dart';
import 'package:sats/pkg/vibrate.dart';

GetIt locator = GetIt.instance;

void setupDependencies({required bool useDummies}) {
  if (useDummies) {
    locator.registerLazySingleton<IStorage>(() => HiveStore());
    locator.registerLazySingleton<IClipBoard>(() => ClipBoardd());
    locator.registerLazySingleton<IShare>(() => Sharer());
    locator.registerSingleton<ILauncher>(Launcher());
    locator.registerLazySingleton<IRedditAPI>(() => RedditAPI());
    locator.registerLazySingleton<IVibrate>(() => Vibrator());
    locator.registerLazySingleton<IBitcoin>(() => DummyBtc());
    return;
  }

  locator.registerLazySingleton<IShare>(() => Sharer());
  locator.registerLazySingleton<ILauncher>(() => Launcher());
  locator.registerLazySingleton<IRedditAPI>(() => RedditAPI());
  locator.registerLazySingleton<IClipBoard>(() => ClipBoardd());
  locator.registerLazySingleton<IStorage>(() => HiveStore());
  locator.registerLazySingleton<IBitcoin>(() => BitcoinFFI());
  locator.registerLazySingleton<IVibrate>(() => Vibrator());
}
