import 'package:http/http.dart' as http;

class RecipeServices {
   static var client = http.Client();
   static var url = Uri.http("192.168.50.80:5000", "api/getRecipe");

   static Future<String> fetchRecipes(String ingredients) async {
      final updatedUrl = url.replace(queryParameters: {'ingredients': ingredients});
      final response = await client.get(updatedUrl);

      if (response.statusCode == 200) {
         return response.body;
      } else {
         return '{"status":"fail with response code ${response.statusCode}"}';
      }
   }
}
