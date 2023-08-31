import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/ingredients_controller.dart';
import 'package:flutter_app/controllers/segmentation_controller.dart';
import 'package:flutter_app/views/homepage/home_page.dart';
import 'package:get/get.dart';

class SegmentationAddButton extends StatelessWidget {
   final _segmentationController = Get.put(SegmentationController());
   final _ingredientsController = Get.put(IngredientsController());

   SegmentationAddButton({Key? key}) : super(key: key);

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
            _ingredientsController.addIngredientsFromList(
               _segmentationController.data.getAllLabels()
            );
            
            Get.to(HomePage());
         },
         child: Padding(
            padding: EdgeInsets.only(top: Get.height/92.6, bottom: Get.height/92.6, left: Get.width/28.533, right: Get.width/28.533),
            child: Row(
               children: [
                  const Icon(Icons.add_box, color: Colors.white,),
                  SizedBox(width: Get.width/42.8),
                  const Text(
                     'Add Ingredients', 
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