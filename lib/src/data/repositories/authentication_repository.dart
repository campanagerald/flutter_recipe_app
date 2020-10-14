import 'package:flutter/material.dart';

import '../data_providers/firebase_api.dart';
import '../models/user_model.dart';

abstract class IAuthenticationRepository {
  Future<UserModel> createUser({
    @required String firstName,
    @required String lastName,
    @required String email,
    @required String password,
  });

  Future<UserModel> getCurrentUser();

  Future<UserModel> signInWithEmailAndPassword(String email, String password);

  Future<void> signOut();
}

class AuthenticationRepository implements IAuthenticationRepository {
  final FirebaseApi _firebaseDataSource;

  AuthenticationRepository({
    @required FirebaseApi firebaseDataSource,
  }) : _firebaseDataSource = firebaseDataSource;

  @override
  Future<UserModel> getCurrentUser() async {
    final user = _firebaseDataSource.getCurrentUser();

    if (user == null) return null;

    final userDoc = await _firebaseDataSource.getUserByAccountId(user.uid);
    return UserModel.fromMap(userDoc);
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    final userCredential =
        await _firebaseDataSource.signInWithEmailAndPassword(email, password);

    final userDoc =
        await _firebaseDataSource.getUserByAccountId(userCredential.user.uid);

    return UserModel.fromMap(userDoc)
        .copyWith(email: userCredential.user.email);
  }

  @override
  Future<void> signOut() async {
    await _firebaseDataSource.signOut();
  }

  Future<UserModel> createUser({
    String firstName,
    String lastName,
    String email,
    String password,
  }) async {
    try {
      final userCredential = await _firebaseDataSource
          .registerWithEmailAndPassword(email, password);

      final result = await _firebaseDataSource.createUser(
        accountId: userCredential.user.uid,
        firstName: firstName,
        lastName: lastName,
        role: 'user',
      );

      return UserModel.fromMap(result).copyWith(
        email: userCredential.user.email,
      );
    } catch (error) {
      rethrow;
    }
  }
}
