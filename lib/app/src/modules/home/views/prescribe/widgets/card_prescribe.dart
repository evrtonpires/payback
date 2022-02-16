import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payback/app/src/modules/home/models/prescribe/prescribe_model.dart';
import 'package:payback/app/src/modules/home/stores/prescribe/prescribe_store.dart';
import 'package:payback/app/src/modules/util/colors/colors.dart';
import 'package:payback/app/src/modules/util/constants/icons_constants.dart';

class CardPrecribe extends StatelessWidget {
  const CardPrecribe({Key? key, required this.prescribe, required this.store})
      : super(key: key);

  final PrescribeModel prescribe;
  final PrescribeStore store;

  String getDateFormat() {
    String? ano = prescribe.created_at.substring(0, 4);
    String? mes = prescribe.created_at.substring(5, 7);
    String? dia = prescribe.created_at.substring(8, 10);

    return '$dia/$mes/$ano';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 1.0, right: 1.0, top: 4),
      child: Card(
        elevation: 1,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              color: ColorsConstants.primary,
              width: .3,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                IconConstant.iconDoc,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .05,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle
                          .of(context)
                          .style,
                      children: <TextSpan>[
                        const TextSpan(
                            text: 'Código:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorsConstants.primary)),
                        TextSpan(text: ' ${prescribe.code}'),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle
                          .of(context)
                          .style,
                      children: <TextSpan>[
                        const TextSpan(
                            text: 'Data de Cadastro:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorsConstants.primary)),
                        TextSpan(text: ' ${getDateFormat()}'),
                      ],
                    ),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              // IconButton(
              //   icon: const Icon(Icons.edit, color: ColorsConstants.pretoSGS),
              //   onPressed: () {},
              // ),
              IconButton(
                icon: const Icon(
                  Icons.delete_forever,
                  color: ColorsConstants.redBlood,
                ),
                onPressed: () {

                    store.deletePrescribeByCode(
                        context: context,
                        companyId: store
                            .prescribeController.appStore.userModel!.companyId,
                        prescriptionId: prescribe.id);

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
