import 'package:flutter/material.dart';
import 'package:flutter_app/models/recipe.dart';
import 'package:get/get.dart';

class Modal extends StatelessWidget {
   late final Recipe _recipe;
   
   Modal({required Recipe recipe, Key? key }) : super(key: key) {
      _recipe = recipe;
   }

   Widget buildSheet() => DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.7,
      maxChildSize: 0.9,
      builder: (_, controller) => Container(
         decoration: const BoxDecoration(
            color: Colors.white,          
         ),
         padding: const EdgeInsets.all(20),
         child: Stack(
            children: [
               const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Icon(
                     Icons.arrow_drop_down,
                  )
               ]),
               Positioned(
                  top: Get.height/32.15,
                  child: SizedBox(
                     width: Get.width * 0.9,
                     child: Column(
                        children: [
                           Text(
                              _recipe.dishName.toString(),
                              style: const TextStyle(
                                 fontSize: 30,
                                 fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.center,
                           ),
                           Padding(
                              padding: EdgeInsets.only(top: Get.height/70.6),
                              child: Align(
                                 alignment: Alignment.centerLeft,
                                 child: Text(
                                    "Cooking time: ${_recipe.cookingTime}\nCalories: ${_recipe.calories}\nProtein: ${_recipe.protein}",
                                    style: const TextStyle(
                                       fontSize: 15,
                                       fontWeight: FontWeight.w600,
                                    ),
                                 ),
                              )
                           ),
                           const Padding(
                              padding: EdgeInsets.only(),
                              child: Divider(
                                 thickness: 2,
                              ),
                           ),
                           Padding(
                              padding: EdgeInsets.only(top: Get.height/92.6),
                              child: const Align(
                                 alignment: Alignment.centerLeft,
                                 child: Text(
                                    "Ingredients",
                                    style: TextStyle(
                                       fontSize: 25,
                                       fontWeight: FontWeight.w600,
                                    ),
                                 ),
                              )
                           ),
                           Padding(
                              padding: EdgeInsets.only(top: Get.height/92.6),
                              child: Container(
                                 height: Get.height * 0.03 * _recipe.ingredients.length,
                                 decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10)
                                 ),
                                 child: Padding(
                                 padding: const EdgeInsets.all(10.0),
                                 child: ListView.builder(
                                       itemCount: _recipe.ingredients.length,
                                       scrollDirection: Axis.vertical,
                                       itemBuilder: (context, index) {
                                          return Padding(
                                             padding: EdgeInsets.only(top: Get.height/185.2),
                                             child: Text(
                                                "- ${_recipe.ingredients[index]}",
                                             ),
                                          );
                                       },
                                    ),
                                 ),
                              )
                           ),
                           Padding(
                              padding: EdgeInsets.only(top: Get.height/61.733),
                              child: const Align(
                                 alignment: Alignment.centerLeft,
                                 child: Text(
                                    "Instructions",
                                    style: TextStyle(
                                       fontSize: 25,
                                       fontWeight: FontWeight.w600,
                                    ),
                                 ),
                              )
                           ),
                           Padding(
                              padding: EdgeInsets.only(top: Get.height/92.6),
                              child: Container(
                                 decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10)
                                 ),
                                 height: Get.height * 0.5 - Get.height * 0.03 * _recipe.ingredients.length,
                                 child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListView.builder(
                                       itemCount: _recipe.instructions.length,
                                       scrollDirection: Axis.vertical,
                                       itemBuilder: (context, index) {
                                          return Padding(
                                             padding: EdgeInsets.only(top: Get.height/185.2),
                                             child: Text(
                                                _recipe.instructions[index],
                                             ),
                                          );
                                       },
                                    ),
                                 ),
                              )
                           ),
                           
                        ],
                     ),
                  )
               ),
            ],
         )),
   );

   @override
   Widget build(BuildContext context){
      return TextButton(
         style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(15),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
               RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
               )
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.orange.shade900),
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
               (Set<MaterialState> states) {
               if (states.contains(MaterialState.hovered)) {
                  return Colors.orange.shade900.withOpacity(0.04);
               }
               if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
                  return Colors.orange.shade900.withOpacity(0.12);
               }
               return null; // Defer to the widget's default.
               },
            ),
         ),

         onPressed: () => {
            showModalBottomSheet(
               isScrollControlled: true,
               backgroundColor: Colors.transparent,
               context: context,
               builder: (context) => buildSheet(),
            ),
         },

         child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                  Padding(
                     padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                     child: Text(
                        _recipe.dishName,
                        style: const TextStyle(
                           fontSize: 20, 
                           fontWeight: FontWeight.bold,
                           color: Colors.white
                        ),
                     ),
                  ),
                  Padding(
                     padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                     child: Text(
                        "Cooking Time: ${_recipe.cookingTime}",
                        style: const TextStyle(
                           fontSize: 15,
                           color: Colors.white
                        ),
                     ),
                  ),
                  Padding(
                     padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                     child: Text(
                        "Calories: ${_recipe.calories}",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                           fontSize: 15,
                           color: Colors.white,
                        ),
                     ),
                  ),
                  Padding(
                     padding: const EdgeInsets.only(top: 5, bottom: 20, left: 20, right: 20),
                     child: Text(
                        "Protein: ${_recipe.protein}",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                           fontSize: 15,
                           color: Colors.white,
                        ),
                     ),
                  ),
              ],
            ),
         ),
      );
   }
}