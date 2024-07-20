import 'package:http/http.dart' as http;
import 'package:hello_world/util/api_endpoints.dart';
import 'dart:convert';
import 'package:hello_world/models/product.dart';




class SearchController extends GetxController {
  TextEditingController seachcontroller = TextEditingController();
  String get searchTerm => seachcontroller.text.trim();
  final maxResults = 10;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final String? accessToken = prefs.getString('token');

  Future<Product> fetchSearchResults() async {
  var bodyParameters = {
    'search': searchTerm,
    'max_results': maxResults.toString(),
  };
  final requestUrl = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.search));
  try {
    var response = await http.post(
      requestUrl,
      headers: {
        'Content-Type': 'application/json',
        'authorization': accessToken,
      },
      body: jsonEncode(bodyParameters),
    );

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);

      if (responseBody.containsKey('error') && responseBody['error'] != "") {
        var error = responseBody['error'];
        print('Error received from server: $error');
      } else {
        var _results = responseBody.results.ret;
        var List<Product> entries = [];
        for (var i = 0; i < _results.length; i++) {
            var product = _results[i];     
            List<String> images = [];

          if (product.images[0] == '[') {
              images = product.images.substring(1, product.images.length - 1).split(',').map((item) => item.substring(1, item.length - 1)).toList();
              for (var j = 0; j < images.length; j++) {
                var temp = images[j];
                if (temp[0] == "'") {
                  var h = temp.split("'");
                  images[j] = h[1];
                }
              }
          } else {
            images = [product.images];
          }
          final image = images[0];
          final entry = Product(
            "name":product.name,
            "imagePath":image,
            "description":product.id,
          )
          entries.add(entry);
          return entries;
        }
      
      }
      } else {
          throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
    }
  }

}
