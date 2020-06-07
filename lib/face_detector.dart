import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_ml_kit/face_painter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class FaceDetector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FaceDetectorState();
}

class _FaceDetectorState extends State<FaceDetector> {
  File _imageFile;
  List<Face> _faces;
  ui.Image _image;

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
        _loadImage(imageFile);
      });
    }
  }

  _loadImage(File file) async {
    final data = await file.readAsBytes();
    await decodeImageFromList(data).then((value) => setState(() {
          _image = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face Detector'),
      ),
      body: (_imageFile != null)
          ? Center(
              child: FittedBox(
                child: SizedBox(
                  width: _image.width.toDouble(),
                  height: _image.height.toDouble(),
                  child: CustomPaint(
                    painter: FacePainter(_image, _faces),
                  ),
                ),
              ),
            )
          : Center(child: Text('No image selected')),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImageAndDetectFaces,
        tooltip: 'Pick an image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
