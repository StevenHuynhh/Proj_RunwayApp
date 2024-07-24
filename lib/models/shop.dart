import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'product.dart';

String transformUrl(String url) {
  if (url.contains("amazon")) {
    return url;
  }

  List<String> urlTokens = url.split('/');

  String newDomain = "https://img.ltwebstatic.com/images3_pi/";
  try {
    for (int i = 6; i < urlTokens.length; i++) {
      newDomain += urlTokens[i];
      if (i != 9) {
        newDomain += "/";
      }
    }
    return newDomain;
  } catch (e) {
    print(e);
  }
  return " ";
}

class Shop extends ChangeNotifier {
  List<Product> _shop = [];
  List<Product> _cart = [];

  List<Product> get shop => _shop;
  List<Product> get cart => _cart;

  // Fetch search results from API
  Future<void> fetchSearchResults(String searchTerm,
      {int maxResults = 10}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('token');

      if (accessToken == null || accessToken.isEmpty) {
        throw 'Access token is not available';
      }

      print('Using access token: $accessToken');

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': accessToken,
      };
      var url = Uri.parse('https://projectrunway.tech/api/search');

      Map<String, dynamic> bodyParameters = {
        'search': searchTerm,
        'max_results': maxResults.toString(),
      };

      http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(bodyParameters),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);

        // Directly parse and create products
        var productsJson = responseBody['results']['ret'] as List;
        _shop = productsJson.map((item) {
          var productName = item['name'] ?? 'Unknown';
          var productUrl = item['url'] ?? 'https://example.com';
          var productImage = item['images'];

          // If we have a buggy yandex-style URL, treat it differently.
          if (productImage.contains('[')) {
            productImage = productImage.replaceAll("'", '"');
            productImage = json.decode(productImage);
          }

          // Check if productImage is a list and take the first URL
          if (productImage is List && productImage.isNotEmpty) {
            print(transformUrl(productImage[0]));
            productImage = transformUrl(productImage[0]);
          }

          // Ensure productImage is a string after the above handling
          productImage = productImage.toString();

          // Remove any square brackets surrounding the URL string
          productImage = productImage.replaceAll(RegExp(r'[\[\]]'), '');

          var product = Product(
            name: productName,
            url: productUrl,
            imagePath: productImage,
          );

          print(
              'Product created: ${product.name}, ${product.url}, ${product.imagePath}');
          return product;
        }).toList();
        notifyListeners();
      } else {
        throw 'Failed to load data: ${response.statusCode}';
      }
    } catch (e) {
      print('Error fetching search results: $e');
    }
  }

  void addToCart(Product item) {
    _cart.add(item);
    notifyListeners();
  }

  void removeFromCart(Product item) {
    _cart.remove(item);
    notifyListeners();
  }
}
