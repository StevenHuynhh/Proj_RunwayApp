import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hello_world/dbHelper/mongodb.dart';
import 'package:hello_world/models/shop.dart';
import 'package:provider/provider.dart';
import 'pages/Intro_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MongoDatabase.connect();
  runApp(
    ChangeNotifierProvider(
      create: (context) => Shop(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
    );
  }
}
