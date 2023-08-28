import 'dart:typed_data';
import 'package:flutter_app/models/segmentation_data.dart';
import 'package:flutter_app/services/segmentation_service.dart';
import 'package:get/get.dart';

class SegmentationController extends GetxController {
   final RxBool _isLoading = RxBool(false);
   late SegmentationData _data;
   
   SegmentationData get data => _data;
   bool get isLoading => _isLoading.value;

   void setLoading(bool value) {
      _isLoading.value = value;
   }

   void fetchData(Uint8List frame) async {
      setLoading(true);
      var jsonStr = await SegmentationServices.fetchSegmentationJson(frame);
      _data = SegmentationData(jsonString: jsonStr);
      setLoading(false);
   }

}