import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:payback/app/src/modules/prescribe/controllers/prescribe_controller.dart';

part 'prescribe_store.g.dart';

class PrescribeStore = _PrescribeStoreBase with _$PrescribeStore;

abstract class _PrescribeStoreBase with Store {
  _PrescribeStoreBase({required this.prescribeController}) {
    _picker = ImagePicker();
  }

  final PrescribeController prescribeController;
  late final ImagePicker _picker;

  @observable
  File? image;

  Future<File?>addImagePrescribeCamera() async {
    File? fileImage;
    XFile? img =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if(img != null) {
      fileImage = File(img.path);
    }
    prescribeController.appStore.modularPop();
    return fileImage;
  }

  Future<File?> addImagePrescribeGallery() async {
    File? fileImage;
    XFile? img =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if(img != null) {
      fileImage = File(img.path);
    }
    prescribeController.appStore.modularPop();
    return fileImage;
  }

  addPrescribePage({required String rout, required BuildContext context}) {
    prescribeController.appStore.pushNamed(
        rout: rout,
        context: context,
        isReplacement: false,
        isRootNavigator: true);
  }
}
