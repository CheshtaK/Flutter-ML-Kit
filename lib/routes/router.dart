import 'package:flutter/material.dart';
import 'package:flutter_ml_kit/home.dart';
import 'package:flutter_ml_kit/main.dart';
import 'package:flutter_ml_kit/routes/routes.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings routesettings) {
    switch (routesettings.name) {
      case Routes.main:
        return MaterialPageRoute(builder: (_) => MyApp());
      case Routes.text_recognizer:
        return MaterialPageRoute(builder: (_) => HomePage());
      case Routes.barcode_detector:
        return MaterialPageRoute(builder: (_) => HomePage());
      case Routes.image_labeler:
        return MaterialPageRoute(builder: (_) => HomePage());
      case Routes.face_detector:
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        return MaterialPageRoute(builder: (_) => HomePage());
    }
  }
}
