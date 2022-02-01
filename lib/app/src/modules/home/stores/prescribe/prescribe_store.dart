import 'dart:io';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:payback/app/src/core/models/api_response.model.dart';
import 'package:payback/app/src/modules/home/controllers/prescribe/prescribe_controller.dart';
import 'package:payback/app/src/modules/home/models/prescribe/drug_model.dart';
import 'package:payback/app/src/modules/util/alert_awesome/alert_awesome_widget.dart';

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

//----------------------------------------------------------------------------
  @observable
  bool isLoading = false;

//----------------------------------------------------------------------------
  @observable
  String? sendMessage;
//----------------------------------------------------------------------------
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
          name: 'BEXAI',
          activePrinciple: 'Diclofenaco',
          logoUrl:
          'https://www.jnjbrasil.com.br/sites/default/files/logo-johson_3.jpg',
          dots: 60,
          distributorId: 1),
      DrugModel(
          id: 1,
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
    drugs
        .firstWhere((element) => element.id == drug.id)
        .isSelect =
    !drug.isSelect;
    drugs = drugs;
    haveDrugSelected = drugs
        .where((element) => element.isSelect)
        .isNotEmpty;
  }

//----------------------------------------------------------------------------
  void getAllDrugsSelected() {
    listDrugSelected.clear();
    for (DrugModel drug in drugs) {
      if (drug.isSelect) {
        listDrugSelected.add(drug);
      }
    }

    prescribeController.appStore.modularPop();
  }

//----------------------------------------------------------------------------
  void removeDrugsSelected(DrugModel drug) {
    listDrugSelected.removeWhere((element) => element.id == drug.id);
    listDrugSelected = listDrugSelected;
    drugs
        .firstWhere((element) => element.id == drug.id)
        .isSelect = false;
    drugs = drugs;
    haveDrugSelected = drugs
        .where((element) => element.isSelect)
        .isNotEmpty;
  }

//----------------------------------------------------------------------------
  void cleanDrugsSelected() {
    listDrugSelected.clear();
    for (DrugModel drug in drugs) {
      if (drug.isSelect) {
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
      // final bytes = fileImage.readAsBytesSync().lengthInBytes;
      // print(getFileSizeString(bytes: bytes,decimals: 2));
    }
    prescribeController.appStore.modularPop();
    return fileImage;
  }

//----------------------------------------------------------------------------
  static String getFileSizeString({required int bytes, int decimals = 0}) {
    const suffixes = ["b", "kb", "mb", "gb", "tb"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }
//----------------------------------------------------------------------------
  Future<File?> addImagePrescribeGallery() async {
    File? fileImage;
    XFile? img =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
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
  Future<bool> uploadPrescribe({required context}) async {
    isLoading = true;
    Map<String, dynamic> sucessPrescribe = await addPrescribe(context);
    if (sucessPrescribe['sucess']) {
      sendMessage = 'Enviando Imagem';
      final bool sucessImgPrescribe = await uploadFormData(
          context, sucessPrescribe['apiResponseModel'].data['id']);
      if (sucessImgPrescribe) {
        sendMessage = 'Imagem eviada';
        isLoading = false;
        sendMessage = null;
        return true;
      } else {
        isLoading = false;
        return false;
      }
    } else {
      isLoading = false;
      return false;
    }
  }

//----------------------------------------------------------------------------
  Future<Map<String, dynamic>> addPrescribe(context) async {
    sendMessage = 'Enviando informações';
    ApiResponseModel? apiResponseModel =
    await prescribeController.addPrescribe(context: context, data: {
      "code": code,
      "imageName": image!
          .path
          .split('/')
          .last,
      "drugsId": listDrugSelected.map((e) => e.id).toList(),
      "companyId": prescribeController.appStore.userModel!.companyId,
    });

    if (apiResponseModel?.statusCode == 201) {
      sendMessage = 'Informações enviadas';
      return {'sucess': true, 'apiResponseModel': apiResponseModel};
    } else {
      sendMessage = null;
      isLoading = false;
      awesomeDialogWidget(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.NO_HEADER,
          text: apiResponseModel?.data['messages'][0]['message'],
          title: apiResponseModel?.data['title'],
          borderColor: Colors.red,
          buttonColor: Colors.red.shade800,
          btnOkOnPress: () {});

      return {'sucess': false, 'apiResponseModel': apiResponseModel};
    }
  }

//----------------------------------------------------------------------------
  Future<bool> uploadFormData(context, int precripId) async {
    ApiResponseModel? apiResponseModel = await prescribeController
        .uploadFormData(context: context,
        file: image!,
        precripId: precripId,
        onSendProgress: (int send, int total) {
          String percent = (send / total * 100).toStringAsFixed(2);
          print(percent);
            sendMessage = '$percent%';
        });
    if (apiResponseModel?.statusCode == 200) {
      isLoading = false;
      return true;
    } else {
      sendMessage = null;
      isLoading = false;
      awesomeDialogWidget(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.NO_HEADER,
          text: apiResponseModel?.data['messages'][0]['message'],
          title: apiResponseModel?.data['title'],
          borderColor: Colors.red,
          buttonColor: Colors.red.shade800,
          btnOkOnPress: () {});

      return false;
    }
  }
//----------------------------------------------------------------------------
}
