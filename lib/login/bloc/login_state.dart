part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState(
      {this.status = FormzSubmissionStatus.initial,
      this.username = const Username.pure(),
      this.password = const Password.pure(),
      this.isValid = false});

  final FormzSubmissionStatus status;
  final Username username;
  final Password password;
  final bool isValid;

  LoginState copyWith(
      {FormzSubmissionStatus? status,
      Username? username,
      Password? password,
      bool? isValid}) {
    return LoginState(
        isValid: isValid ?? this.isValid,
        status: status ?? this.status,
        username: username ?? this.username,
        password: password ?? this.password);
  }

  @override
  List<Object> get props => [status, username, password];
}
