import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../modules/prescribe/views/widgets/floating_action_button_custom.dart';
import '../../../modules/prescribe/stores/prescribe_store.dart';
import 'widgets/card_prescribe.dart';
import 'widgets/search_dialog.dart';

class PrescribePage extends StatefulWidget {
  final String title;

  const PrescribePage({Key? key, this.title = 'PrescribePage'})
      : super(key: key);

  @override
  PrescribePageState createState() => PrescribePageState();
}

class PrescribePageState extends ModularState<PrescribePage, PrescribeStore> {
  List<int> items = List<int>.generate(15, (int index) => index);

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
            addOnTap: () {},
          ))
    ]);
  }
}
