import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoWidget extends StatelessWidget {
  final String title;

  const LogoWidget({Key? key, this.title = "LogoWidgetWidget"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'Evol',
            style: GoogleFonts.sriracha(
                color: Colors.black54,
                fontSize: MediaQuery.of(context).size.height * .05),
            children: const [
              TextSpan(
                text: '2',
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, .7),
                ),
              ),
              TextSpan(
                text: 'SP',
                style: TextStyle(color: Colors.black54),
              )
            ]),
      ),
    ]);
  }
}
