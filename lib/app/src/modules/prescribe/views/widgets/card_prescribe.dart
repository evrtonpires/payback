import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payback/app/src/modules/util/colors/colors.dart';
import 'package:payback/app/src/modules/util/constants/icons_constants.dart';

class CardPrecribe extends StatelessWidget {
  const CardPrecribe({Key? key}) : super(key: key);

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
                height: MediaQuery.of(context).size.height * .05,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: const <TextSpan>[
                        TextSpan(
                            text: 'Código:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorsConstants.primary)),
                        TextSpan(text: ' 13123'),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: const <TextSpan>[
                        TextSpan(
                            text: 'Data de Cadastro:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorsConstants.primary)),
                        TextSpan(text: ' 12/01/2022'),
                      ],
                    ),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              IconButton(
                icon: const Icon(Icons.edit, color: ColorsConstants.pretoSGS),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_forever,
                  color: ColorsConstants.redBlood,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
