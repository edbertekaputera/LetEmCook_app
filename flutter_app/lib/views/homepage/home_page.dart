import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/ingredients_controller.dart';
import 'package:flutter_app/views/homepage/add_button.dart';
import 'package:flutter_app/views/homepage/recipe_button.dart';
import 'package:flutter_app/views/homepage/segment_button.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
   // ignore: unused_field
   final _ingredientsController = Get.put(IngredientsController()); 

   HomePage({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context){
      return Scaffold(
         appBar: AppBar(
            title: const Text("Let Him Cook!"),
            automaticallyImplyLeading: false,
         ),
         body: SafeArea(
            child: GetX<IngredientsController>(
              builder: (controller) {
                  return Stack(
                     alignment: Alignment.center,
                     children: [
                        Positioned(
                           top: 20,
                           left: 10,
                           child: SizedBox(
                              width: 290,
                              child: TextField( 
                                 decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Enter an ingredient"
                                 ),
                                 controller: controller.ingredientsController,
                                 onChanged: (value) {
                                    controller.setCurrentIngredient(value);
                                 },
                              ),
                           ),
                        ),
                        Positioned(
                           top: 20,
                           left: 310,
                           child: HomeAddButton(),
                        ),
                        Positioned(
                           top: 100,
                           child: Row(
                              children: [
                                 Container(
                                    decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(25),
                                       color: Colors.grey.shade300,
                                    ),
                                    child: Padding(
                                       padding: const EdgeInsets.only(top: 18, bottom: 18, left: 25, right: 25),
                                       child: Row(
                                          children: [
                                             const Icon(Icons.fastfood_rounded),
                                             const SizedBox(width: 10),
                                             Text(
                                                '${controller.ingredients.length}', 
                                                style: const TextStyle(
                                                   color: Colors.black,
                                                   fontSize: 20,
                                                   fontWeight: FontWeight.bold
                                                ),
                                             ),
                                          ],
                                       ),
                                    )
                                 ),
                                 const SizedBox(width: 20),
                                 HomeSegmentButton(),
                              ],
                           ),
                        ),
                        Positioned(
                           top: 180,
                           child: Container(
                              width: 400,
                              height: 450,
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                 color: Colors.grey.shade200,
                                 borderRadius: BorderRadius.circular(25),
                              ),
                              child: (controller.ingredients.isEmpty)?
                              const Center(child: Text("Please add ingredients"))
                              : 
                              Padding(
                                 padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                                 child: Align(
                                    alignment: Alignment.topLeft,
                                    child: ListView.builder(
                                       itemCount: controller.ingredients.length,
                                       scrollDirection: Axis.vertical,
                                       key: UniqueKey(),
                                       itemBuilder: (context, index) {
                                          return Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                                Chip(
                                                   labelStyle: const TextStyle(
                                                      fontSize: 25,
                                                   ),
                                                   label: Text(controller.ingredients[index]),
                                                   onDeleted: () {
                                                      controller.deleteIngredient(index);
                                                   },
                                                ),
                                             ],
                                          );
                                       }
                                    ),
                                 ),
                              ),
                           ),
                        ),
                        Positioned(
                           top: 640,
                           child: HomeRecipeButton()
                        ),
                     ],
                  );
              }
            )
         )
      );
   }
}