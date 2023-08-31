import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/scan_controller.dart';
import 'package:flutter_app/views/camera/camera_page.dart';
import 'package:get/get.dart';

class HomeSegmentButton extends StatelessWidget {
   final _scanController = Get.put(ScanController());
   HomeSegmentButton({Key? key}) : super(key: key);

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
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
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
            _scanController.reset();
            Get.to(CameraPage());
         },
         child: Padding(
            padding: EdgeInsets.only(top: Get.height/92.6, bottom: Get.height/92.6, left: Get.width/6.114, right: Get.width/6.114),
            child: Row(
               children: [
                  const Icon(Icons.camera_alt, color: Colors.white,),
                  SizedBox(width: Get.width/42.8),
                  const Text(
                     'Use Camera', 
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