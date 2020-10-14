import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String accountId;
  final String firstName;
  final String lastName;
  final String email;
  final String role;

  UserModel({
    this.id,
    this.accountId,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
  });

  @override
  List<Object> get props {
    return [
      id,
      accountId,
      firstName,
      lastName,
      email,
      role,
    ];
  }

  UserModel copyWith({
    String id,
    String accountId,
    String firstName,
    String lastName,
    String email,
    String role,
  }) {
    return UserModel(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'accountId': accountId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserModel(
      id: map['id'],
      accountId: map['accountId'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      role: map['role'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
