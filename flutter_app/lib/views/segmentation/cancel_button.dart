import 'package:flutter/material.dart';
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
            // Get to Homepage
         },
         child: const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 45, right: 45),
            child: Row(
               children: [
                  Icon(Icons.cancel),
                  SizedBox(width: 10),
                  Text(
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