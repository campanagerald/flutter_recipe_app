import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/src/core/exceptions.dart';

abstract class IFirebaseApi {
  User getCurrentUser();

  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
  );

  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  );

  Future<void> signOut();

  Future<Map<String, dynamic>> createUser({
    String accountId,
    String firstName,
    String lastName,
    String role,
  });

  Future<Map<String, dynamic>> getUserByAccountId(String accountId);
}

class _Collections {
  static const String users = 'users';
}

class FirebaseApi implements IFirebaseApi {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  FirebaseApi({
    @required FirebaseAuth auth,
    @required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

  @override
  User getCurrentUser() {
    return _auth.currentUser;
  }

  @override
  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
  ) {
    return _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<Map<String, dynamic>> createUser({
    String accountId,
    String firstName,
    String lastName,
    String role,
  }) async {
    final users = _firestore.collection('users');
    final documentReference = await users.add({
      'accountId': accountId,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
    });

    final documentSnapshot = await documentReference.get();
    return documentSnapshot.data();
  }

  @override
  Future<Map<String, dynamic>> getUserByAccountId(String accountId) async {
    final snapshot = await _firestore
        .collection(_Collections.users)
        .where('accountId', isEqualTo: accountId)
        .get();

    if (snapshot.docs.isEmpty) {
      throw DocumentNotFoundException();
    }

    return snapshot.docs.first.data();
  }
}
