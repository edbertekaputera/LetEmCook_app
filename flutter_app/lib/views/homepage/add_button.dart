import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/ingredients_controller.dart';
import 'package:get/get.dart';

class HomeAddButton extends StatelessWidget {
   final ingredientsController = Get.put(IngredientsController());

   HomeAddButton({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return TextButton(
         style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
               RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
               )
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade900),
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
               (Set<MaterialState> states) {
               if (states.contains(MaterialState.hovered)) {
                  return Colors.blue.shade900.withOpacity(0.04);
               }
               if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
                  return Colors.blue.shade900.withOpacity(0.12);
               }
               return null; // Defer to the widget's default.
               },
            ),
         ),
         onPressed: () {
            ingredientsController.addIngredientsFromTextBox();
         },
         child: Padding(
            padding: EdgeInsets.only(top: Get.height/92.6, bottom: Get.height/92.6, left: Get.width/28.533, right: Get.width/28.533),
            child: Row(
               children: [
                  const Icon(Icons.add_box, color: Colors.white,),
                  SizedBox(width: Get.width/42.8),
                  const Text(
                     'Add', 
                     style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                     ),
                  ),
               ],
            ),
         )
      );
   }
}