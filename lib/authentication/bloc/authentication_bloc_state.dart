part of 'authentication_bloc_bloc.dart';

class AuthenticationBlocState extends Equatable {
  final AuthenticationStatus status;
  final User user;

  AuthenticationBlocState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  AuthenticationBlocState.unknown() : this._();

  AuthenticationBlocState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  AuthenticationBlocState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}
