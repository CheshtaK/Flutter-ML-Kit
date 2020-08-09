import 'package:flutter/material.dart';
import 'package:flutter_ml_kit/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter and ML Kit',
      theme: ThemeData(
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0), fontFamily: 'Raleway'),
      debugShowCheckedModeBanner: false,
      home: HomePage(title: 'ML Kit'),
    );
  }
}
