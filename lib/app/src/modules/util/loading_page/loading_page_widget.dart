import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payback/app/src/modules/util/colors/colors.dart';
import 'package:payback/app/src/modules/util/constants/icons_constants.dart';

class LoadingPageWidget extends StatefulWidget {
  const LoadingPageWidget({Key? key, required this.store}) : super(key: key);

  final dynamic store;

  @override
  _LoadingPageWidgetState createState() => _LoadingPageWidgetState();
}

class _LoadingPageWidgetState extends State<LoadingPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: IgnorePointer(
          ignoring: widget.store.isLoading,
          child: Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
            color: widget.store.isLoading
                ? Colors.black.withOpacity(.90)
                : Colors.transparent,
            child: Center(
              child: widget.store.isLoading
                  ? Column(
                      children: <Widget>[
                        SvgPicture.asset(
                          IconConstant.logoColor,
                          color: SweetPetColors.secundary,
                          width: 60.0,
                          height: 60.0,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Entrando. Aguarde ...',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: SweetPetColors.white),
                        )
                      ],
                    )
                  : const SizedBox(),
            ),
          ),
        ));
  }
}
