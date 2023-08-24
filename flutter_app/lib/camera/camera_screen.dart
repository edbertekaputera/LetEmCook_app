import 'package:flutter/material.dart';
import 'package:flutter_app/camera/capture_button.dart';

import 'camera_viewer.dart';

class CameraScreen extends StatelessWidget {
   const CameraScreen({Key? key}): super(key: key);

   @override
   Widget build(BuildContext context) {
      return const Stack(
         alignment: Alignment.center,
         children: [
            CameraViewer(),
            CaptureButton(),
         ],
      );
   }
}