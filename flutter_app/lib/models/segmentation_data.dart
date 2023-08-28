import 'dart:convert';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

class SegmentationData {
   late Uint8List _image;
   late List<dynamic> _labels;

   Uint8List get image => _image;
   List<dynamic> get labels => _labels;

   // Constructor
   SegmentationData({required String jsonString}) {
      initialize(jsonString);
   }

   // Converts string bytes to image Uint8List
   void decodeImage(String imgStr) {
      var decoded = base64Decode(imgStr);
      img.Image decodedImg = img.Image.fromBytes(480, 640, decoded, format: img.Format.rgb, channels: img.Channels.rgb);
      _image = Uint8List.fromList(img.encodeJpg(decodedImg));
   }

   // Converts string json to attributes
   void initialize(String jsonStr) {
      var decodedJson = json.decode(jsonStr);
      decodeImage(decodedJson["image"]);
      _labels = (decodedJson["labelmap"] as List);
   }

   List<String> getAllLabels() {
      List<String> strList = [];
      for (var element in _labels) {
         strList.add(element["label"]);
      }
      return strList;
   }

}