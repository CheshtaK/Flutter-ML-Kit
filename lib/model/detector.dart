import 'package:flutter/material.dart';

class Detector {
  String title;
  IconData icon;
  int type;

  Detector({this.title, this.icon, this.type});
}

List getDetectors() {
  return [
    Detector(
      title: 'Text Recognizer',
      icon: Icons.text_fields,
      type: 0,
    ),
    Detector(
      title: 'Barcode Detector',
      icon: Icons.crop_free,
      type: 1,
    ),
    Detector(
      title: 'Image Labeler',
      icon: Icons.image,
      type: 2,
    ),
    Detector(
      title: 'Face Detector',
      icon: Icons.face,
      type: 3,
    ),
  ];
}
