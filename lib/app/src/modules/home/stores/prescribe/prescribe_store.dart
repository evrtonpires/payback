import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:payback/app/src/modules/home/controllers/prescribe/prescribe_controller.dart';
import 'package:payback/app/src/modules/home/models/prescribe/drug_model.dart';

part 'prescribe_store.g.dart';

class PrescribeStore = _PrescribeStoreBase with _$PrescribeStore;

abstract class _PrescribeStoreBase with Store {
  _PrescribeStoreBase({required this.prescribeController}) {
    _picker = ImagePicker();
    focusCode = FocusNode();
    getAllDrugs();
  }

  final PrescribeController prescribeController;
  late final ImagePicker _picker;
  late final FocusNode focusCode;

  @observable
  File? image;

//----------------------------------------------------------------------------
  @observable
  String? code;

//----------------------------------------------------------------------------
  @observable
  String? messageCodeError;

//----------------------------------------------------------------------------
  @action
  void setCode(String newCode) => code = newCode.trimRight();

//----------------------------------------------------------------------------
  @observable
  List<DrugModel> listDrugSelected = [];

//----------------------------------------------------------------------------
  @observable
  List<DrugModel> drugs = [];

//----------------------------------------------------------------------------
  @observable
  bool haveDrugSelected = false;
//----------------------------------------------------------------------------
  Future<void> getAllDrugs() async {
    drugs.addAll([
      DrugModel(
          id: 1,
          name: 'Bexai',
          activePrinciple: 'Diclofenaco',
          logoUrl:
              'https://www.jnjbrasil.com.br/sites/default/files/logo-johson_3.jpg',
          dots: 10,
          distributorId: 1),
      DrugModel(
          id: 2,
          name: 'Ems',
          activePrinciple: 'Diclofenaco',
          logoUrl:
              'https://www.jnjbrasil.com.br/sites/default/files/logo-johson_3.jpg',
          dots: 20,
          distributorId: 1),
      DrugModel(
          id: 3,
          name: 'Jhonson',
          activePrinciple: 'Dipirona',
          logoUrl:
              'https://www.jnjbrasil.com.br/sites/default/files/logo-johson_3.jpg',
          dots: 25,
          distributorId: 1),
      DrugModel(
          id: 4,
          name: 'Lael',
          activePrinciple: 'Laxante',
          logoUrl:
              'https://www.jnjbrasil.com.br/sites/default/files/logo-johson_3.jpg',
          dots: 15,
          distributorId: 2),
      DrugModel(
          id: 5,
          name: 'Baroni',
          activePrinciple: 'Saiu da Unip',
          logoUrl:
              'https://www.jnjbrasil.com.br/sites/default/files/logo-johson_3.jpg',
          dots: 50,
          distributorId: 3),
    ]);
  }

//----------------------------------------------------------------------------
  void selectDrug(DrugModel drug) {
    drugs.firstWhere((element) => element.id == drug.id).isSelect =
        !drug.isSelect;
    drugs = drugs;
    haveDrugSelected = drugs.where((element) => element.isSelect).isNotEmpty;
  }

//----------------------------------------------------------------------------
  void getAllDrugsSelected() {
    listDrugSelected.clear();
    for(DrugModel drug in drugs){
      if(drug.isSelect) {
        listDrugSelected.add(drug);
      }
    }

    prescribeController.appStore.modularPop();
  }

//----------------------------------------------------------------------------
  void removeDrugsSelected(DrugModel drug) {
    listDrugSelected.removeWhere((element) => element.id == drug.id);
    listDrugSelected = listDrugSelected;
    drugs.firstWhere((element) => element.id == drug.id).isSelect = false;
    drugs = drugs;
    haveDrugSelected = drugs.where((element) => element.isSelect).isNotEmpty;
  }

//----------------------------------------------------------------------------
  void cleanDrugsSelected(){
    listDrugSelected.clear();
    for(DrugModel drug in drugs){
      if(drug.isSelect){
        drug.isSelect = false;
      }
    }
  }
//----------------------------------------------------------------------------
  bool codeValidate(BuildContext context, {bool requestFocus = false}) {
    messageCodeError = null;
    if (code == null || code!.isEmpty) {
      messageCodeError = 'Campo obrigatório';
      if (requestFocus) {
        focusCode.requestFocus();
      }
      return false;
    }
    return true;
  }

//----------------------------------------------------------------------------
  Future<File?> addImagePrescribeCamera() async {
    File? fileImage;
    XFile? img =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (img != null) {
      fileImage = File(img.path);
    }
    prescribeController.appStore.modularPop();
    return fileImage;
  }

//----------------------------------------------------------------------------
  Future<File?> addImagePrescribeGallery() async {
    File? fileImage;
    XFile? img =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (img != null) {
      fileImage = File(img.path);
    }
    prescribeController.appStore.modularPop();
    return fileImage;
  }

//----------------------------------------------------------------------------
  addPrescribePage({required String rout, required BuildContext context}) {
    prescribeController.appStore.pushNamed(
        rout: rout,
        context: context,
        isReplacement: false,
        isRootNavigator: true);
  }
//----------------------------------------------------------------------------
}
