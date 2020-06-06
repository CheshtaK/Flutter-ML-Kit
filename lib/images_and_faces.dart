import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class ImagesAndFaces extends StatelessWidget {
  ImagesAndFaces({this.imageFile, this.faces});
  final File imageFile;
  final List<Face> faces;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Flexible(
        flex: 2,
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Flexible(
          flex: 1,
          child: ListView(
            children: faces.map<Widget>((f) => FaceCoordinates(f)).toList(),
          ))
    ]);
  }
}

class FaceCoordinates extends StatelessWidget {
  FaceCoordinates(this.face);
  final Face face;

  @override
  Widget build(BuildContext context) {
    final pos = face.boundingBox;

    return ListTile(
      title: Text('(${pos.top}, ${pos.left}), (${pos.bottom}, ${pos.right})'),
    );
  }
}
