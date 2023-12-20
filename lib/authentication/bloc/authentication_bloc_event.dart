part of 'authentication_bloc_bloc.dart';

sealed class AuthenticationBlocEvent extends Equatable {
  const AuthenticationBlocEvent();

  @override
  List<Object> get props => [];
}

final class _AuthenticationStatusChanged extends AuthenticationBlocEvent {
  final AuthenticationStatus status;

  const _AuthenticationStatusChanged(this.status);
}

final class AuthenticationLogoutRequested extends AuthenticationBlocEvent {}
