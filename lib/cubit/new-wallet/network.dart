// import 'dart:async';

// import 'package:connectivity/connectivity.dart';
// import 'package:flutter_blue/flutter_blue.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:sats/cubit/logger.dart';
// import 'package:sats/pkg/extensions.dart';

// part 'network.freezed.dart';

// @freezed
// class NetworkState with _$NetworkState {
//   const factory NetworkState({
//     @Default(false) bool bluetoothOnline,
//     @Default(false) bool wifiOnline,
//     @Default(false) bool mobileOnline,
//   }) = _NetworkState;
//   const NetworkState._();

//   String hasOffError() =>
//       // bluetoothOnline ||
//       wifiOnline || mobileOnline || bluetoothOnline
//           ? 'Turn off networking.'
//           : '';

//   String hasOnError() =>
//       !wifiOnline && !mobileOnline ? 'Turn on networking.' : '';
// }

// class NetworkCubit extends Cubit<NetworkState> {
//   NetworkCubit(this.logger) : super(const NetworkState()) {
//     _init();
//   }

//   FlutterBlue flutterBlue = FlutterBlue.instance;

//   late StreamSubscription networkSub;
//   late StreamSubscription bluetoothSub;
//   final LoggerCubit logger;

//   void _init() {
//     try {
//       networkSub = Connectivity()
//           .onConnectivityChanged
//           .listen((ConnectivityResult result) => networkStatusChanged(result));
//     } catch (e, s) {
//       logger.logException(e, 'NetworkCubit._init.net', s);
//     }

//     try {
//       flutterBlue.startScan();
//       // bluetoothSub = flutterBlue.state.listen((result) {
//       //   bluetoothStatusChanged(result);
//       // });
//     } catch (e, s) {
//       logger.logException(e, 'NetworkCubit._init.bt', s);
//     }

//     _checkConnectivity();
//   }

//   void _checkConnectivity() async {
//     print(':::_checkConnectivity');
//     try {
//       final networkResult = await Connectivity().checkConnectivity();
//       networkStatusChanged(networkResult);
//     } catch (e) {
//       print('NETWORK ERROR ::: ' + e.toString());
//     }
//     try {
//       final blueResult = await flutterBlue.state.last;
//       bluetoothStatusChanged(blueResult);
//     } catch (e) {
//       print('BT ERROR ::: ' + e.toString());
//     }
//   }

//   void networkStatusChanged(ConnectivityResult status) {
//     try {
//       if (status == ConnectivityResult.mobile)
//         emit(state.copyWith(mobileOnline: true));
//       else
//         emit(state.copyWith(mobileOnline: false));

//       if (status == ConnectivityResult.wifi)
//         emit(state.copyWith(wifiOnline: true));
//       else
//         emit(state.copyWith(wifiOnline: false));
//     } catch (e, s) {
//       logger.logException(e, 'NetworkCubit.networkStatusChanged', s);
//     }
//   }

//   void bluetoothStatusChanged(BluetoothState status) {
//     try {
//       if (status == BluetoothState.on)
//         emit(state.copyWith(bluetoothOnline: true));

//       if (status == BluetoothState.off)
//         emit(state.copyWith(bluetoothOnline: false));
//     } catch (e, s) {
//       logger.logException(e, 'NetworkCubit.bluetoothStatusChanged', s);
//     }
//   }

//   @override
//   Future<void> close() {
//     networkSub.cancel();
//     bluetoothSub.cancel();
//     flutterBlue.stopScan();

//     return super.close();
//   }
// }
