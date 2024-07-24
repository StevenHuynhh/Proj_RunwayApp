import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_world/controllers/login_controller.dart'; // Import LoginController
import 'SignUpPage.dart'; // Import the SignUpPage

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = Get.put(LoginController());
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Color(0XFF532B57),
                  Color(0xFF1F0E29),
                ],
                center: Alignment.center,
                radius: 0.9,
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color: Color.fromARGB(255, 215, 91, 226),
                  width: 1,
                ),
              ),
              height: 550,
              width: 300,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 196, 107, 255),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0XFF532B57),
                              blurRadius: 50,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.lock_outline,
                        color: Colors.black,
                        size: 35,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: loginController.emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email Address *',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 85, 83, 83)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: loginController.passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password *',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 85, 83, 83)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                    ),
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          // Navigate to SignUpPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        loginController.loginWithEmail();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white, // Button color
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: const Text('Log In'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
