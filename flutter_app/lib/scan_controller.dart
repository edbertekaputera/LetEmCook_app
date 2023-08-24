// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:image/image.dart' as img;

class ScanController extends GetxController {
   final RxBool _isInitialized = RxBool(false);
   late CameraController _cameraController;
   late List<CameraDescription> _cameras;
   int _currentFrameNum = 0;
   final RxBool _isOn = RxBool(false);
   final RxList<Uint8List> _currentFrame = RxList([]);
   static const MethodChannel _channel = MethodChannel("LetHimCook_CHANNEL");

   bool get isInitialized => _isInitialized.value;
   CameraController get cameraController => _cameraController;
   RxList<Uint8List> get currentFrame => _currentFrame;

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
         _isInitialized.value = true;
         _isOn.value = true;
         // Camera Image Stream
         _cameraController.startImageStream((frame) {
            if ( _isOn.value && ++_currentFrameNum % 10 == 0) {
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
      print(frame.width);
      print(frame.height);
      print("Image Capture!");
      _currentFrame.clear();
      _currentFrame.add(jpeg);
      _currentFrame.refresh();
      print(jpeg.length);
   }

   void capture() {
      _isOn.value = !_isOn.value;
      print(_isOn.value? "Started" : "Stopped");
   }

   Future<Uint8List>? getSegmentation(Uint8List img) async {
      return _channel.invokeMethod<Uint8List>("getSegmentation")
      .then<Uint8List>((Uint8List? value) => value ?? img);
   }
}