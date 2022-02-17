import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payback/app/src/modules/home/stores/prescribe/prescribe_store.dart';
import 'package:payback/app/src/modules/util/colors/colors.dart';
import 'package:payback/app/src/modules/util/constants/icons_constants.dart';
import 'package:skeletons/skeletons.dart';

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
        return Skeleton(
          isLoading: widget.prescribeStore.isGetData,
          skeleton: ListView.builder(
              itemCount: 15,
              itemBuilder: (_, index) {
                return Container(
                  height: 50,
                );
              }),
          child: Stack(children: [
            Visibility(
              visible: widget.prescribeStore.prescribes.isNotEmpty,
              replacement: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(IconConstant.noContentPrescriptionPng),
                  ),
                ),
                child: Align(
                  alignment: const Alignment(0, -.6),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Ops\n\n',
                          style: GoogleFonts.aclonica(
                              fontWeight: FontWeight.w500,
                              fontSize: 30,
                              color: ColorsConstants.primary),
                        ),
                        TextSpan(
                          text:
                              'Você ainda não possui nenhuma\nreceita cadastrada.',
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: ColorsConstants.primary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              child: Visibility(
                visible: !(widget.prescribeStore.prescribesFilter != null &&
                    widget.prescribeStore.prescribesFilter!.isEmpty),
                replacement: const Center(
                  child: Text('Nenhuma receita foi encontrada!'),
                ),
                child: ListView.builder(
                    itemCount: widget.prescribeStore.prescribesFilter == null
                        ? widget.prescribeStore.prescribes.length
                        : widget.prescribeStore.prescribesFilter!.length,
                    itemBuilder: (_, index) {
                      final prescribe =
                          widget.prescribeStore.prescribesFilter == null
                              ? widget.prescribeStore.prescribes[index]
                              : widget.prescribeStore.prescribesFilter![index];
                      return CardPrecribe(
                        prescribe: prescribe,
                        store: widget.prescribeStore,
                      );
                    }),
              ),
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
                    if (valorPesquisado != null) {
                      widget.prescribeStore
                          .filterPrescribes(text: valorPesquisado);
                    }
                  },
                  addOnTap: () => widget.prescribeStore.addPrescribePage(
                      rout: HomeRouteNamed.addPrescribe.fullPath!,
                      context: context),
                  cleanFilter: (){
                    widget.prescribeStore.prescribesFilter = null;
                  },
                  isNull: widget.prescribeStore.prescribesFilter == null,

                ))
          ]),
        );
      },
    );
  }
}
