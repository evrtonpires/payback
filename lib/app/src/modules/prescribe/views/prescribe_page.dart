import 'package:flutter_modular/flutter_modular.dart';
import 'package:payback/app/src/modules/prescribe/stores/prescribe_store.dart';
import 'package:payback/app/src/modules/remedy/stores/remedy_store.dart';
import 'package:flutter/material.dart';

class PrescribePage extends StatefulWidget {
  final String title;
  const PrescribePage({Key? key, this.title = 'PrescribePage'})
      : super(key: key);
  @override
  PrescribePageState createState() => PrescribePageState();
}

class PrescribePageState extends ModularState<PrescribePage,PrescribeStore> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
    );
  }
}
