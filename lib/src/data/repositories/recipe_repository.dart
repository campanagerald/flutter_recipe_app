import 'package:recipe_app/src/data/data_providers/spoonacular_api.dart';
import 'package:recipe_app/src/data/models/ingredient_model.dart';
import 'package:recipe_app/src/data/models/recipe_model.dart';

abstract class IRecipeRepository {
  Future<List<RecipeModel>> getRecipesByType(String type,
      {int offset = 0, int number = 10});
  Future<List<RecipeModel>> getRandomRecipes();
}

class RecipeRepository implements IRecipeRepository {
  final ISpoonacularApi _spoonacularApi;

  RecipeRepository({
    ISpoonacularApi spoonacularApi,
  }) : _spoonacularApi = spoonacularApi;

  @override
  Future<List<RecipeModel>> getRecipesByType(
    String type, {
    int offset = 0,
    int number = 10,
  }) async {
    final results = await _spoonacularApi.complexSearch(
      {
        'type': type,
        'instructionsRequired': true,
        'fillIngredients': true,
        'addRecipeInformation': true,
      },
      offset: offset,
      number: number,
    );

    return _toRecipeModel(results);
  }

  @override
  Future<List<RecipeModel>> getRandomRecipes() async {
    final results = await _spoonacularApi.randomRecipes();
    return _toRecipeModel(results);
  }

  List<RecipeModel> _toRecipeModel(List<Map<String, dynamic>> recipeList) {
    return recipeList
        .map(
          (result) => RecipeModel(
            title: result['title'],
            readyInMinutes: result['readyInMinutes'].toDouble(),
            imageUrl: result['image'],
            servings: result['servings'],
            ingredients: List<IngredientModel>.from(
              result["extendedIngredients"].map(
                (ingredient) => IngredientModel(
                  name: ingredient["originalName"],
                  amount: ingredient["amount"],
                  unit: ingredient["unit"],
                ),
              ),
            ),
            steps: result["analyzedInstructions"].length > 0
                ? List<String>.from(
                    result["analyzedInstructions"][0]["steps"]
                        .map((step) => step["step"]),
                  )
                : null,
          ),
        )
        .toList();
  }
}
