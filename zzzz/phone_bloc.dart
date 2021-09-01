//import 'package:bloc/bloc.dart';
//import 'package:sats/api/firebase/api.dart';
//import 'package:sats/pkg/storage.dart';
//import 'package:sats/pkg/validation.dart';
//import 'package:equatable/equatable.dart';
//import 'package:flutter/material.dart';

//abstract class PhoneEvent extends Equatable {
//  const PhoneEvent();

//  @override
//  List<Object> get props => [];
//}

//class PhoneNumberChanged extends PhoneEvent {
//  PhoneNumberChanged(this.number);

//  final String number;
//}

//class SendOtp extends PhoneEvent {}

//class OtpChanged extends PhoneEvent {
//  OtpChanged(this.otp);

//  final String otp;
//}

//class VerifyOtp extends PhoneEvent {}

//class PhoneState extends Equatable {
//  PhoneState({
//    this.number = '',
//    this.phoneNumberError = '',
//    this.sendingOtp = false,
//    this.otpSent = false,
//    this.otp = '',
//    this.otpError = '',
//    this.verifyingOtp = false,
//    this.otpVerified = false,
//  });

//  final String number;
//  final String phoneNumberError;
//  final bool sendingOtp;
//  final bool otpSent;

//  final String otp;
//  final String otpError;
//  final bool verifyingOtp;
//  final bool otpVerified;

//  bool get showPhoneField => !sendingOtp || !otpSent;

//  bool get showPhoneOtpField => otpSent && !verifyingOtp;

//  bool get showLoading => verifyingOtp || sendingOtp;

//  bool get showButton => !verifyingOtp && !sendingOtp && !otpVerified;

//  String get buttonText =>
//      !otpSent ? 'Send One-Time Pin' : 'Verify One-Time Pin';

//  @override
//  List<Object> get props => [
//        number,
//        phoneNumberError,
//        sendingOtp,
//        otpSent,
//        otp,
//        otpError,
//        verifyingOtp,
//        otpVerified,
//      ];

//  PhoneState copyWith({
//    String number,
//    String phoneNumberError,
//    bool sendingOtp,
//    bool otpSent,
//    String otp,
//    String otpError,
//    bool verifyingOtp,
//    bool otpVerified,
//  }) {
//    return PhoneState(
//      number: number ?? this.number,
//      phoneNumberError: phoneNumberError ?? this.phoneNumberError,
//      sendingOtp: sendingOtp ?? this.sendingOtp,
//      otpSent: otpSent ?? this.otpSent,
//      otp: otp ?? this.otp,
//      otpError: otpError ?? this.otpError,
//      verifyingOtp: verifyingOtp ?? this.verifyingOtp,
//      otpVerified: otpVerified ?? this.otpVerified,
//    );
//  }
//}

//class PhoneBloc extends Bloc<PhoneEvent, PhoneState> {
//  PhoneBloc({
//    @required this.authGateway,
//    @required this.storage,
//  }) : super(PhoneState());

//  final IAuthGateway authGateway;
//  final IStorage storage;

//  @override
//  Stream<PhoneState> mapEventToState(PhoneEvent event) async* {
//    if (event is PhoneNumberChanged)
//      yield* _mapPhoneNumberChangedToState(event);
//    if (event is SendOtp) yield* _mapSendOtpToState();
//    if (event is OtpChanged) yield* _mapOtpChangedToState(event);
//    if (event is VerifyOtp) yield* _mapVerifyOtpToState();
//  }

//  Stream<PhoneState> _mapPhoneNumberChangedToState(
//      PhoneNumberChanged event) async* {
//    var phone = state.number;
//    if (Validation.isNumeric(event.number)) phone += event.number;
//    yield state.copyWith(number: phone);
//  }

//  Stream<PhoneState> _mapSendOtpToState() async* {
//    yield state.copyWith(phoneNumberError: '');

//    if (state.number.length < 8 || state.number.length > 13) {
//      yield state.copyWith(
//        phoneNumberError: 'Enter a valid phone number',
//      );
//      return;
//    }

//    try {
//      yield state.copyWith(sendingOtp: true);
//      await authGateway.sendOTP(state.number);
//      yield state.copyWith(sendingOtp: false, otpSent: true);
//    } catch (e) {
//      yield state.copyWith(
//        sendingOtp: false,
//        phoneNumberError: 'OTP not sent. Try again later.',
//      );
//    }
//  }

//  Stream<PhoneState> _mapOtpChangedToState(OtpChanged event) async* {
//    var otp = state.otp;
//    if (otp.length < 6) {
//      if (Validation.isNumeric(event.otp)) otp += event.otp;
//    } else {
//      return;
//    }
//    yield state.copyWith(otp: otp);
//  }

//  Stream<PhoneState> _mapVerifyOtpToState() async* {
//    yield state.copyWith(otpError: '');

//    if (state.otp.length != 6) {
//      yield state.copyWith(otpError: 'Enter the 6 digit otp.');
//      return;
//    }

//    try {
//      yield state.copyWith(verifyingOtp: true);
//      final response = await authGateway.phoneLogin(
//        phone: state.number,
//        code: state.otp,
//      );
//      if (response != '') {
//        await storage.saveOrUpdateItem(
//          key: CacheKeys.token,
//          value: response,
//        );

//        yield state.copyWith(
//          verifyingOtp: false,
//          otpVerified: true,
//        );
//        //await Future.delayed(Duration(seconds: 2));

//        //yield PhoneState();
//      }
//    } catch (e) {
//      yield state.copyWith(
//        verifyingOtp: false,
//        otpError: 'Invalid OTP. Try again later.',
//      );
//    }
//  }
//}
