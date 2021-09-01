import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sats/zold/api/firebase.dart'; 
// import 'package:sats/zold/api/wallet.dart';
import 'package:sats/deps.dart';
import 'package:sats/cubit/logger.dart';
// import 'package:sats/zold/cubit/wallet.dart';
import 'package:sats/pkg/clipboard.dart';
import 'package:sats/pkg/deep-link.dart';
import 'package:sats/pkg/launcher.dart';
import 'package:sats/pkg/share.dart';
import 'package:sats/pkg/storage.dart';
// import 'package:sats/zold/cubit/email-login.dart';
import 'package:sats/cubit/network.dart';

// final walletCubit = WalletCubit(
//   locator<IStorage>(),
//   locator<IWalletAPI>(),
//   loggerCubit,
//   locator<IShare>(),
//   locator<IClipBoard>(),
// );

// final userCubit = UserCubit(
//   locator<IProfileAPI>(),
//   locator<IStorage>(),
//   locator<IAuthGateway>(),
//   emailCubit,
//   loggerCubit,
//   locator<ILauncher>(),
// );

// final emailCubit = EmailCubit(
//   locator<IStorage>(),
//   locator<IDeepLink>(),
//   loggerCubit,
//   locator<ILauncher>(),
// );

final testNetCubit = NetworkCubit();

final loggerCubit = LoggerCubit();

class Cubits extends StatelessWidget {
  Cubits({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider.value(value: walletCubit),
        // BlocProvider.value(value: userCubit),
        // BlocProvider.value(value: testNetCubit),
        BlocProvider.value(value: loggerCubit),
      ],
      child: child,
      // child: BlocListener<UserCubit, UserState>(
      //   listenWhen: (previous, current) {
      //     return previous.authenticated != current.authenticated;
      //   },
      //   listener: (_, state) {
      //     // if (state.authenticated) {
      //     //   if (state.user!.pinStatus)
      //     //     homeNavigator.currentState!.pushReplacementNamed('/pin-login');
      //     //   else
      //     //     homeNavigator.currentState!.pushReplacementNamed('/pin-setup');
      //     // } else {
      //     //   homeNavigator.currentState!.pushReplacementNamed('/');
      //     // }
      //   },
      //   child: child,
      // ),
    );
  }
}

class SimpleBlocObserver extends BlocObserver {
  void prettyPrint(String input) {
    String str = input.replaceAll(', ', ',\n    ');
    str = str.replaceAll('(', '(\n    ');
    str = str.replaceAll(')', '\n)');
    str = '\n' + str.replaceAll('),', '  ),') + '\n\n';

    print(str);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    print('Event { ' + event.toString() + ' }');

    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    try {
      prettyPrint(change.nextState.toString());
    } catch (e) {
      print('STATE ERROR: ' + e.toString());
    }
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }
}
