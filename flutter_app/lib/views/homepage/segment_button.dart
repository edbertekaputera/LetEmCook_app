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
            _scanController.reset();
            Get.to(const CameraPage());
         },
         child: const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 70, right: 70),
            child: Row(
               children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 10),
                  Text(
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