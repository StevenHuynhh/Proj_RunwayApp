import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:hello_world/util/api_endpoints.dart';
import 'dart:convert';

class SearchController extends GetxController {
  TextEditingController seachcontroller = TextEditingController();
  String get searchTerm => seachcontroller.text.trim();
  final maxResults = 10;

  Future<void> fetchSearchResults() async {
    var bodyParameters = {
      'search': searchTerm,
      'max_results': maxResults.toString(),
    };
    final requestUrl = Uri.parse('https://projectrunway.tech/api/search');
    try {
      var response = await http.post(
        requestUrl,
        headers: {
          'Content-Type': 'application/json',
          'authorization': "insert your token here",
        },
        body: jsonEncode(bodyParameters),
      );

      print(response.body);

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);

        if (responseBody.containsKey('error') && responseBody['error'] != "") {
          var error = responseBody['error'];
          print('Error received from server: $error');
        } else {
          print(responseBody); // You can handle stuff from here now
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
    }
  }
}
