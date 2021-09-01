//import 'package:sats/api/firebase/api.dart';
//import 'package:sats/pkg/storage.dart';
//import 'package:mockito/mockito.dart';
//import 'package:sats/view/authentication/bloc/phone_bloc.dart';
//import 'package:test/test.dart';
//import 'package:bloc_test/bloc_test.dart';

//class MockAuthGateway extends Mock implements IAuthGateway {}

//class MockStorage extends Mock implements IStorage {}

//main() {
//  group('Phone Bloc', () {
//    PhoneBloc phoneBloc;
//    IAuthGateway authGateway;
//    IStorage storage;

//    setUp(() {
//      authGateway = MockAuthGateway();
//      storage = MockStorage();
//      phoneBloc = PhoneBloc(
//        authGateway: authGateway,
//        storage: storage,
//      );
//    });

//    tearDown(() {
//      phoneBloc.close();
//    });

//    test('initial state should be blank', () {
//      expect(phoneBloc.state, PhoneState());
//    });

//    blocTest('should update phone number while typing',
//        build: () => phoneBloc,
//        act: (PhoneBloc bloc) {
//          bloc.add(PhoneNumberChanged('1'));
//          bloc.add(PhoneNumberChanged('2'));
//          bloc.add(PhoneNumberChanged('3'));
//        },
//        expect: [
//          PhoneState(number: '1'),
//          PhoneState(number: '12'),
//          PhoneState(number: '123'),
//        ]);

//    blocTest('should only allow numeric values while typing',
//        build: () => phoneBloc,
//        act: (PhoneBloc bloc) {
//          bloc.add(PhoneNumberChanged('1'));
//          bloc.add(PhoneNumberChanged('2'));
//          bloc.add(PhoneNumberChanged('x'));
//          bloc.add(PhoneNumberChanged('3'));
//        },
//        expect: [
//          PhoneState(number: '1'),
//          PhoneState(number: '12'),
//          PhoneState(number: '123'),
//        ]);

//    blocTest('should check if phone number less than 8 digits when submitting',
//        build: () => phoneBloc,
//        act: (PhoneBloc bloc) {
//          bloc.add(PhoneNumberChanged('1234567'));
//          bloc.add(SendOtp());
//        },
//        expect: [
//          PhoneState(number: '1234567'),
//          PhoneState(
//            number: '1234567',
//            phoneNumberError: 'Enter a valid phone number',
//          ),
//        ]);

//    blocTest('should check if phone number more than 13 digits when submitting',
//        build: () => phoneBloc,
//        act: (PhoneBloc bloc) {
//          bloc.add(PhoneNumberChanged('123456789012345'));
//          bloc.add(SendOtp());
//        },
//        expect: [
//          PhoneState(number: '123456789012345'),
//          PhoneState(
//            number: '123456789012345',
//            phoneNumberError: 'Enter a valid phone number',
//          ),
//        ]);

//    blocTest(
//        'should send phone number to auth service and show that otp is sent',
//        build: () => phoneBloc,
//        act: (PhoneBloc bloc) {
//          bloc.add(PhoneNumberChanged('1234567890'));
//          bloc.add(SendOtp());
//        },
//        expect: [
//          PhoneState(number: '1234567890'),
//          PhoneState(number: '1234567890', sendingOtp: true),
//          PhoneState(
//            number: '1234567890',
//            sendingOtp: false,
//            otpSent: true,
//          ),
//        ],
//        verify: (PhoneBloc bloc) {
//          verify(bloc.authGateway.sendOTP('1234567890')).called(1);
//        });

//    blocTest('should show an error if auth service does not an otp',
//        build: () {
//          when(phoneBloc.authGateway.sendOTP('1234567890'))
//              .thenThrow(Exception());
//          return phoneBloc;
//        },
//        act: (PhoneBloc bloc) {
//          bloc.add(PhoneNumberChanged('1234567890'));
//          bloc.add(SendOtp());
//        },
//        expect: [
//          PhoneState(number: '1234567890'),
//          PhoneState(number: '1234567890', sendingOtp: true),
//          PhoneState(
//            number: '1234567890',
//            phoneNumberError: 'OTP not sent. Try again later.',
//            sendingOtp: false,
//            otpSent: false,
//          ),
//        ],
//        verify: (PhoneBloc bloc) {
//          verify(bloc.authGateway.sendOTP('1234567890')).called(1);
//        });

