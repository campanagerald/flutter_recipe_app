import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../../core/exceptions.dart';
import '../../../data/models/confirm_password_model.dart';
import '../../../data/models/email_model.dart';
import '../../../data/models/first_name_model.dart';
import '../../../data/models/last_name_model.dart';
import '../../../data/models/password_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/authentication_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final IAuthenticationRepository _authenticationRepository;

  SignUpCubit({@required IAuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(SignUpState());

  void signUp({
    @required String firstName,
    @required String lastName,
    @required String email,
    @required String password,
    @required String confirmPassword,
  }) async {
    final firstNameModel = FirstNameModel.dirty(firstName);
    final lastNameModel = LastNameModel.dirty(lastName);
    final emailModel = EmailModel.dirty(email);
    final passwordModel = PasswordModel.dirty(password);
    final confirmPasswordModel =
        ConfirmPasswordModel.dirty([password, confirmPassword]);

    final status = Formz.validate([
      firstNameModel,
      lastNameModel,
      emailModel,
      passwordModel,
      confirmPasswordModel,
    ]);

    if (status.isInvalid) {
      emit(state.copyWith(
        firstName: firstNameModel,
        lastName: lastNameModel,
        email: emailModel,
        password: passwordModel,
        confirmPassword: confirmPasswordModel,
        status: status,
        error: null,
      ));
    } else {
      if (status.isValidated) {
        try {
          emit(state.copyWith(
            status: FormzStatus.submissionInProgress,
            error: null,
          ));

          final currentUser = await _authenticationRepository.createUser(
            firstName: firstNameModel.value,
            lastName: lastNameModel.value,
            email: emailModel.value,
            password: passwordModel.value,
          );

          emit(state.copyWith(
            currentUser: currentUser,
            error: null,
            status: status,
          ));
        } on FirebaseAuthException catch (error) {
          if (error.code == 'email-already-in-use')
            emit(state.copyWith(
                error: AuthenticationException('Invalid email or password'),
                status: FormzStatus.submissionFailure));
          if (error.code == 'weak-password')
            emit(state.copyWith(
                error: AuthenticationException('Your password is weak'),
                status: FormzStatus.submissionFailure));
        }
      }
    }
  }
}
