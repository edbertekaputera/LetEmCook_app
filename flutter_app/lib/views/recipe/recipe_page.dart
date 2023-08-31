import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/recipe_list_controller.dart';
import 'package:flutter_app/views/homepage/home_page.dart';
import 'package:flutter_app/views/recipe/modal.dart';
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
            backgroundColor: Colors.red,
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
               return Center(
                  child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                        const CircularProgressIndicator(),
                        Padding(
                          padding: EdgeInsets.only(top: Get.height/23.15, bottom: Get.height/92.6),
                          child: const Text(
                           "Generating recipes...",
                           style: TextStyle(
                              fontWeight: FontWeight.w500
                           ),
                          ),
                        ),
                        const Text("I hope you are having an egg-cellent day!")
                     ],
                  ),
               );
            } else {
               return Padding(
                  padding: EdgeInsets.all(Get.width/28.533),
                  child: Column(
                     children: [
                        Expanded(
                           child: ListView.builder(
                              itemCount: controller.data.recipeList.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                 final recipe = controller.data.recipeList[index];
                                 return Padding(
                                   padding: EdgeInsets.only(top: Get.height/61.733, bottom: Get.height/61.733),
                                   child: Modal(recipe: recipe),
                                 );
                              }
                           ),
                        ),
                     ],
                  ),
               );
            }
         },
         )),
      );
   }
}