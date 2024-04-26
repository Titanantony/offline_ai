import 'package:flutter/material.dart';
import 'package:offline_ai/screens/homescreen/home_screen.dart';
// import 'package:offline_ai/screens/home_screen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Example',
      home: HomeScreen(),
    );
  }
}
