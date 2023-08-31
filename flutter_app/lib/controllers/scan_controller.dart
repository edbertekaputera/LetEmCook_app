// ignore_for_file: avoid_print

import 'package:flutter_app/views/homepage/home_page.dart';
import 'package:flutter_app/views/segmentation/segmentation_page.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

class ScanController extends GetxController {
   final RxBool _isInitialized = RxBool(false);
   late CameraController _cameraController;
   late List<CameraDescription> _cameras;
   final RxBool _isOn = RxBool(false);
   // ignore: prefer_final_fields
   late Uint8List _currentFrame;
   int _currentFrameNum = 0;

   bool get isInitialized => _isInitialized.value;
   CameraController get cameraController => _cameraController;
   Uint8List get currentFrame => _currentFrame;

   @override
   void onInit() {
      _initCamera();
      super.onInit();
   }

   @override
   void dispose() {
      _isInitialized.value = false;
      _cameraController.dispose();
      super.dispose();
   }

    // Initialize the camera
   Future<void> _initCamera() async {
      _cameras = await availableCameras();
      _cameraController = CameraController(_cameras[0], ResolutionPreset.medium);
      _cameraController.initialize().then((_) {
         _cameraController.value = _cameraController.value.copyWith(previewSize: const Size(480,480));
         _isInitialized.value = true;
         // Camera Image Stream
         _cameraController.startImageStream((frame) {
            if ( _isOn.value && ++_currentFrameNum % 5 == 0) {
               _currentFrameNum = 0;
               handleImage(frame);
            }
         });

      }).catchError((Object e) {
         if (e is CameraException) {
            switch (e.code) {
               case 'CameraAccessDenied':
                  // Handle access errors here.
                  break;
               default:
                  // Handle other errors here.
                  break;
            }
         }
    });
   }

   // handle Frames
   void handleImage(CameraImage frame) {
      img.Image image = img.Image.fromBytes(frame.width, frame.height, frame.planes[0].bytes, format: img.Format.bgra);
      Uint8List jpeg = Uint8List.fromList(img.encodeJpg(image));
      print("Image Capture!");
      print(jpeg.length);
      _currentFrame = jpeg;
   }

   // Capture
   void capture() {
      _isOn.value =false;
      print("Stopped");
      Get.to(SegmentationPage(frame: _currentFrame));
   }

   void cancel() {
      _isOn.value =false;
      print("Stopped");
      Get.to(HomePage());
   }

   // Reset
   void reset() {
      _isOn.value = true;
      _currentFrameNum = 0;
   }
}