//    blocTest('should update otp while typing',
//        build: () => phoneBloc,
//        act: (PhoneBloc bloc) {
//          bloc.add(OtpChanged('1'));
//          bloc.add(OtpChanged('2'));
//          bloc.add(OtpChanged('3'));
//        },
//        expect: [
//          PhoneState(otp: '1'),
//          PhoneState(otp: '12'),
//          PhoneState(otp: '123'),
//        ]);

//    blocTest('should only allow 6 digit otp while typing',
//        build: () => phoneBloc,
//        act: (PhoneBloc bloc) {
//          bloc.add(OtpChanged('1'));
//          bloc.add(OtpChanged('2'));
//          bloc.add(OtpChanged('3'));
//          bloc.add(OtpChanged('x'));
//          bloc.add(OtpChanged('4'));
//          bloc.add(OtpChanged('5'));
//          bloc.add(OtpChanged('6'));
//          bloc.add(OtpChanged('7'));
//        },
//        expect: [
//          PhoneState(otp: '1'),
//          PhoneState(otp: '12'),
//          PhoneState(otp: '123'),
//          PhoneState(otp: '1234'),
//          PhoneState(otp: '12345'),
//          PhoneState(otp: '123456'),
//        ]);

//    blocTest(
//        'should show authenticated and save token in storage service after authentication',
//        build: () {
//          when(phoneBloc.authGateway.phoneLogin(
//            phone: '1234567890',
//            code: '123456',
//          )).thenAnswer(
//            (_) async => 'tok',
//          );

//          return phoneBloc;
//        },
//        act: (PhoneBloc bloc) {
//          bloc.add(PhoneNumberChanged('1234567890'));
//          bloc.add(SendOtp());
//          bloc.add(OtpChanged('123456'));
//          bloc.add(VerifyOtp());
//        },
//        expect: [
//          PhoneState(number: '1234567890'),
//          PhoneState(number: '1234567890', sendingOtp: true),
//          PhoneState(
//            number: '1234567890',
//            sendingOtp: false,
//            otpSent: true,
//          ),
//          PhoneState(
//            number: '1234567890',
//            sendingOtp: false,
//            otpSent: true,
//            otp: '123456',
//          ),
//          PhoneState(
//            number: '1234567890',
//            sendingOtp: false,
//            otpSent: true,
//            otp: '123456',
//            verifyingOtp: true,
//          ),
//          PhoneState(
//            number: '1234567890',
//            sendingOtp: false,
//            otpSent: true,
//            otp: '123456',
//            verifyingOtp: false,
//            otpVerified: true,
//          ),
//        ],
//        verify: (PhoneBloc bloc) {
//          verify(bloc.authGateway.sendOTP('1234567890')).called(1);

//          verify(bloc.storage.saveOrUpdateItem(
//            key: CacheKeys.token,
//            value: 'tok',
//          )).called(1);
//        });

//    blocTest('should show error when otp is invalid by auth service',
//        build: () {
//          when(phoneBloc.authGateway.phoneLogin(
//            phone: '1234567890',
//            code: '123456',
//          )).thenThrow(Exception());

//          return phoneBloc;
//        },
//        act: (PhoneBloc bloc) {
//          bloc.add(PhoneNumberChanged('1234567890'));
//          bloc.add(SendOtp());
//          bloc.add(OtpChanged('123456'));
//          bloc.add(VerifyOtp());
//        },
//        expect: [
//          PhoneState(number: '1234567890'),
//          PhoneState(number: '1234567890', sendingOtp: true),
//          PhoneState(
//            number: '1234567890',
//            sendingOtp: false,
//            otpSent: true,
//          ),
//          PhoneState(
//            number: '1234567890',
//            sendingOtp: false,
//            otpSent: true,
//            otp: '123456',
//          ),
//          PhoneState(
//            number: '1234567890',
//            sendingOtp: false,
//            otpSent: true,
//            otp: '123456',
//            verifyingOtp: true,
//          ),
//          PhoneState(
//            number: '1234567890',
//            sendingOtp: false,
//            otpSent: true,
//            otp: '123456',
//            verifyingOtp: false,
//            otpVerified: false,
//            otpError: 'Invalid OTP. Try again later.',
//          ),
//        ],
//        verify: (PhoneBloc bloc) {
//          verify(bloc.authGateway.sendOTP('1234567890')).called(1);
//        });
//  });
//}
