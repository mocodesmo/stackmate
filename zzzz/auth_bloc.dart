//import 'package:bloc/bloc.dart';
//import 'package:sats/pkg/storage.dart';
//import 'package:equatable/equatable.dart';
//import 'package:flutter/foundation.dart';

//enum LoginType { phone, email }

//abstract class AuthEvent extends Equatable {
//  const AuthEvent();

//  @override
//  List<Object> get props => [];
//}

//class AuthCompleted extends AuthEvent {}

//class ChangeLoginType extends AuthEvent {
//  const ChangeLoginType(this.loginType);

//  final LoginType loginType;
//}

//class LogOut extends AuthEvent {}

//class ResetAuthBloc extends AuthEvent {}

//class AuthState extends Equatable {
//  const AuthState({
//    this.loggedIn = false,
//    this.loginType = LoginType.phone,
//  });

//  final bool loggedIn;
//  final LoginType loginType;

//  @override
//  List<Object> get props => [
//        loggedIn,
//        loginType,
//      ];

//  AuthState copyWith({
//    bool loggedIn,
//    LoginType loginType,
//  }) {
//    return AuthState(
//      loggedIn: loggedIn ?? this.loggedIn,
//      loginType: loginType ?? this.loginType,
//    );
//  }
//}

//class AuthBloc extends Bloc<AuthEvent, AuthState> {
//  AuthBloc({
//    @required this.storage,
//  }) : super(AuthState());

//  final IStorage storage;

//  @override
//  Stream<AuthState> mapEventToState(AuthEvent event) async* {
//    if (event is AuthCompleted) yield* _mapAuthCompleteToState();
//    if (event is LogOut) yield* _mapLogOutToState();
//    if (event is ChangeLoginType) yield* _mapChangeLoginTypeToState(event);
//    if (event is ResetAuthBloc) yield* _mapResetAuthBloc();
//  }

//  Stream<AuthState> _mapAuthCompleteToState() async* {
//    yield state.copyWith(loggedIn: true);
//  }

//  Stream<AuthState> _mapLogOutToState() async* {
//    try {
//      await storage.deleteItem(key: CacheKeys.token);

//      yield state.copyWith(loggedIn: false);
//    } catch (e) {}
//  }

//  Stream<AuthState> _mapChangeLoginTypeToState(ChangeLoginType event) async* {
//    yield state.copyWith(loginType: event.loginType);
//  }

//  Stream<AuthState> _mapResetAuthBloc() async* {
//    yield AuthState();
//  }
//}
