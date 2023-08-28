import 'package:get/get.dart';
import 'package:flutter_app/models/recipe.dart';
import 'package:flutter_app/services/recipe_services.dart';


class RecipeListController extends GetxController {
   final RxBool _isLoading = RxBool(false);
   late RecipeList _data;

   RecipeList get data => _data;
   bool get isLoading => _isLoading.value;

   void setLoading(bool value) {
         _isLoading.value = value;
   }

   void fetchData(String ingredients) async {
      setLoading(true);
      var jsonStr = await RecipeServices.fetchRecipes(ingredients);
      _data = RecipeList(jsonString: jsonStr);
      setLoading(false);
   }
}