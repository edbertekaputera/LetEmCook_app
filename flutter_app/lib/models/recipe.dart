import 'dart:convert';

class Recipe {
  final String dishName, cookingTime, calories, protein;
  final List<String> ingredients;
  final List<String> instructions;

  Recipe(
      {required this.dishName,
      required this.ingredients,
      required this.instructions,
      required this.cookingTime,
      required this.calories,
      required this.protein});
}

class RecipeList {
  late List<Recipe> _recipeList;

  List<Recipe> get recipeList => _recipeList;

  // Constructor
  RecipeList({required String jsonString}) {
    initialize(jsonString);
  }

  // Converts json string to type List<Recipe>
  void initialize(String jsonStr) {
    final List<dynamic> responseData = json.decode(jsonStr);
    _recipeList = responseData
        .map((jsonRecipe) => Recipe(
              dishName: jsonRecipe['dishName'],
              ingredients:
                  (jsonRecipe['ingredients'] as List<dynamic>).cast<String>(),
              instructions:
                  (jsonRecipe['instructions'] as List<dynamic>).cast<String>(),
               cookingTime: jsonRecipe['cookingTime'],
               calories: jsonRecipe['calories'],
               protein: jsonRecipe['protein']
            ))
        .toList();
  }
}
