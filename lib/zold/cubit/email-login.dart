import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/zold/api/firebase.dart';
import 'package:sats/pkg/deep-link.dart';
import 'package:sats/pkg/launcher.dart';
import 'package:sats/pkg/storage.dart';
import 'package:sats/pkg/validation.dart';
import 'package:sats/cubit/logger.dart';

part 'email-login.freezed.dart';

@freezed
class EmailState with _$EmailState {
  const factory EmailState({
    @Default('') String email,
    @Default('') String emailError,
    @Default(false) bool sendingEmail,
    @Default(false) bool emailSent,
    @Default(false) bool checkingLink,
    @Default('') String linkError,
    @Default(false) bool loggedIn,
  }) = _EmailState;
}

class EmailCubit extends Cubit<EmailState> {
  EmailCubit(
    // this._authGateway,
    this._storage,
    this._deepLink,
    this._logger,
    this._launcher,
  ) : super(EmailState()) {
    _deepLink.handleDeepLink(this);
  }

  // final IAuthGateway _authGateway;
  final IStorage _storage;
  final IDeepLink _deepLink;
  final LoggerCubit _logger;
  final ILauncher _launcher;

  void emailChanged(String text) async {
    emit(state.copyWith(email: text));
  }

  void sendEmail() async {
    emit(state.copyWith(emailError: ''));

    if (!Validation.isEmail(state.email)) {
      emit(state.copyWith(emailError: 'Please enter a valid email.'));
      return;
    }

    try {
      emit(state.copyWith(sendingEmail: true));

      //await Future.delayed(Duration(seconds: 3));
      // await _authGateway.signInWithEmailLink(
      //   email: state.email,
      // );

      await _storage.saveOrUpdateItem(
        key: CacheKeys.email,
        value: state.email,
      );

      final _ = await _storage.getItem(key: CacheKeys.email);

      emit(state.copyWith(
        sendingEmail: false,
        emailSent: true,
      ));
    } catch (e, s) {
      _logger.logException(e, 'EmailBloc._mapSendEmail', s);
      emit(state.copyWith(
        sendingEmail: false,
        emailSent: false,
        emailError: 'Something went wrong. Please try again later.',
      ));
    }
  }

  //bool linking = false;

  void deepLinkRecieved(String link) async {
    try {
      //if (!linking) {
      //  linking = true;
      emit(state.copyWith(linkError: ''));

      emit(state.copyWith(checkingLink: true));
      //await Future.delayed(Duration(microseconds: 10));
      final email = await _storage.getItem(key: CacheKeys.email);

      print('\n\n\nLINK CAME\n\n\n');
      // final token = await _authGateway.signInAfterDeepLink(
      //   email: email,
      //   link: link,
      // );

      //https://satswala.firebaseapp.com/__/auth/action?apiKey=AIzaSyAvBYMfVbEwy28_qfnFRqfQi99AdkB2m9U&mode=signIn&oobCode=_TgQSQih40VcYvo3_7q87eTjw_i456EEU_j3vliJTk8AAAF4NhkmPw&continueUrl=https://satswala.web.app/link1&lang=en
      //https://satswala.firebaseapp.com/__/auth/action?apiKey=AIzaSyAvBYMfVbEwy28_qfnFRqfQi99AdkB2m9U&mode=signIn&oobCode=V20igFJfjpu_YuH6Pp4-kjudWIaTkOVxAXVOtH_skIcAAAF4NjIlOg&continueUrl=https://satswala.web.app&lang=en

      // if (token == '') throw 'No Token';

      // await _storage.saveOrUpdateItem(key: CacheKeys.token, value: token);

      // emit(state.copyWith(
      //   checkingLink: false,
      //   loggedIn: true,
      // ));
      //linking = false;
      //}
    } catch (e, s) {
      _logger.logException(e, 'EmailBloc._mapDeepLinkRecieved', s);
      emit(state.copyWith(
        checkingLink: false,
        loggedIn: false,
        linkError: 'Invalid Link. Try sending the email again.',
      ));
      //linking = false;
    }
  }

  void resetEmailBloc() async {
    emit(EmailState());
  }

  void openEmailApp() {
    try {
      _launcher.openEmailInbox();
      //.launchApp('mailto:');
      //Platform.isIOS ? "message://" : "com.google.android.gm");
    } catch (e, s) {
      _logger.logException(e, 'EmailButton._openEmailApp', s);
    }
  }

  void openTerms() {
    try {
      final link = 'https://sats.cc/terms.html';
      _launcher.launchApp(link);
      //.launchApp('mailto:');
      //Platform.isIOS ? "message://" : "com.google.android.gm");
    } catch (e, s) {
      _logger.logException(e, 'EmailButton._openEmailApp', s);
    }
  }

  void opennPrivacy() {
    try {
      final link = 'https://sats.cc/privacy.html';
      _launcher.launchApp(link);
      //.launchApp('mailto:');
      //Platform.isIOS ? "message://" : "com.google.android.gm");
    } catch (e, s) {
      _logger.logException(e, 'EmailButton._openEmailApp', s);
    }
  }
}

//saveTok() async {
//  await Future.delayed(Duration(seconds: 3));
//  await locator<IStorage>()
//      .saveOrUpdateItem(key: CacheKeys.token, value: 'yoo');

//  final yo = await locator<IStorage>().getItem(key: CacheKeys.token);
//  print(':::' + yo);
//}
