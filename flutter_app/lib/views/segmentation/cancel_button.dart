import 'package:flutter/material.dart';
import 'package:flutter_app/views/homepage/home_page.dart';
import 'package:get/get.dart';

class SegmentationCancelButton extends StatelessWidget {
   const SegmentationCancelButton({Key? key}) : super(key: key);

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
            Get.to(HomePage());
         },
         child: Padding(
            padding: EdgeInsets.only(top: Get.height/92.6, bottom: Get.height/92.6, left: Get.width/9.511, right: Get.width/9.511),
            child: Row(
               children: [
                  const Icon(Icons.cancel, color: Colors.white,),
                  SizedBox(width: Get.width/42.8),
                  const Text(
                     'Cancel', 
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