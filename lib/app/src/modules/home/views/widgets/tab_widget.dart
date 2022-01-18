import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payback/app/src/modules/util/colors/colors.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({Key? key, required this.iconPath, required this.titlePath})
      : super(key: key);

  final String iconPath;
  final String titlePath;

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            color:
                titlePath != 'telaHome.remedios' ? ColorsConstants.white : null,
            height: 35,
          ),
          Text(
            FlutterI18n.translate(context, titlePath),
          ),
        ],
      ),
    );
  }
}
