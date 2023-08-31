import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/ingredients_controller.dart';
import 'package:flutter_app/views/recipe/recipe_page.dart';
import 'package:get/get.dart';

class HomeRecipeButton extends StatelessWidget {
   final ingredientsController = Get.put(IngredientsController());

   HomeRecipeButton({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return TextButton(
         style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
               RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
               )
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.red.shade900),
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
               (Set<MaterialState> states) {
               if (states.contains(MaterialState.hovered)) {
                  return Colors.red.shade900.withOpacity(0.04);
               }
               if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
                  return Colors.red.shade900.withOpacity(0.12);
               }
               return null; // Defer to the widget's default.
               },
            ),
         ),
         onPressed: () {
            if (ingredientsController.ingredients.length < 3) {
               Get.snackbar("Fail to generate recipe", "Please enter at least 3 ingredients.");
            } else {
               String ingredientStr = "";
               for (String element in ingredientsController.ingredients) {
                  ingredientStr += "$element, ";
               }
               ingredientStr = ingredientStr.substring(0, ingredientStr.length - 2);
               ingredientsController.reset();
               Get.to(RecipePage(ingredients: ingredientStr));
            }
         },
         child: Padding(
            padding: EdgeInsets.only(top: Get.height/185.2, bottom: Get.height/185.2, left: Get.width/12.229, right: Get.width/12.229),
            child: Row(
               children: [
                  Icon(
                     Icons.food_bank_rounded, 
                     size: Get.width/8.56,
                     color: Colors.white,
                  ),
                  SizedBox(width: Get.width/28.533),
                  const Text(
                     'Generate Recipe', 
                     style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                     ),
                  ),
               ],
            ),
         )
      );
   }
}