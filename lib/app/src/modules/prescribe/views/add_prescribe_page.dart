import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:payback/app/src/modules/prescribe/stores/prescribe_store.dart';
import 'package:payback/app/src/modules/util/colors/colors.dart';

class AddPrescribePage extends StatefulWidget {
  const AddPrescribePage({Key? key}) : super(key: key);

  @override
  _AddPrescribePageState createState() => _AddPrescribePageState();
}

class _AddPrescribePageState
    extends ModularState<AddPrescribePage, PrescribeStore>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animationTopCard;
  late Animation animationBorderRadius;
  late Animation animationHeight;
  late Animation animationWidth;
  late Animation<Alignment> animationAlignent;

  int isStart = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    animationTopCard =
        Tween<double>(begin: 0, end: -MediaQuery.of(context).size.height * .6)
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 0.5),
      ),
    );

    animationBorderRadius = Tween<double>(begin: 50, end: 25).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, .5),
      ),
    );

    animationHeight = Tween<double>(
      begin: 70,
      end: MediaQuery.of(context).size.height * .3,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, .5),
      ),
    );

    animationWidth = Tween<double>(
      begin: 70,
      end: MediaQuery.of(context).size.width * .95,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, .5),
      ),
    );

    animationAlignent = Tween<Alignment>(
      begin: const Alignment(.95, 1),
      end: const Alignment(.95, -1),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * .01),
          child: const Text(
            'Adicionar Receita',
            style: TextStyle(
                color: ColorsConstants.white,
                fontSize: 18,
                fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: ColorsConstants.primary,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Observer(
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Align(
                    alignment: animationAlignent.value,
                    child: AnimatedBuilder(
                      animation: animationController,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.15),
                      ),
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, animationTopCard.value),
                          child: GestureDetector(
                            onTap: () {
                              if (store.image == null &&
                                  animationController.status ==
                                      AnimationStatus.dismissed) {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (BuildContext bc) {
                                      return Wrap(
                                        alignment: WrapAlignment.center,
                                        children: <Widget>[
                                          GestureDetector(
                                            child: Container(
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: ColorsConstants.primary,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(30),
                                                  topRight: Radius.circular(30),
                                                ),
                                                border: Border.all(
                                                    color: ColorsConstants
                                                        .secundary),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(
                                                    Icons.camera_alt,
                                                    color:
                                                        ColorsConstants.white,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'Camera',
                                                    style: TextStyle(
                                                        color: ColorsConstants
                                                            .white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: () async {
                                              File? haveImage = await store
                                                  .addImagePrescribeCamera();
                                              if (haveImage != null) {
                                                animationController
                                                    .forward()
                                                    .whenComplete(() {
                                                  store.image = haveImage;
                                                });
                                              }
                                            },
                                          ),
                                          GestureDetector(
                                            child: Container(
                                              padding: const EdgeInsets.all(15),
                                              color: ColorsConstants.primary,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(
                                                    Icons.broken_image_rounded,
                                                    color:
                                                        ColorsConstants.white,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'Galeria',
                                                    style: TextStyle(
                                                        color: ColorsConstants
                                                            .white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: () async {
                                              File? haveImage = await store
                                                  .addImagePrescribeGallery();
                                              if (haveImage != null) {
                                                animationController
                                                    .forward()
                                                    .whenComplete(() {
                                                  store.image = haveImage;
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        shape: const RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Color(0xff000000),
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                        ),
                                        content: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.8,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1,
                                            child: Image.file(
                                              store.image!,
                                              fit: BoxFit.cover,
                                            )),
                                      );
                                    });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorsConstants.primary,
                                borderRadius: BorderRadius.circular(
                                    animationBorderRadius.value),
                                image: store.image == null
                                    ? null
                                    : DecorationImage(
                                        image: FileImage(store.image!),
                                        fit: BoxFit.fitWidth),
                              ),
                              height: animationHeight.value,
                              width: animationWidth.value,
                              child: store.image == null
                                  ? const Icon(
                                      Icons.camera_enhance,
                                      color: ColorsConstants.white,
                                    )
                                  : Align(
                                      alignment: Alignment.bottomRight,
                                      child: Card(
                                        color: ColorsConstants.redBlood,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: IconButton(
                                          onPressed: () {
                                            store.image = null;
                                            animationController.reverse();
                                          },
                                          icon: const Icon(
                                            Icons.delete_forever,
                                            color: ColorsConstants.white,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
