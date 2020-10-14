part of 'recipes_cubit.dart';

abstract class RecipesState extends Equatable {
  const RecipesState();

  @override
  List<Object> get props => [];
}

class RecipesInitial extends RecipesState {}

class RecipesLoading extends RecipesState {}

class RecipesLoaded extends RecipesState {
  final List<RecipeModel> recipes;
  final bool loadingMore;

  RecipesLoaded({this.recipes, this.loadingMore = false});

  @override
  List<Object> get props => [recipes, loadingMore];

  RecipesLoaded copyWith({
    List<RecipeModel> recipes,
    bool loadingMore,
  }) {
    return RecipesLoaded(
      recipes: recipes ?? this.recipes,
      loadingMore: loadingMore ?? this.loadingMore,
    );
  }
}
