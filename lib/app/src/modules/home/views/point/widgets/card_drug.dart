import 'package:flutter/material.dart';
import 'package:payback/app/src/modules/home/models/prescribe/drug_model.dart';
import 'package:payback/app/src/modules/home/stores/point/point_store.dart';
import 'package:payback/app/src/modules/util/colors/colors.dart';
import 'package:payback/app/src/modules/util/constants/icons_constants.dart';

class CardDrug extends StatelessWidget {
  const CardDrug({Key? key, required this.drug,required this.store}) : super(key: key);

  final DrugModel drug;
  final PointStore store;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 1.0, right: 1.0, top: 4),
      child: Card(
        elevation: 1,
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              (drug.logoUrl == null || drug.logoUrl!.isEmpty)
                  ? Image.asset(
                      IconConstant.photography,
                      color: ColorsConstants.primary,
                      width: 60,
                      height: 60,
                    )
                  : Image.network(drug.logoUrl!),
              const SizedBox(
                width: 10,
              ),
              Text(drug.name),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,top: 15,bottom: 10),
              child: Align(
                alignment: const Alignment(-.9, 0),
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children:  <TextSpan>[
                      TextSpan(
                        text: '${store.getUndDrugs(drug.id)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorsConstants.redBlood,
                          fontSize: 20,
                        ),
                      ),
                       TextSpan(
                        text: ' Und. ${drug.activePrinciple}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
