import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ml_kit/images_and_faces.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class FaceDetector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FaceDetectorState();
}

class _FaceDetectorState extends State<FaceDetector> {
  File _imageFile;
  List<Face> _faces;

  void _getImageAndDetectFaces() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    final File imageFile = File(pickedFile.path);

    final image = FirebaseVisionImage.fromFile(imageFile);
    final faceDetector = FirebaseVision.instance.faceDetector(
      FaceDetectorOptions(
          mode: FaceDetectorMode.accurate, enableLandmarks: true),
    );

    final faces = await faceDetector.processImage(image);
    if (mounted) {
      setState(() {
        _imageFile = imageFile;
        _faces = faces;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face Detector'),
      ),
      body: (_imageFile != null)
          ? ImagesAndFaces(
              imageFile: _imageFile,
              faces: _faces,
            )
          : Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImageAndDetectFaces,
        tooltip: 'Pick an image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
