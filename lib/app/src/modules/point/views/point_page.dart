import 'package:flutter_modular/flutter_modular.dart';
import 'package:payback/app/src/modules/point/stores/point_store.dart';
import 'package:payback/app/src/modules/remedy/stores/remedy_store.dart';
import 'package:flutter/material.dart';

class PointPage extends StatefulWidget {
  final String title;

  const PointPage({Key? key, this.title = 'PointPage'}) : super(key: key);

  @override
  PointPageState createState() => PointPageState();
}

class PointPageState extends ModularState<PointPage, PointStore> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
    );
  }
}
