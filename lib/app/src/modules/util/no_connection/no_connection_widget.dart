import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payback/app/src/app_routing.dart';
import 'package:payback/app/src/modules/util/colors/colors.dart';
import 'package:payback/app/src/modules/util/constants/icons_constants.dart';
import 'package:payback/app/src/modules/util/widgets/size_font.dart';

class NoConnectionWidget extends StatelessWidget {
  const NoConnectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: ColorsConstants.linearGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(-0.95, -0.9),
              child: IconButton(
                onPressed: () {
                  Modular.to
                      .pushReplacementNamed(AppRouteNamed.login.fullPath!);
                },
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  color: ColorsConstants.white,
                  size: 30,
                ),
              ),
            ),
            Align(
              alignment:
                  Alignment(0, MediaQuery.of(context).size.height * -.0005),
              child: SvgPicture.asset(
                IconConstant.noConnection,
                width: MediaQuery.of(context).size.width * .85,
              ),
            ),
            Align(
              alignment: const Alignment(0, .25),
              child: Text(
                FlutterI18n.translate(context, 'global.semConexao'),
                textAlign: TextAlign.center,
                style: GoogleFonts.sriracha(
                  color: ColorsConstants.white,
                  fontSize: getValueFont(context: context, valueMin: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
