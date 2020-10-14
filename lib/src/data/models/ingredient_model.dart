import 'dart:convert';

import 'package:equatable/equatable.dart';

class IngredientModel extends Equatable {
  final String name;
  final double amount;
  final String unit;

  IngredientModel({
    this.name,
    this.amount,
    this.unit,
  });

  IngredientModel copyWith({
    String name,
    double amount,
    String unit,
  }) {
    return IngredientModel(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'amount': amount,
      'unit': unit,
    };
  }

  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return IngredientModel(
      name: map['name'],
      amount: map['amount'],
      unit: map['unit'],
    );
  }

  String toJson() => json.encode(toMap());

  factory IngredientModel.fromJson(String source) =>
      IngredientModel.fromMap(json.decode(source));

  @override
  List<Object> get props => [name, amount, unit];

  @override
  bool get stringify => true;
}
