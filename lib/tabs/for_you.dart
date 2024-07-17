import 'package:flutter/material.dart';
import 'package:hello_world/pages/Intro_page.dart';

class SignOutTab extends StatelessWidget {
  const SignOutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Do you want to sign out?',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white, // Adjust text color for visibility
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Show confirmation dialog
                  _showConfirmationDialog(context);
                },
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to Intro_page.dart
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => IntroPage()),
                );
              },
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }
}
