import 'package:flutter_modular/flutter_modular.dart';
import 'package:payback/app/src/modules/home/stores/remedy/remedy_store.dart';
import 'package:flutter/material.dart';

class RemedyPage extends StatefulWidget {
  final String title;

  const RemedyPage({Key? key, this.title = 'RemedyPage'}) : super(key: key);

  @override
  RemedyPageState createState() => RemedyPageState();
}

class RemedyPageState extends State<RemedyPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
