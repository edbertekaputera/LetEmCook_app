import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class IngredientsController extends GetxController {
   final TextEditingController _ingredientsController = Get.put(TextEditingController());
   final RxList<String> _ingredients = RxList([]);
   final RxString _currentIngredient = RxString("");


   TextEditingController get ingredientsController => _ingredientsController;
   List<String> get ingredients => _ingredients;
   String get currentIngredient => _currentIngredient.value;

   void setCurrentIngredient(String cur) {
      _currentIngredient.value = cur;
   }

   // Add ingredients from List
   void addIngredientsFromList(List<String> strList) {
      for (String element in strList) {
         String lowerIng = element.toLowerCase();
         if (!existsInList(lowerIng)) {
            _ingredients.add(lowerIng);
         }
      }
      _ingredients.refresh();
   }

   @override
   void dispose() {
      _ingredients.clear();
      super.dispose();
   }

   // Add ingredients
   void addIngredientsFromTextBox() {
      if (_ingredientsController.text.isNotEmpty) {
         String lowerIng = _currentIngredient.value.toLowerCase();
         _ingredientsController.text = "";
         _currentIngredient.value = "";
         if (!existsInList(lowerIng)) {
            _ingredients.add(lowerIng);
            _ingredients.refresh();
         } else {
            Get.snackbar("Failed to add ingredient", "$lowerIng already exists.");
         }
      } else {
         Get.snackbar("Failed to add ingredient", "Please input an ingredient before attempting to add it.");
      }
   }

   // Check if exists
   bool existsInList(String ingredient) {
      for (String element in _ingredients) {
         if (element == ingredient) {
            return true;
         }
      }
      return false;
   }

   // Delete Ingredient
   void deleteIngredient(int index) {
      _ingredients.removeAt(index);
      _ingredients.refresh(); 
   }

   // Reset value
   void reset() {
      _ingredients.clear();
      _currentIngredient.value = "";
      _ingredientsController.text = "";
      _ingredients.refresh();
   }
}