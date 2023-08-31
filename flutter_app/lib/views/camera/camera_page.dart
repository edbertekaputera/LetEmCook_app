import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/scan_controller.dart';
import 'package:flutter_app/views/camera/capture_button.dart';
import 'package:get/get.dart';

import 'camera_viewer.dart';

class CameraPage extends StatelessWidget {
   final _scanController = Get.put(ScanController());

   CameraPage({Key? key}): super(key: key);

   @override
   Widget build(BuildContext context) {
      return Stack(
         alignment: Alignment.center,
         children: [
            CameraViewer(),
            const CaptureButton(),
            Positioned(
               top: Get.height/18.52,
               left: Get.width/21.4,
               child: GestureDetector(
                  child: Icon(
                     Icons.close,
                     color: Colors.white,
                     size: Get.width/8.56,
                     shadows: const [
                        Shadow(
                           color: Colors.black,
                           blurRadius: 10,
                        )
                     ],
                  ),
                  onTap: () {
                     _scanController.cancel();
                  },
               ),
            )
         ],
      );
   }
}