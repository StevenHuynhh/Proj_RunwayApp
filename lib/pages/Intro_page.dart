import 'package:flutter/material.dart';
import 'Login_page.dart'; // Import the LoginPage

class IntroPage extends StatefulWidget {
  IntroPage({super.key});

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Color(0xFF532B57),
                  Color(0xFF1F0E29),
                ],
                center: Alignment.center,
                radius: 0.9,
              ),
            ),
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: [
              Spacer(), // Pushes the content to the center
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Image.asset('lib/images/RunwayLogo.png'),
                    Text(
                      'FIND WHAT SPEAKS TO YOU',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(), // Pushes the button to the bottom
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _isHovering = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _isHovering = false;
                    });
                  },
                  child: TextButton(
                    onPressed: () {
                      // Navigate to LoginPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor:
                          _isHovering ? Colors.white : Colors.transparent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: Text(
                      'Login | Signup',
                      style: TextStyle(
                        color: _isHovering ? Colors.black : Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
