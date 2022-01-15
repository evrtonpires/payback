import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payback/app/modules/util/colors/colors.dart';
import 'package:payback/app/modules/util/constants/icons_constants.dart';
import 'package:payback/app/modules/util/widgets/size_font.dart';

class NoConnectionWidget extends StatelessWidget {
  const NoConnectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: SweetPetColors.linearGradient,
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
                  Modular.to.pushReplacementNamed('/');
                },
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  color: SweetPetColors.white,
                  size: 30,
                ),
              ),
            ),
            Center(
              child: SvgPicture.asset(
                IconConstant.noConnection,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Align(
              alignment: const Alignment(0, .25),
              child: Text(
                'Sem Conexão',
                style: GoogleFonts.sriracha(
                  color: SweetPetColors.white,
                  fontSize: getValueFont(context: context, valueMin: 14),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
