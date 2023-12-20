import 'dart:async';

import 'package:authentication_repository/authentication_repostitory.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_bloc_event.dart';
part 'authentication_bloc_state.dart';

class AuthenticationBlocBloc
    extends Bloc<AuthenticationBlocEvent, AuthenticationBlocState> {
  AuthenticationBlocBloc(
      {required AuthenticationRepository authenticationRepository,
      required UserRepository userRepository})
      : _authenticationRepostitory = authenticationRepository,
        _userRepository = userRepository,
        super(AuthenticationBlocState.unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(onAuthenticationLogoutRequested);
    _authenticationStatusSubscription = _authenticationRepostitory.status
        .listen((status) => add(_AuthenticationStatusChanged(status)));
  }

  final AuthenticationRepository _authenticationRepostitory;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onAuthenticationStatusChanged(
      _AuthenticationStatusChanged event,
      Emitter<AuthenticationBlocState> emit) async {
    switch (event.status) {
      case AuthenticationStatus.unknown:
        return emit(AuthenticationBlocState.unknown());
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return emit(user != null
            ? AuthenticationBlocState.authenticated(user)
            : AuthenticationBlocState.unauthenticated());
      case AuthenticationStatus.unauthenticated:
        return emit(AuthenticationBlocState.unauthenticated());
    }
  }

  FutureOr<void> onAuthenticationLogoutRequested(
      AuthenticationLogoutRequested event,
      Emitter<AuthenticationBlocState> emit) {
        _authenticationRepostitory.logout();
      }

  _tryGetUser() async {
    try{
      final user = await _userRepository.getUser();
    return user;
    }catch(_){
      return null;
    }
  }
}
