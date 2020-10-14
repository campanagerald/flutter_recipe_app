part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final FormzStatus status;
  final FirstNameModel firstName;
  final LastNameModel lastName;
  final EmailModel email;
  final PasswordModel password;
  final ConfirmPasswordModel confirmPassword;
  final Exception error;
  final UserModel currentUser;

  SignUpState({
    this.status = FormzStatus.pure,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.confirmPassword,
    this.error,
    this.currentUser,
  });

  SignUpState copyWith({
    FormzStatus status,
    FirstNameModel firstName,
    LastNameModel lastName,
    EmailModel email,
    PasswordModel password,
    ConfirmPasswordModel confirmPassword,
    Exception error,
    UserModel currentUser,
  }) {
    return SignUpState(
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      error: error != null ? error : null,
      currentUser: currentUser ?? this.currentUser,
    );
  }

  @override
  List<Object> get props => [
        status,
        firstName,
        lastName,
        email,
        password,
        confirmPassword,
        error,
        currentUser,
      ];
}
