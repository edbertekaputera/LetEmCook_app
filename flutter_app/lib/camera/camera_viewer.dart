import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../scan_controller.dart';

class CameraViewer extends StatelessWidget {
   const CameraViewer({Key? key}): super(key: key);

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
               SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Container(
                     decoration: BoxDecoration(
                        image: DecorationImage(
                           fit: BoxFit.cover,
                           opacity: 0.4,
                           image: MemoryImage(
                              controller.currentFrame[0]
                           )
                        )
                     ),
                  ),
               ),
            ],
         );
      });
   }
}