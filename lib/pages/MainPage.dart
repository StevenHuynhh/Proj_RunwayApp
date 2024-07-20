import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello_world/models/shop.dart';
import 'package:hello_world/tabs/WishlistTab.dart';
import 'package:hello_world/tabs/explore.dart';
import 'package:hello_world/tabs/for_you.dart';
import 'package:hello_world/tabs/WishlistTab.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
              width: double.infinity,
              height: double.infinity,
            ),
            Column(
              children: [
                SafeArea(
                  minimum: EdgeInsets.symmetric(
                      vertical: 1), // Adjust vertical padding as needed
                  child: Image.asset(
                    'lib/images/RunwayLogo.png',
                    height: 100,
                    width: 250,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ExploreTab(),
                      WishlistTab(),
                      SignOutTab(), // Add the Wishlist tab content
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(
                    0xFF1F0E29), // Optional: set a background color for the tab bar area
                child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Color.fromARGB(255, 102, 102, 102),
                  tabs: const [
                    Tab(
                      text: 'Explore',
                    ),
                    Tab(
                      text: 'Wishlist',
                    ),
                    Tab(
                      text: 'Sign Out',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
