import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:payback/app/modules/shared/auth/auth_controller.dart';
import 'package:payback/app/modules/util/colors/colors.dart';

import 'home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.authController}) : super(key: key);

  final AuthController? authController;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final HomeStore store = Modular.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: Platform.isAndroid,
      child: Scaffold(
        backgroundColor: SweetPetColors.grey100,
        body: Observer(
          builder: (_) {
            return Container();
          },
        ),
      ),
    );
  }
}
