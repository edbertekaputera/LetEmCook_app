import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/scan_controller.dart';
import 'package:get/get.dart';

class CaptureButton extends GetView<ScanController> {
  const CaptureButton({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return Positioned(
         bottom: Get.height/15.433,
         child: GestureDetector(
            onTap: () => controller.capture(),
            child: Container(
               height: Get.height/11.575,
               width: Get.width/5.35,
               padding: const EdgeInsets.all(5),
               decoration: BoxDecoration(
                  border: Border.all(color: Colors.white60, width: 5),
                  shape: BoxShape.circle,
               ),
               child: Container(
                  decoration: const BoxDecoration(
                     color: Colors.white,
                     shape: BoxShape.circle
                  ),
               ),
            ),
         )
      );
   }
}
