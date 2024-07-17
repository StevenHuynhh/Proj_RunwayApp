import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_world/util/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:hello_world/pages/MainPage.dart'; // Adjust import path as per your project structure

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String get email => emailController.text.trim();
  String get password => passwordController.text;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.loginEmail);
      Map<String, String> body = {
        'email': email,
        'password': password,
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        var accessToken = json['accessToken'] as String?;

        if (accessToken != null && accessToken.isNotEmpty) {
          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('token', accessToken);

          emailController.clear();
          passwordController.clear();
          Get.snackbar(
            'Success',
            'Login successful',
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );

          // Navigate to main page or home page
          Get.offAll(() =>
              MainPage()); // Replace MainPage() with your actual page constructor
        } else {
          throw 'Access token format error: Invalid type or null or empty string';
        }
      } else {
        throw "Server returned an error: ${response.statusCode}";
      }
    } catch (error) {
      print('Error: $error');
      Get.dialog(
        SimpleDialog(
          title: Text('Error'),
          contentPadding: EdgeInsets.all(20),
          children: [Text(error.toString())],
        ),
      );
    }
  }
}
