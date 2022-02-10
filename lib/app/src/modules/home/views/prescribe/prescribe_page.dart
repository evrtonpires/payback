import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
    return Observer(
      builder: (context) {
        return Stack(children: [
          Visibility(
            visible: widget.prescribeStore.prescribes.isNotEmpty,
            replacement:  Center(
              child: RichText(textAlign: TextAlign.center,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children:  const <TextSpan>[
                    TextSpan(
                      text: 'Ops\n\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: 'Você ainda não possui nenhuma receita cadastrada.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            child: ListView.builder(
                itemCount: widget.prescribeStore.prescribes.length,
                itemBuilder: (_, index) {
                  final prescribe = widget.prescribeStore.prescribes[index];
                  return CardPrecribe(
                    prescribe: prescribe,
                    store: widget.prescribeStore,
                  );
                }),
          ),
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
                    rout: HomeRouteNamed.addPrescribe.fullPath!,
                    context: context),
              ))
        ]);
      },
    );
  }
}
