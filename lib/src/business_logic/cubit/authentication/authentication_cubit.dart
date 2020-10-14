import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/exceptions.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/authentication_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final IAuthenticationRepository _authenticationRepository;

  AuthenticationCubit({
    @required IAuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(Authenticating());

  void authenticate() async {
    try {
      emit(Authenticating());

      final currentUser = await _authenticationRepository.getCurrentUser();

      if (currentUser == null) {
        emit(UnAuthenticated());
      } else {
        emit(Authenticated(currentUser));
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found')
        emit(AuthenticationFailed(
            DocumentNotFoundException('Invalid email or password')));
    }
  }

  void signOut() async {
    await _authenticationRepository.signOut();
    emit(UnAuthenticated());
  }

  void signInSuccess(UserModel currentUser) async {
    emit(Authenticated(currentUser));
  }

  void signUpSuccess(UserModel currentUser) async {
    emit(Authenticated(currentUser));
  }
}
