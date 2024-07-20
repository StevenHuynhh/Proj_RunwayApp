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
          var product = Product.fromJson(item);
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
