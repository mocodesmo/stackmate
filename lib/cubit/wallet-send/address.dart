import 'package:bloc/bloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/pkg/clipboard.dart';
import 'package:sats/pkg/validation.dart';

part 'address.freezed.dart';

@freezed
class BtcSendAddressState with _$BtcSendAddressState {
  const factory BtcSendAddressState({
    @Default(false) bool cameraOpened,
    @Default('') String address,
    @Default('') String addressError,
    @Default('') String comment,
    @Default('') String commentError,
  }) = _BtcSendAddressState;
  const BtcSendAddressState._();

  bool hasError() => addressError != '' || commentError != '';
}

class BtcSendAddressCubit extends Cubit<BtcSendAddressState> {
  BtcSendAddressCubit(
    this._clipboard,
    this.logger,
  ) : super(const BtcSendAddressState());

  final IClipBoard _clipboard;
  final LoggerCubit logger;

  void toggleCamera() async {
    try {
      emit(state.copyWith(cameraOpened: true));

      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        false,
        ScanMode.QR,
      );

      if (barcodeScanRes == '-1') barcodeScanRes = '';

      emit(state.copyWith(address: barcodeScanRes, cameraOpened: false));
    } catch (e, s) {
      emit(state.copyWith(cameraOpened: false, addressError: 'Error Occured.'));

      logger.logException(e, 'BtcSendAddressBloc._mapToggleCameraEvent', s);
    }
  }

  void pasteAddress() async {
    try {
      final text = await _clipboard.pasteFromClipBoard();
      emit(state.copyWith(address: text));
    } catch (e, s) {
      logger.logException(e, 'BtcSendAddressBloc._mapPasteAddressEvent', s);
    }
  }

  void addressChanged(String address) async {
    if (address.startsWith('bitcoin:')) {
      emit(
        state.copyWith(
          address: address.replaceAll(
            'bitcoin:',
            '',
          ),
          addressError: '',
        ),
      );
    } else {
      emit(state.copyWith(address: address, addressError: ''));
    }
  }

  void commentChanged(String comment) async {
    emit(state.copyWith(comment: comment, commentError: ''));
  }

  void checkAddress() async {
    if (!Validation.isBtcAddress(state.address)) {
      emit(state.copyWith(addressError: 'Invalid Wallet Address'));
    } else if (state.comment.length > 15) {
      emit(state.copyWith(commentError: 'Comment too long.'));
    } else {
      emit(state.copyWith(addressError: '', commentError: ''));
    }
  }

  void addAddressError(String error) async {
    emit(state.copyWith(addressError: error));
  }

  void addCommentError(String error) async {
    emit(state.copyWith(commentError: error));
  }
}
