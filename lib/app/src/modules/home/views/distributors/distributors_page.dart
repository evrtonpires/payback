import 'package:flutter/material.dart';
import 'package:payback/app/src/modules/home/stores/distributors/distributors_store.dart';

import 'widgets/card_drug.dart';

class DistributorsPage extends StatefulWidget {
  final DistributorsStore distributorsStore;

  const DistributorsPage({Key? key, required this.distributorsStore}) : super(key: key);

  @override
  DistributorsPageState createState() => DistributorsPageState();
}

class DistributorsPageState extends State<DistributorsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
          itemCount: widget.distributorsStore.getListDistribuidor().length,
          itemBuilder: (_, index) {
            final drug = widget.distributorsStore.getListDistribuidor()[index];
            return CardDrug(
              drug: drug,
              store: widget.distributorsStore,
            );
          }),
    );
  }
}
