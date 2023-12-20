import 'dart:async';

import 'package:authentication_repository/authentication_repostitory.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:login_app/login/models/models.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(LoginState()) {
    on<LoginUsernamechanged>(_onUsernameChanged);
    on<LoginPasswordchanged>(_onLoginPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }
  final AuthenticationRepository _authenticationRepository;

  FutureOr<void> _onUsernameChanged(
      LoginUsernamechanged event, Emitter<LoginState> emit) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
        username: username,
        isValid: Formz.validate([state.password, username])));
  }

  FutureOr<void> _onLoginPasswordChanged(
      LoginPasswordchanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
        password: password,
        isValid: Formz.validate([state.username, password])));
  }

  FutureOr<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.login(
            username: state.username.value, password: state.password.value);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
