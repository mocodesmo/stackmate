import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:sats/zold/api/firebase.dart';
import 'package:sats/zold/api/profile.dart';
import 'package:sats/zold/cubit/email-login.dart';
import 'package:sats/zold/model/user.dart';
import 'package:sats/pkg/launcher.dart';
import 'package:sats/pkg/storage.dart';
import 'package:sats/cubit/logger.dart';

part 'user.freezed.dart';

enum AuthApp { gauth, authy, freeotp }

@freezed
class UserState with _$UserState {
  const factory UserState({
    @Default(false) bool authenticated,
    User? user,
    @Default(false) bool gettingUser,
    @Default('') String errorOnGet,
  }) = _UserState;
}

class UserCubit extends Cubit<UserState> {
  UserCubit(
    this._profileAPI,
    this._storageService,
    // this._authGateway,
    this._emailBloc,
    this._logger,
    this._launcher,
  ) : super(UserState()) {
    this.getUser();
  }

  final IStorage _storageService;
  final IProfileAPI _profileAPI;
  // final IAuthGateway _authGateway;
  final LoggerCubit _logger;
  final EmailCubit _emailBloc;
  final ILauncher _launcher;

  void tfaCompleted() async {
    final user = state.user!;
    emit(state.copyWith(
        user: User(
      tfaStatus: true,
      email: user.email,
      locked: user.locked,
      pinStatus: user.pinStatus,
    )));
  }

  void authCompleted() async {
    emit(UserState(authenticated: true));
  }

  void getUser() async {
    try {
      // emit(state.copyWith(
      //   gettingUser: true,
      //   authenticated: false,
      // ));
      // await Future.delayed(Duration(milliseconds: 600));
      // // final refresh = await _authGateway.refreshUser();
      // if (refresh != '')
      //   await _storageService.saveOrUpdateItem(
      //       key: CacheKeys.token, value: refresh);
      // final token = await _storageService.getItem(key: CacheKeys.token);
      // final response = await _profileAPI.getProfile(authToken: token);
      // if (response.statusCode == null) throw '';
      // if (response.statusCode == 403) {
      //   this.logOut();
      //   return;
      // }
      // if (response.statusCode == 500) {
      //   emit(UserState(
      //     authenticated: true,
      //     gettingUser: false,
      //     errorOnGet: 'Error Occured. Please try again.',
      //   ));
      //   return;
      // }

      // if (response.statusCode != 200) {
      //   emit(UserState(
      //     authenticated: false,
      //     gettingUser: false,
      //   ));
      //   return;
      // }

      // //final data = jsonDecode(res  /ponse.data);
      // final user = User.fromJson(response.data['message']);

      // emit(UserState(authenticated: true, user: user));
    } catch (e, s) {
      _logger.logException(e, 'UserBloc._mapGetUser', s);
      emit(UserState(
        authenticated: false,
        gettingUser: false,
      ));
    }
  }

  void logOut() async {
    try {
      await Future.delayed(Duration(microseconds: 500));
      _emailBloc.resetEmailBloc();
      emit(UserState());
      // _authGateway.signOutt();
      _storageService.deleteItem(key: CacheKeys.token);
      _storageService.deleteItem(key: CacheKeys.hashedPin);
      _storageService.deleteItem(key: CacheKeys.email);
    } catch (e, s) {
      _logger.logException(e, 'UserBloc._mapLogOut', s);
    }
  }

  void openAuthApp(AuthApp app) async {
    String url = '';
    if (Platform.isAndroid)
      switch (app) {
        case AuthApp.gauth:
          url =
              'https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=en';
          break;
        case AuthApp.authy:
          url =
              'https://play.google.com/store/apps/details?id=com.authy.authy&hl=en';
          break;
        case AuthApp.freeotp:
          url =
              'https://play.google.com/store/apps/details?id=org.fedorahosted.freeotp&hl=en_IN';
          break;
      }

    if (Platform.isIOS)
      switch (app) {
        case AuthApp.gauth:
          url =
              'https://apps.apple.com/in/app/google-authenticator/id388497605';
          break;
        case AuthApp.authy:
          url = 'https://apps.apple.com/us/app/authy/id494168017';
          break;
        case AuthApp.freeotp:
          url =
              'https://apps.apple.com/us/app/freeotp-authenticator/id872559395';
          break;
      }

    try {
      final launchable = await _launcher.canLaunchApp(url);

      if (launchable) {
        if (launchable)
          _launcher.launchApp(url);
        else
          _launcher.openInAppStore(url);
      }
    } catch (e, s) {
      _logger.logException(
          e, 'SecurityTfaOpenAuthButton._openAuthenticatorToState', s);
    }
  }
}
