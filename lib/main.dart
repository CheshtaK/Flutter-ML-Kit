import 'package:flutter/material.dart';
import 'package:flutter_ml_kit/home.dart';
import 'package:flutter_ml_kit/routes/router.dart';

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
      onGenerateRoute: Router.generateRoute,
      home: HomePage(title: 'ML Kit'),
    );
  }
}
