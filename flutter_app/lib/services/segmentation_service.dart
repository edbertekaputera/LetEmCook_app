import 'dart:typed_data';

import 'package:http/http.dart' as http; 

class SegmentationServices {
   static var client = http.Client();
   static var url = Uri.http("192.168.50.80:5000", "api/image_segment");

   static Future<String> fetchSegmentationJson(Uint8List frame) async {
      var request = http.MultipartRequest("POST", url);
      var image = http.MultipartFile.fromBytes("image", frame, filename: "image.jpg");
      request.files.add(image);
      var streamedResponse = await client.send(request);
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
         return response.body;
      } else {
         // Fail
         return '{"status":"fail"}';
      }
   }
}