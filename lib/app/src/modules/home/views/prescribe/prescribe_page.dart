import 'package:flutter/material.dart';
import 'package:payback/app/src/modules/home/stores/prescribe/prescribe_store.dart';

import '../../home_routing.dart';
import 'widgets/card_prescribe.dart';
import 'widgets/floating_action_button_custom.dart';
import 'widgets/search_dialog.dart';

class PrescribePage extends StatefulWidget {
  const PrescribePage({
    Key? key,
    required this.prescribeStore,
  }) : super(key: key);

  final PrescribeStore prescribeStore;

  @override
  PrescribePageState createState() => PrescribePageState();
}

class PrescribePageState extends State<PrescribePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView.builder(
          itemCount: 15,
          itemBuilder: (_, index) {
            return const CardPrecribe();
          }),
      Align(
          alignment: const Alignment(.9, .9),
          child: FloatingActionButtonCustom(
            searchOnTap: () async {
              final String? valorPesquisado = await showDialog(
                  context: context,
                  builder: (context) {
                    return const SearchDialog();
                  });
              if (valorPesquisado != null) {}
            },
            addOnTap: () => widget.prescribeStore.addPrescribePage(
                rout: HomeRouteNamed.addPrescribe.fullPath!, context: context),
          ))
    ]);
  }
}
