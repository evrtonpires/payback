import 'dart:io';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:payback/app/src/core/models/api_response.model.dart';
import 'package:payback/app/src/modules/home/controllers/prescribe/prescribe_controller.dart';
import 'package:payback/app/src/modules/home/models/prescribe/drug_model.dart';
import 'package:payback/app/src/modules/home/models/prescribe/prescribe_model.dart';
import 'package:payback/app/src/modules/util/alert_awesome/alert_awesome_widget.dart';

part 'prescribe_store.g.dart';

class PrescribeStore = _PrescribeStoreBase with _$PrescribeStore;

abstract class _PrescribeStoreBase with Store {
  _PrescribeStoreBase({required this.prescribeController}) {
    _picker = ImagePicker();
    focusCode = FocusNode();
  }

  final PrescribeController prescribeController;
  late final ImagePicker _picker;
  late final FocusNode focusCode;

//----------------------------------------------------------------------------
  @observable
  bool isGetData = true;


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
  void setCode(String newCode) => code = newCode.trim();

//----------------------------------------------------------------------------
  @observable
  List<DrugModel> listDrugSelected = [];

//----------------------------------------------------------------------------
  @observable
  List<DrugModel> drugs = [];

  //----------------------------------------------------------------------------
  @observable
  List<PrescribeModel> prescribes = [];

//----------------------------------------------------------------------------
  @observable
  bool haveDrugSelected = false;

//----------------------------------------------------------------------------
  Future<void> getAllPrescribes({required BuildContext context}) async {
    isGetData = true;
    ApiResponseModel? apiResponseModel =
        await prescribeController.getAllPrescribes(context: context);

    if (apiResponseModel?.statusCode == 200) {
      prescribes = apiResponseModel?.data.map<PrescribeModel>((e) {
        return PrescribeModel.fromJson(e);
      }).toList();
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
    }
    isGetData = false;
  }

//----------------------------------------------------------------------------
  Future<void> deletePrescribeByCode({
    required BuildContext context,
    required int companyId,
    required int prescriptionId,
  }) async {
    ApiResponseModel? apiResponseModel =
        await prescribeController.deletePrescribeByCode(
            context: context,
            companyId: companyId,
            prescriptionId: prescriptionId);

    if (apiResponseModel?.statusCode == 200) {
      getAllPrescribes(context: context);
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
    }
  }

//----------------------------------------------------------------------------
  Future<void> getAllDrugs({required BuildContext context}) async {
    ApiResponseModel? apiResponseModel =
        await prescribeController.getAllDrugs(context: context);

    if (apiResponseModel?.statusCode == 200) {
      drugs = apiResponseModel?.data.map<DrugModel>((e) {
        return DrugModel.fromJson(e);
      }).toList();
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
    }
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
    drugs.firstWhere((element) => element.id == drug.id).isSelect = false;
    drugs = drugs;
    haveDrugSelected = drugs.where((element) => element.isSelect).isNotEmpty;
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
        getAllPrescribes(context: context);
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
      "imageName": image!.path.split('/').last,
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
    ApiResponseModel? apiResponseModel =
        await prescribeController.uploadFormData(
            context: context,
            file: image!,
            precripId: precripId,
            onSendProgress: (int send, int total) {
              String percent = (send / total * 100).toStringAsFixed(2);
              sendMessage = '$percent%';
            });
    if (apiResponseModel?.statusCode == 201) {
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
