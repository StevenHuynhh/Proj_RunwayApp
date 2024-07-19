import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_world/pages/Login_page.dart';
import 'package:hello_world/util/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegistrationController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> registerWithEmail(
    String username,
    String email,
    String password,
    TextEditingController usernameController,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url =
          Uri.parse(ApiEndpoints.baseUrl + '/signup'); // Adjust endpoint path

      Map<String, dynamic> body = {
        'username': username,
        'email': email,
        'password': password,
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        // Check if the response contains an error message
        if (json['error'] == "") {
          var accessToken = json['accessToken'] as String?;
          Get.snackbar(
            'Success',
            'Registration successful',
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );

          if (accessToken != null && accessToken.isNotEmpty) {
            final SharedPreferences? prefs = await _prefs;
            await prefs?.setString('token', accessToken);

            // Clear fields after successful registration
            usernameController.clear();
            emailController.clear();
            passwordController.clear();

            // Navigate to login page
            Get.offAll(() => const LoginPage());
          } /*else {
            throw 'Access token format error: accessToken is null or empty';
          }*/
        } else {
          throw 'Registration failed: ${json['error']}';
        }
      } else if (response.statusCode == 400) {
        // Handle specific error for duplicate email
        final json = jsonDecode(response.body);
        throw 'Registration failed: ${json['error']}';
      } else {
        throw "Server returned an error: ${response.statusCode}";
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
