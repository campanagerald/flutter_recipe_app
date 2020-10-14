part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Authenticating extends AuthenticationState {}

class UnAuthenticated extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final UserModel currentUser;

  Authenticated(this.currentUser);

  @override
  List<Object> get props => [currentUser];
}

class AuthenticationFailed extends AuthenticationState {
  final Exception error;

  AuthenticationFailed(this.error);

  @override
  List<Object> get props => [error];
}
