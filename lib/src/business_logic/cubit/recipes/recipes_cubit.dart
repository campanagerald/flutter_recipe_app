import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../data/models/recipe_model.dart';
import '../../../data/repositories/recipe_repository.dart';

part 'recipes_state.dart';

class RecipesCubit extends Cubit<RecipesState> {
  final IRecipeRepository _recipeRepository;

  RecipesCubit({@required IRecipeRepository recipeRepository})
      : _recipeRepository = recipeRepository,
        super(RecipesInitial());

  void fetchRecipes() async {
    emit(RecipesLoading());

    final recipes = await _recipeRepository.getRandomRecipes();

    emit(RecipesLoaded(recipes: recipes));
  }

  void loadMoreRecipes() async {
    emit(RecipesLoaded(
        loadingMore: true, recipes: (state as RecipesLoaded).recipes));

    final recipes = await _recipeRepository.getRandomRecipes();

    emit(RecipesLoaded(
        loadingMore: false,
        recipes: (state as RecipesLoaded).recipes..addAll(recipes)));
  }

  void reloadRecipes() async {
    emit(RecipesLoaded(
        loadingMore: true, recipes: (state as RecipesLoaded).recipes));

    final recipes = await _recipeRepository.getRandomRecipes();

    emit(RecipesLoaded(recipes: recipes));
  }
}
