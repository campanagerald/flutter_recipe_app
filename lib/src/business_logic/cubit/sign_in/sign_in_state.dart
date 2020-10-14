part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final FormzStatus status;
  final EmailModel email;
  final PasswordModel password;
  final Exception error;
  final UserModel currentUser;

  SignInState({
    this.status = FormzStatus.pure,
    this.email,
    this.password,
    this.error,
    this.currentUser,
  });

  SignInState copyWith({
    FormzStatus status,
    EmailModel email,
    PasswordModel password,
    Exception error,
    UserModel currentUser,
  }) {
    return SignInState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      error: error != null ? error : null,
      currentUser: currentUser ?? this.currentUser,
    );
  }

  @override
  List<Object> get props => [status, email, password, error, currentUser];
}
