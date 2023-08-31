import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/scan_controller.dart';

class CameraViewer extends StatelessWidget {
   // ignore: unused_field
   final _scanController = Get.put(ScanController());

   CameraViewer({Key? key}): super(key: key);

   @override
   Widget build(BuildContext context) {
      return GetX<ScanController>(builder: (controller) {
         if (!controller.isInitialized) {
            return Container();
         }
         return Stack(
            alignment: Alignment.center,
            children: [
               SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: CameraPreview(controller.cameraController),
               ),
            ]
         );
      });
   }
}