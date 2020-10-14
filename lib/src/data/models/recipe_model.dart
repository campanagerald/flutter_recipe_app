import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:recipe_app/src/data/models/ingredient_model.dart';

class RecipeModel extends Equatable {
  final String title;
  final int servings;
  final double readyInMinutes;
  final String imageUrl;
  final List<IngredientModel> ingredients;
  final List<String> steps;
  final bool isFavorite;

  RecipeModel({
    this.title,
    this.servings,
    this.readyInMinutes,
    this.imageUrl,
    this.ingredients,
    this.steps,
    this.isFavorite = false,
  });

  @override
  List<Object> get props => [
        title,
        servings,
        readyInMinutes,
        imageUrl,
        ingredients,
        steps,
      ];

  RecipeModel copyWith({
    String title,
    int servings,
    double readyInMinutes,
    String imageUrl,
    List<IngredientModel> ingredients,
    List<String> steps,
    bool isFavorite,
  }) {
    return RecipeModel(
      title: title ?? this.title,
      servings: servings ?? this.servings,
      readyInMinutes: readyInMinutes ?? this.readyInMinutes,
      imageUrl: imageUrl ?? this.imageUrl,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'servings': servings,
      'readyInMinutes': readyInMinutes,
      'imageUrl': imageUrl,
      'ingredients': ingredients?.map((x) => x?.toMap())?.toList(),
      'steps': steps,
      'isFavorite': isFavorite,
    };
  }

  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RecipeModel(
      title: map['title'],
      servings: map['servings'],
      readyInMinutes: map['readyInMinutes'],
      imageUrl: map['imageUrl'],
      ingredients: List<IngredientModel>.from(
          map['ingredients']?.map((x) => IngredientModel.fromMap(x))),
      steps: List<String>.from(map['steps']),
      isFavorite: map['isFavorite'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipeModel.fromJson(String source) =>
      RecipeModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
