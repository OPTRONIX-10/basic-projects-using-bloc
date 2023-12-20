part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginUsernamechanged extends LoginEvent {
  final String username;
  const LoginUsernamechanged(this.username);

   @override
  List<Object> get props => [username];
}

final class LoginPasswordchanged extends LoginEvent {
  final String password;
  const LoginPasswordchanged(this.password);

   @override
  List<Object> get props => [password];
}

final class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
