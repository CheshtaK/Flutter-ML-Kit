import 'package:flutter/material.dart';
import 'package:flutter_ml_kit/image_scanner.dart';
import 'package:flutter_ml_kit/model/detector.dart';

class HomePage extends StatefulWidget {
  HomePage({this.title});

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List contents;

  @override
  void initState() {
    contents = getDetectors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Detector detector) => ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 1.0,
                  color: Colors.white24,
                ),
              ),
            ),
            child: Icon(
              detector.icon,
              color: Colors.white,
            ),
          ),
          title: Text(
            detector.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.white,
            size: 30.0,
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ImageScanner(type: detector.type)),
            );
          },
        );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: contents.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(64, 75, 96, .9),
                ),
                child: makeListTile(contents[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
