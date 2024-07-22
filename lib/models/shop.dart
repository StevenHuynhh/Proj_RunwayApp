import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'product.dart';

class Shop extends ChangeNotifier {
  List<Product> _shop = [];
  List<Product> _cart = [];

  List<Product> get shop => _shop;
  List<Product> get cart => _cart;

  // Helper function to sanitize URLs
  bool isValidUrl(String url) {
    try {
      // Remove leading/trailing quotes and spaces
      final cleanUrl = url.trim().replaceAll(RegExp(r"^'+|'+$"), "");

      // Check if it's a local asset URL
      if (cleanUrl.startsWith('assets/')) {
        return true;
      }

      // Check if it's a valid web URL
      final uri = Uri.parse(cleanUrl);
      return uri.hasAbsolutePath &&
          (uri.isScheme('http') || uri.isScheme('https'));
    } catch (e) {
      return false;
    }
  }

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
        print('Parsed response body: $responseBody');

        if (responseBody.containsKey('results') &&
            responseBody['results'].containsKey('ret')) {
          var productsJson = responseBody['results']['ret'] as List;
          print('Products JSON: $productsJson');

          _shop = productsJson.map((item) {
            print('Item JSON: $item');

            var productName = item['name'] ?? 'Unknown';
            var productUrl = item['url'] ?? 'https://example.com';
            var productImage = item['images'] ?? 'assets/placeholder.png';

            // Sanitize URLs
            if (!isValidUrl(productUrl)) {
              print('Invalid product URL: $productUrl');
              productUrl = 'https://example.com'; // Provide a default URL
            }

            if (!isValidUrl(productImage)) {
              print('Invalid product image URL: $productImage');
              productImage =
                  'assets/placeholder.png'; // Provide a default image
            }

            var product = Product(
              name: productName,
              url: productUrl,
              imagePath: productImage,
            );

            print(
                'Product created: ${product.name}, ${product.url}, ${product.imagePath}');
            return product;
          }).toList();
        } else {
          print('No products found in the response.');
          _shop = [];
        }
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
