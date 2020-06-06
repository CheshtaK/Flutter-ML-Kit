import 'package:flutter/material.dart';
import 'package:flutter_ml_kit/face_detector.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter and ML Kit',
      home: FaceDetector(),
    );
  }
}
