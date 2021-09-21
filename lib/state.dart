import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/wallet/blockchain.dart';
import 'package:sats/cubit/wallet/wallets.dart';
import 'package:sats/deps.dart';
import 'package:sats/pkg/clipboard.dart';
import 'package:sats/pkg/storage.dart';

final loggerCubit = LoggerCubit(
  locator<IClipBoard>(),
);

final blockchainCubit = BlockchainCubit(
  locator<IStorage>(),
  loggerCubit,
  // walletsCubit,
);

final walletsCubit = WalletsCubit(
  locator<IStorage>(),
  loggerCubit,
  blockchainCubit,
);

class Cubits extends StatelessWidget {
  const Cubits({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: blockchainCubit),
        BlocProvider.value(value: loggerCubit),
        BlocProvider.value(value: walletsCubit),
      ],
      child: BlocListener<BlockchainCubit, BlockchainState>(
        listener: (context, state) {
          walletsCubit.refresh();
        },
        child: child,
      ),
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

  // @override
  // void onTransition(Bloc bloc, Transition transition) {
  //   super.onTransition(bloc, transition);
  // }
}
