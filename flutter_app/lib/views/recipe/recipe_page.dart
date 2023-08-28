import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/recipe_list_controller.dart';
import 'package:flutter_app/views/homepage/home_page.dart';
import 'package:get/get.dart';

class RecipePage extends StatelessWidget {
   final recipeController = Get.put(RecipeListController());

   // Constructor
   RecipePage({required String ingredients, Key? key}) : super(key: key) {
      recipeController.fetchData(ingredients);
   }

   @override
   Widget build(BuildContext context) {
      return Scaffold(
         backgroundColor: Colors.white,
         appBar: AppBar(
         title: const Text("Food Recipes"),
         leading: BackButton(
            color: Colors.white,
            onPressed: () {
               Get.to(HomePage());
            },
         ),
         ),
         body: SafeArea(child: GetX<RecipeListController>(
         builder: (controller) {
            if (controller.isLoading) {
               return const Center(
                  child: Stack(
                     children: [
                        CircularProgressIndicator(),
                        Positioned(top: 300, child: Text("data"))
                     ]
                  ),
               );
            } else {
               return ListView.builder(
                  itemCount: controller.data.recipeList.length,
                  itemBuilder: (context, index) {
                     final recipe = controller.data.recipeList[index];
                     return Card(
                     child: ListTile(
                        title: Text(recipe.dishName),
                        subtitle: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                           const Text("Ingredients:"),
                           for (var ingredient in recipe.ingredients)
                              Text("- $ingredient"),
                           const SizedBox(height: 8),
                           const Text("Instructions:"),
                           for (var instruction in recipe.instructions)
                              Text("  $instruction"),
                           ],
                        ),
                     ),
                     );
                  }
               );
            }
         },
         )),
      );
   }
}