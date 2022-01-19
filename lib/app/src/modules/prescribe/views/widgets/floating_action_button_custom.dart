import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:payback/app/src/modules/util/colors/colors.dart';

class FloatingActionButtonCustom extends StatelessWidget {
  const FloatingActionButtonCustom(
      {Key? key, required this.addOnTap, required this.searchOnTap})
      : super(key: key);

  final Function()? addOnTap;
  final Function()? searchOnTap;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      activeBackgroundColor: ColorsConstants.redBlood,
      overlayColor: Colors.black,
      childrenButtonSize: const Size(55, 55),
      buttonSize: const Size(55, 55),
      spacing: 15,
      spaceBetweenChildren: 15,
      child: const Icon(
        Icons.menu,
        color: ColorsConstants.white,
      ),
      backgroundColor: ColorsConstants.primary,
      activeChild: const Icon(
        Icons.close,
        color: ColorsConstants.white,
      ),
      children: [
        SpeedDialChild(
          label: 'Filtrar Receita',
          backgroundColor: ColorsConstants.secundary,
          child: const Icon(
            Icons.search,
            color: ColorsConstants.white,
            size: 30,
          ),
          onTap: searchOnTap,
        ),
        SpeedDialChild(
          label: 'Adicionar Receita',
          backgroundColor: Colors.green,
          child: const Icon(
            Icons.add,
            color: ColorsConstants.white,
            size: 30,
          ),
          onTap: addOnTap,
        ),
      ],
    );
  }
}
