
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
   final _segmentationController = Get.put(SegmentationController());
   final _scanController = Get.put(ScanController());

   // Constructor
   SegmentationPage({ required Uint8List frame, Key? key }) : super(key: key) {
      _segmentationController.fetchData(frame);
   }
   
   @override
   Widget build(BuildContext context){
      return Scaffold(
         backgroundColor: Colors.white,
         appBar: AppBar(
            title: const Text("Segmentation Results"),
            backgroundColor: Colors.red,
            leading: BackButton(
               color: Colors.white,
               onPressed: () {
                  _scanController.reset();
                  Get.to(CameraPage());
               },
            ),
         ),
         body: SafeArea(
            child: GetX<SegmentationController>(
               builder: (controller) {
                  if (controller.isLoading) {
                     return Center(
                        child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                              const CircularProgressIndicator(),
                              Padding(
                                 padding: EdgeInsets.only(top: Get.height/23.15, bottom: Get.height/92.6),
                                 child: const Text(
                                    "Segmenting Images...",
                                    style: TextStyle(
                                       fontWeight: FontWeight.w500
                                    ),
                                 ),
                              ),
                              const Text("Please doughnut leave yet!")
                           ],
                        ),
                     );
                  } else {
                     return Stack(
                        alignment: Alignment.center,
                        children: [
                           Positioned(
                              top: 0,
                              child: Padding(
                                padding: EdgeInsets.only(top: Get.height/92.6, bottom: Get.height/185.2),
                                child: Container(
                                   width: Get.width/1.044,
                                   height: Get.height/2.315,
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
                           (controller.data.labels.isNotEmpty)? 
                           Positioned(
                              top: Get.height/2.179,
                              left: Get.width/28.533,
                              child: const Text(
                                 "Found Ingredients:",
                                 textAlign: TextAlign.left,
                                 style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black
                                 ),
                              )
                           ): Positioned(
                              top: Get.height/1.684,
                              child: const Text(
                                 "No Ingredients Found!",
                                 textAlign: TextAlign.center,
                                 style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.red
                                 ),
                              )
                           ),
                           Padding(
                              padding: EdgeInsets.only(top: Get.height/2.058, bottom: Get.height/8.418),
                              child: GridView.builder(
                                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: Get.width/42.8,
                                    mainAxisSpacing: Get.height/185.2,
                                    childAspectRatio: 3.5,
                                 ),
                                 itemCount: controller.data.labels.length,
                                 padding: EdgeInsets.only(top: Get.height/92.6, bottom:  Get.height/92.6, left: Get.width/42.8, right: Get.width/42.8),
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
                           Positioned(
                              bottom: Get.height/23.15, 
                              child: const SegmentationCancelButton()
                           ):
                           Positioned(
                           bottom: Get.height/23.15,
                           left: Get.width/42.8,
                           right: Get.width/42.8,
                           child: Row(
                              children: [
                                 const Expanded(child: SegmentationCancelButton()),
                                 SizedBox(width: Get.width/28.533),
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