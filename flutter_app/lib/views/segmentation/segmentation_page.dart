
import 'dart:typed_data';
import 'package:flutter_app/controllers/scan_controller.dart';
import 'package:flutter_app/views/camera/camera_page.dart';
import 'package:flutter_app/views/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/segmentation_controller.dart';
import 'package:flutter_app/views/segmentation/add_button.dart';
import 'package:flutter_app/views/segmentation/cancel_button.dart';
import 'package:get/get.dart';

class SegmentationPage extends StatelessWidget {
   final segmentationController = Get.put(SegmentationController());
   final scanController = Get.put(ScanController());

   // Constructor
   SegmentationPage({ required Uint8List frame, Key? key }) : super(key: key) {
      segmentationController.fetchData(frame);
   }
   
   @override
   Widget build(BuildContext context){
      return Scaffold(
         backgroundColor: Colors.white,
         appBar: AppBar(
            title: const Text("Segmentation Results"),
            leading: BackButton(
               color: Colors.white,
               onPressed: () {
                  scanController.reset();
                  Get.to(const CameraPage());
               },
            ),
         ),
         body: SafeArea(
            child: GetX<SegmentationController>(
               builder: (controller) {
                  if (controller.isLoading) {
                     return const Center(
                        child: CircularProgressIndicator(),
                     );
                  } else {
                     return Stack(
                        alignment: Alignment.center,
                        children: [
                           Positioned(
                              top: 0,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0, bottom: 5),
                                child: Container(
                                   width: 410,
                                   height: 400,
                                   decoration: BoxDecoration(
                                       image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: MemoryImage(
                                             controller.data.image
                                          )
                                       ),
                                       borderRadius: BorderRadius.circular(12),
                                   ),
                                ),
                              ),
                           ),
                           (controller.data.labels.isNotEmpty)? const Positioned(
                              top: 425,
                              left: 15,
                              child: Text(
                                 "Found Ingredients:",
                                 textAlign: TextAlign.left,
                                 style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black
                                 ),
                              )
                           ): const Positioned(
                              top: 550,
                              child: Text(
                                 "No Ingredients Found!",
                                 textAlign: TextAlign.center,
                                 style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.red
                                 ),
                              )
                           ),
                           Padding(
                              padding: const EdgeInsets.only(top: 450),
                              child: GridView.builder(
                                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 5,
                                    childAspectRatio: 3.5,
                                 ),
                                 itemCount: controller.data.labels.length,
                                 padding: const EdgeInsets.all(10),
                                 itemBuilder: (context, index) {
                                    return Card(
                                       color: convertHextoColor(controller.data.labels[index]["color"]),
                                       child: Center(
                                          child: Text(controller.data.labels[index]["label"]),
                                       ),
                                    );
                                 }
                              )
                           ),
                           (controller.data.labels.isEmpty)?
                           const Positioned(
                              bottom: 40, 
                              child: SegmentationCancelButton()
                           ):
                           Positioned(
                           bottom: 40,
                           left: 10,
                           right: 10,
                           child: Row(
                              children: [
                                 const Expanded(child: SegmentationCancelButton()),
                                 const SizedBox(width: 15),
                                 Expanded(child: SegmentationAddButton()),
                              ],
                           ),
                        ),
                        
                        ],
                     );
                  }
               },
            ),
         )
      );
   }
}