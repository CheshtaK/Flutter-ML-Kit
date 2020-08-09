import 'dart:async';
import 'dart:io';

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
  Size _imageSize;

  dynamic _scanResults;

  final _faceDetector = FirebaseVision.instance.faceDetector(
    FaceDetectorOptions(mode: FaceDetectorMode.accurate, enableLandmarks: true),
  );

  Future<void> _getImage() async {
    setState(() {
      _imageFile = null;
      _imageSize = null;
    });

    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    final File imageFile = File(pickedFile.path);

    if (imageFile != null) {
      _getImageSize(imageFile);
      _scanImage(imageFile);
    }

    setState(() {
      _imageFile = imageFile;
    });
  }

  Future<void> _getImageSize(File imageFile) async {
    final Completer<Size> completer = Completer<Size>();

    final Image image = Image.file(imageFile);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );

    final Size imageSize = await completer.future;
    setState(() {
      _imageSize = imageSize;
    });
  }

  Future<void> _scanImage(File imageFile) async {
    setState(() {
      _scanResults = null;
    });

    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(imageFile);

    dynamic results;
    results = await _faceDetector.processImage(visionImage);

    setState(() {
      _scanResults = results;
    });
  }

  CustomPaint _buildResults(Size imageSize, dynamic results) {
    return CustomPaint(
      painter: FacePainter(_imageSize, results),
    );
  }

  Widget _buildImage() {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.file(_imageFile).image,
          fit: BoxFit.fill,
        ),
      ),
      child: _imageSize == null || _scanResults == null
          ? const Center(
              child: Text(
                'Scanning...',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30.0,
                ),
              ),
            )
          : _buildResults(_imageSize, _scanResults),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face Detector'),
      ),
      body: (_imageFile != null)
          ? _buildImage()
          : Center(child: Text('No image selected')),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        tooltip: 'Pick an image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  @override
  void dispose() {
    _faceDetector.close();
    super.dispose();
  }
}
