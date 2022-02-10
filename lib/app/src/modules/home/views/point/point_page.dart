import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payback/app/src/modules/home/stores/point/point_store.dart';

import 'widgets/card_drug.dart';

class PointPage extends StatefulWidget {
  final PointStore pointStore;

  const PointPage({Key? key, required this.pointStore}) : super(key: key);

  @override
  PointPageState createState() => PointPageState();
}

class PointPageState extends State<PointPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
          itemCount: widget.pointStore.getListDistribuidor().length,
          itemBuilder: (_, index) {
            final drug = widget.pointStore.getListDistribuidor()[index];
            return CardDrug(
              drug: drug,
              store: widget.pointStore,
            );
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.pointStore.totalPoints();
  }
}
