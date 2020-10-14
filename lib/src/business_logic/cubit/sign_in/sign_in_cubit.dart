import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../../core/exceptions.dart';
import '../../../data/models/email_model.dart';
import '../../../data/models/password_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/authentication_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final IAuthenticationRepository _authenticationRepository;

  SignInCubit({@required IAuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(SignInState());

  void signIn({
    @required String email,
    @required String password,
  }) async {
    final emailModel = EmailModel.dirty(email);
    final passwordModel = PasswordModel.dirty(password);

    var status = Formz.validate([emailModel, passwordModel]);

    if (status.isInvalid) {
      emit(state.copyWith(
          email: emailModel,
          password: passwordModel,
          status: status,
          error: null));
    } else {
      if (status.isValidated) {
        emit(state.copyWith(
          status: FormzStatus.submissionInProgress,
          error: null,
        ));

        try {
          final currentUser = await _authenticationRepository
              .signInWithEmailAndPassword(email, password);

          emit(state.copyWith(
            currentUser: currentUser,
            error: null,
            status: status,
          ));
        } on FirebaseAuthException catch (error) {
          if (error.code == 'user-not-found' ||
              error.code == 'wrong-password' ||
              error.code == 'invalid-email')
            emit(state.copyWith(
                error: AuthenticationException('Invalid email or password'),
                status: FormzStatus.submissionFailure));
          else if (error.code == 'too-many-requests') {
            emit(state.copyWith(
                error: AuthenticationException('Too many requests'),
                status: FormzStatus.submissionFailure));
          }
        }
      }
    }
  }
}
