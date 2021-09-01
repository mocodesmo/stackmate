// import 'package:bloc/bloc.dart';
// import 'package:flutter/foundation.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:sats/zold/api/wallet.dart';
// import 'package:sats/zold/model/wallet-solo.dart';
// import 'package:sats/pkg/clipboard.dart';
// import 'package:sats/pkg/share.dart';
// import 'package:sats/pkg/storage.dart';
// import 'package:sats/cubit/logger.dart';

// part 'wallet.freezed.dart';

// @freezed
// class WalletState with _$WalletState {
//   const WalletState._();
//   const factory WalletState({
//     @Default([]) List<SoloWallet> wallets,
//     SoloWallet? selectedWallet,
//     @Default(false) bool loadingWallets,
//     @Default('') String loadingWalletsError,
//     @Default(false) bool creatingBtcWallet,
//     @Default('') String createBtcWalletError,
//   }) = _WalletState;

//   bool labelExists(String label) {
//     for (var wallet in wallets) {
//       if (wallet.label == label) return true;
//     }
//     return false;
//   }

//   int _totalWorthSats() {
//     int worth = 0;
//     for (var wallet in wallets) {
//       final balances = wallet.balances;
//       worth += (balances.confirmed + balances.unconfirmed);
//     }
//     return worth;
//   }

//   String totalWorthBtcStr() =>
//       (_totalWorthSats() / 10000000).toStringAsFixed(8);
//   String totakWorthSatsStr() => _totalWorthSats().toString();

//   //WalletBalances getBalances(String nickname) {
//   //  for (var wallet in wallets)
//   //    if (wallet.nickname == nickname) return wallet.balances!;

//   //  return WalletBalances();
//   //}

//   //SoloWallet getWalletByName(String nickname) {
//   //  for (var wallet in wallets) if (wallet.nickname == nickname) return wallet;

//   //  return SoloWallet();
//   //}
// }

// class WalletCubit extends Cubit<WalletState> {
//   WalletCubit(
//     this._storage,
//     this._walletAPI,
//     this._logger,
//     this._share,
//     this._clipBoard,
//   ) : super(WalletState());

//   final IStorage _storage;
//   final IWalletAPI _walletAPI;
//   final LoggerCubit _logger;
//   final IShare _share;
//   final IClipBoard _clipBoard;

//   void getWallets() async {
//     try {
//       emit(state.copyWith(loadingWallets: true));
//       final token = await _storage.getItem(key: CacheKeys.token);
//       final hashedPin = await _storage.getItem(key: CacheKeys.hashedPin);
//       final response = await _walletAPI.getWalletOverview(
//           authToken: token, hashedPin: hashedPin);
//       if (response.statusCode == null || response.statusCode != 200) throw '';

//       var wallets = await compute(_parseWallet, response.data);

//       for (var wallet in wallets) {
//         final xpriv =
//             await _storage.getItem(key: CacheKeys.xPriv + ':' + wallet.label);
//         if (xpriv != '') {
//           wallet = wallet.copyWith(watchOnly: false);
//           final idx = wallets.indexWhere((w) => w.label == wallet.label);
//           wallets.removeAt(idx);
//           wallets.insert(idx, wallet);
//         }
//       }

//       emit(state.copyWith(
//         wallets: wallets,
//         loadingWallets: false,
//       ));
//     } catch (e, s) {
//       _logger.logException(e, 'WalletBloc.getWallets', s);
//       emit(state.copyWith(
//           loadingWallets: false,
//           loadingWalletsError: 'Error Occured. Please try again.'));
//     }
//   }

//   void walletSelected(String nickname) {
//     final wallet = _getWalletByName(nickname);
//     emit(state.copyWith(selectedWallet: wallet));

//     _checkWatchOnly();
//   }

//   void _checkWatchOnly() async {
//     try {
//       await Future.delayed(Duration(milliseconds: 50));
//       await _storage.getItem(
//         key: CacheKeys.xPriv + ':' + state.selectedWallet!.nickname,
//       );

//       var wallet = state.selectedWallet!;
//       var w = wallet.copyWith(watchOnly: false);
//       emit(state.copyWith(selectedWallet: w));
//     } catch (e) {
//       var wallet = state.selectedWallet!;
//       var w = wallet.copyWith(watchOnly: true);
//       emit(state.copyWith(selectedWallet: w));
//       //_logger.logException(e, 'WalletCubit._checkWatchOnly', s);
//     }
//   }

//   void clearSelectedWallet() {
//     emit(state.copyWith(selectedWallet: null));
//   }

//   SoloWallet _getWalletByName(String nickname) {
//     for (var wallet in state.wallets)
//       if (wallet.nickname == nickname) return wallet;

//     return SoloWallet();
//   }

//   void updateSelectedWallet(SoloWallet wallet) {
//     emit(state.copyWith(selectedWallet: wallet));
//   }

//   void copyAddress(String address) {
//     try {
//       _clipBoard.copyToClipBoard(address);
//     } catch (e, s) {
//       _logger.logException(e, 'WalletCubit.copyAddress', s);
//     }
//   }

//   void shareAddress(String address) {
//     try {
//       final text = 'This is my bitcoin address:\n' + address;
//       _share.share(text: text, subjectForEmail: 'Bitcoin Address');
//     } catch (e, s) {
//       _logger.logException(e, 'WalletCubit.shareAddress', s);
//     }
//   }
// }

// List<SoloWallet> _parseWallet(dynamic body) {
//   //final data = jsonDecode(body);
//   final walletJson = body['message']['solo'];
//   List<SoloWallet> wallets = [];
//   for (var wallet in walletJson) wallets.add(SoloWallet.fromJson(wallet));
//   return wallets;
// }
