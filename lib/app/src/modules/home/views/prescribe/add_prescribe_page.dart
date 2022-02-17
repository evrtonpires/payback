import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:payback/app/src/modules/home/models/prescribe/prescribe_model.dart';
import 'package:payback/app/src/modules/home/stores/prescribe/prescribe_store.dart';
import 'package:payback/app/src/modules/util/colors/colors.dart';
import 'package:payback/app/src/modules/util/constants/icons_constants.dart';
import 'package:payback/app/src/modules/util/loading_page/loading_page_widget.dart';
import 'package:payback/app/src/modules/util/widgets/text_field_with_validation_widget.dart';

import '../../home_routing.dart';

class AddPrescribePage extends StatefulWidget {
  const AddPrescribePage({Key? key, required this.store, this.prescribe})
      : super(key: key);
  final PrescribeStore store;
  final PrescribeModel? prescribe;

  @override
  _AddPrescribePageState createState() => _AddPrescribePageState();
}

class _AddPrescribePageState extends State<AddPrescribePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animationTranslateIconButton;
  late Animation animationTranslateTextField;
  late Animation animationBorderRadius;
  late Animation animationContainerHeight;
  late Animation animationHeight;
  late Animation animationWidth;
  TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    if(widget.prescribe != null){
      codeController.text = widget.prescribe!.code;
      widget.store.code = widget.prescribe!.code;
      widget.store.listDrugSelected.addAll(widget.prescribe!.drugs);
      widget.store.checkDrugsSelected(widget.store.listDrugSelected);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    animationTranslateTextField =
        Tween<double>(begin: 0, end: MediaQuery.of(context).size.height * .31)
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 0.5),
      ),
    );

    animationTranslateIconButton =
        Tween<double>(begin: 0, end: -MediaQuery.of(context).size.height * .55)
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

    animationContainerHeight = Tween<double>(
      begin: MediaQuery.of(context).size.height,
      end: MediaQuery.of(context).size.height * .55,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, .5),
      ),
    );

    animationHeight = Tween<double>(
      begin: 55,
      end: MediaQuery.of(context).size.height * .3,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, .5),
      ),
    );

    animationWidth = Tween<double>(
      begin: 55,
      end: MediaQuery.of(context).size.width * .95,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, .5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .01),
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
            leading: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          elevation: 10,
                          title: const Text(
                            'Cancelar',
                            textAlign: TextAlign.center,
                          ),
                          content: const Text(
                            'Ao cancelar a operação, todos os campos já preenchidos serao apagados!\n\nDeseja continuar a operação?',
                            textAlign: TextAlign.center,
                          ),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                codeController.clear();
                                widget.store.prescribeController.appStore
                                    .modularPop();
                                widget.store.prescribeController.appStore
                                    .modularPop();
                                widget.store.cleanDrugsSelected();
                                widget.store.image = null;
                                widget.store.code = '';
                                widget.store.haveDrugSelected = false;
                              },
                              child: const Text('Cancelar'),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      ColorsConstants.redBlood)),
                            ),
                            ElevatedButton(
                              onPressed: widget.store.prescribeController
                                  .appStore.modularPop,
                              child: const Text('Continuar'),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.green)),
                            ),
                          ],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        );
                      });
                },
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: ColorsConstants.white,
                )),
            centerTitle: true,
            elevation: 0,
          ),
          body: SafeArea(
            child: Container(
              color: ColorsConstants.grey100,
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedBuilder(
                      animation: animationController,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.15),
                      ),
                      builder: (context, child) {
                        return SizedBox(
                          height: animationContainerHeight.value,
                          child: Observer(
                            builder: (_) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: TextFieldWithValidationWidget(
                                      controller: codeController,
                                      focusNode: widget.store.focusCode,
                                      placeholder: FlutterI18n.translate(
                                          context, 'telaPrescricao.codigo'),
                                      onChanged: (newCode) {
                                        widget.store.setCode(newCode);
                                        widget.store.codeValidate(context);
                                      },
                                      textInputAction: TextInputAction.done,
                                      messageError:
                                          widget.store.messageCodeError,
                                      onValidator: () =>
                                          widget.store.codeValidate(context),
                                      onEditingComplete: () =>
                                          widget.store.focusCode.unfocus(),
                                      isPassword: false,
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView(
                                      children: [
                                        if (widget.store.listDrugSelected
                                            .isNotEmpty) ...{
                                          ...widget.store.listDrugSelected
                                              .map((drug) {
                                            return Card(
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    color: ColorsConstants
                                                        .primary),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10,
                                                ),
                                              ),
                                              child: ListTile(
                                                title: Text(drug.name),
                                                subtitle:
                                                    Text(drug.activePrinciple),
                                                leading: Image.asset(
                                                    IconConstant.photography),
                                                trailing: IconButton(
                                                  icon: const Icon(
                                                    Icons.delete_forever,
                                                    color: ColorsConstants
                                                        .redBlood,
                                                  ),
                                                  onPressed: () => widget.store
                                                      .removeDrugsSelected(
                                                          drug),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        },
                                        InkWell(
                                          onTap: () {
                                            widget.store.prescribeController
                                                .appStore
                                                .pushNamed(
                                                    rout: HomeRouteNamed
                                                        .selectDrugs.fullPath!,
                                                    isRootNavigator: true,
                                                    isReplacement: false,
                                                    context: context);
                                          },
                                          child: Card(
                                            color: ColorsConstants.primary,
                                            child: ListTile(
                                              title: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Icon(
                                                      Icons.add,
                                                      color:
                                                          ColorsConstants.white,
                                                    ),
                                                    Text(
                                                      'Adicionar Medicamentos',
                                                      style: TextStyle(
                                                        color: ColorsConstants
                                                            .white,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                10,
                                              )),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: widget.prescribe == null,
                    child: Align(
                      alignment: const Alignment(.9, .9),
                      child: AnimatedBuilder(
                        animation: animationController,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.15),
                        ),
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, animationTranslateIconButton.value),
                            child: GestureDetector(
                              onTap: () {
                                if (widget.store.image == null &&
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
                                                File? haveImage = await widget
                                                    .store
                                                    .addImagePrescribeCamera();
                                                if (haveImage != null) {
                                                  animationController
                                                      .forward()
                                                      .whenComplete(() {
                                                    widget.store.image =
                                                        haveImage;
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
                                                File? haveImage = await widget
                                                    .store
                                                    .addImagePrescribeGallery();
                                                if (haveImage != null) {
                                                  animationController
                                                      .forward()
                                                      .whenComplete(() {
                                                    widget.store.image =
                                                        haveImage;
                                                  });
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                }
                                else {
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
                                                widget.store.image!,
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
                                  image: widget.store.image == null
                                      ? null
                                      : DecorationImage(
                                          image: FileImage(widget.store.image!),
                                          fit: BoxFit.fitWidth),
                                ),
                                height: animationHeight.value,
                                width: animationWidth.value,
                                child: widget.store.image == null
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
                                              widget.store.image = null;
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
                    ),
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: Observer(
            builder: (context) => Visibility(
              visible: ((widget.prescribe != null || widget.store.image != null) &&
                  widget.store.messageCodeError == null &&
                  widget.store.listDrugSelected.isNotEmpty),
              child: FloatingActionButton(
                onPressed: () async {
                  final bool sucess =
                      await widget.store.uploadPrescribe(context: context);
                  if (sucess) {
                    widget.store.sendMessage = null;

                    codeController.clear();
                    widget.store.cleanDrugsSelected();
                    widget.store.image = null;
                    widget.store.code = '';
                    widget.store.haveDrugSelected = false;

                    widget.store.prescribeController.appStore.modularPop();
                  }
                },
                elevation: 5,
                backgroundColor: ColorsConstants.secundary,
                tooltip: 'Salvar Receita',
                child: const Icon(
                  Icons.cloud_upload_rounded,
                  color: ColorsConstants.white,
                ),
              ),
            ),
          ),
        ),
        Observer(
          builder: (_) {
            return Visibility(
              visible: widget.store.isLoading,
              child: LoadingPageWidget(
                msg: widget.store.sendMessage,
                store: widget.store,
              ),
            );
          },
        )
      ],
    );
  }
}
