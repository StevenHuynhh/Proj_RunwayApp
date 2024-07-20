import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SearchController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> fetchSearchResults(String searchTerm,
      {int maxResults = 10}) async {
    try {
      final SharedPreferences prefs = await _prefs;
      String? accessToken = prefs.getString('token');

      if (accessToken == null || accessToken.isEmpty) {
        throw 'Access token is not available';
      }

      var headers = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $accessToken',
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

        if (responseBody.containsKey('error') && responseBody['error'] != "") {
          var error = responseBody['error'];
          print('Error received from server: $error');
        } else {
          print(responseBody); // Handle the response data as needed
        }
      } else {
        throw 'Failed to load data: ${response.statusCode}';
      }
    } catch (e) {
      print('Error: $e');
      Get.dialog(
        SimpleDialog(
          title: Text('Error'),
          contentPadding: EdgeInsets.all(20),
          children: [Text(e.toString())],
        ),
      );
    }
  }
}
