import 'package:flutter/material.dart';

class PointPage extends StatefulWidget {
  final String title;

  const PointPage({Key? key, this.title = 'PointPage'}) : super(key: key);

  @override
  PointPageState createState() => PointPageState();
}

class PointPageState extends State<PointPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
    );
  }
}
