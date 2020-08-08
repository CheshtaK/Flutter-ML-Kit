import 'package:flutter/material.dart';
import 'package:flutter_ml_kit/model/content.dart';
import 'package:flutter_ml_kit/routes/routes.dart';

class HomePage extends StatelessWidget {
  HomePage({this.title});

  final String title;

  final List contents = [
    'Text Recognizer',
    'Barcode Detector',
    'Image Labeler',
    'Face Detector'
  ];

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(String content) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.text_fields, color: Colors.white),
          ),
          title: Text(
            content,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => DetailPage()));
          },
        );

    Card makeCard(String content) => Card(
          elevation: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(64, 75, 96, .9),
            ),
            child: makeListTile(content),
          ),
        );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text(title),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.list),
        //     onPressed: () {},
        //   )
        // ],
      ),
      body: Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: contents.length,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(contents[index]);
          },
        ),
      ),
    );
  }
}

List getContents() {
  return [
    Content(title: '', icon: Icons.text_fields, route: Routes.text_recognizer)
  ];
}
