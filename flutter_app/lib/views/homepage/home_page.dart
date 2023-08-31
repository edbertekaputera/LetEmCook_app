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
            title: const Text("Let Em Cook!"),
            backgroundColor: Colors.red,
            leading: Image.asset(
               'assets/images/icon_transparent.png',
               fit: BoxFit.cover,
            )
         ),
         body: SafeArea(
            child: GetX<IngredientsController>(
              builder: (controller) {
                  return Stack(
                     alignment: Alignment.center,
                     children: [
                        Positioned(
                           top: Get.height/46.3,
                           left: Get.width/42.8,
                           child: SizedBox(
                              width: Get.width/1.476,
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
                           top: Get.height/46.3,
                           left: Get.width/1.381,
                           child: HomeAddButton(),
                        ),
                        Positioned(
                           top: Get.height/9.26,
                           child: Row(
                              children: [
                                 Container(
                                    decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(25),
                                       color: Colors.grey.shade300,
                                    ),
                                    child: Padding(
                                       padding: EdgeInsets.only(top: Get.height/51.444, bottom: Get.height/51.444, left: Get.width/17.12, right: Get.width/17.12),
                                       child: Row(
                                          children: [
                                             const Icon(Icons.fastfood_rounded),
                                             SizedBox(width: Get.width/42.8),
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
                                 SizedBox(width: Get.width/21.4),
                                 HomeSegmentButton(),
                              ],
                           ),
                        ),
                        Positioned(
                           top: Get.height/5.156,
                           child: Container(
                              width: Get.width/1.07,
                              height: Get.height/2.062,
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                 color: Colors.grey.shade200,
                                 borderRadius: BorderRadius.circular(25),
                              ),
                              child: (controller.ingredients.isEmpty)?
                              const Center(child: Text("Please add ingredients"))
                              : 
                              Padding(
                                 padding: EdgeInsets.only(top: Get.height/92.6, left: Get.width/21.4, right: Get.width/21.4, bottom: Get.height/92.6),
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
                           top: Get.height/1.447,
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