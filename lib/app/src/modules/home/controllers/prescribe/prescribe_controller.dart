import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:payback/app/src/core/models/api_response.model.dart';
import 'package:payback/app/src/modules/util/alert_awesome/alert_awesome_widget.dart';

import '../../interfaces/prescribe/prescribe_repository_interface.dart';
import '../../../../app_store.dart';

class PrescribeController {
  PrescribeController(this._prescribeRepository, this._appStore);

  final IPrescribeRepository _prescribeRepository;

  final AppStore _appStore;

  AppStore get appStore => _appStore;

  //----------------------------------------------------------------------------
  Future<ApiResponseModel?> getAllPrescribes({
    required context,
  }) async {
    try {
      var connectivityResult = await _appStore.checkConnectivity();

      if (connectivityResult) {
        ApiResponseModel? apiResponseModel =
            await _prescribeRepository.getAllPrescribes(
          context: context,
        );

        return apiResponseModel;
      } else {
        awesomeDialogWidget(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.NO_HEADER,
            title: 'Erro ao obter acesso',
            text:
                'Ops\nVerifique sua conexão com a internet e tente novamente.',
            borderColor: Colors.red,
            buttonColor: Colors.red.shade800,
            btnOkOnPress: () {});
      }
    } catch (e) {
      print(e);
    }
  }

  //----------------------------------------------------------------------------
  Future<ApiResponseModel?> deletePrescribeByCode({
    required context,
    required int companyId,
    required int prescriptionId,
  }) async {
    try {
      var connectivityResult = await _appStore.checkConnectivity();

      if (connectivityResult) {
        ApiResponseModel? apiResponseModel =
            await _prescribeRepository.deletePrescribe(
          context: context,
          companyId: companyId,
          prescriptionId: prescriptionId,
        );

        return apiResponseModel;
      } else {
        awesomeDialogWidget(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.NO_HEADER,
            title: 'Erro ao obter acesso',
            text:
                'Ops\nVerifique sua conexão com a internet e tente novamente.',
            borderColor: Colors.red,
            buttonColor: Colors.red.shade800,
            btnOkOnPress: () {});
      }
    } catch (e) {
      print(e);
    }
  }

  //----------------------------------------------------------------------------


  Future<ApiResponseModel?> updatePrescribeByCode({
    required context,
    required int companyId,
    required int prescriptionId,
  }) async {
    try {
      var connectivityResult = await _appStore.checkConnectivity();

      if (connectivityResult) {
        ApiResponseModel? apiResponseModel =
            await _prescribeRepository.updatePrescribe(
          context: context,
          // companyId: companyId,
          // prescriptionId: prescriptionId,
        );

        return apiResponseModel;
      } else {
        awesomeDialogWidget(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.NO_HEADER,
            title: 'Erro ao obter acesso',
            text:
                'Ops\nVerifique sua conexão com a internet e tente novamente.',
            borderColor: Colors.red,
            buttonColor: Colors.red.shade800,
            btnOkOnPress: () {});
      }
    } catch (e) {
      print(e);
    }
  }

  //----------------------------------------------------------------------------

  Future<ApiResponseModel?> getAllDrugs({
    required context,
  }) async {
    try {
      var connectivityResult = await _appStore.checkConnectivity();

      if (connectivityResult) {
        ApiResponseModel? apiResponseModel =
            await _prescribeRepository.getAllDrugs(
          context: context,
        );

        return apiResponseModel;
      } else {
        awesomeDialogWidget(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.NO_HEADER,
            title: 'Erro ao obter acesso',
            text:
                'Ops\nVerifique sua conexão com a internet e tente novamente.',
            borderColor: Colors.red,
            buttonColor: Colors.red.shade800,
            btnOkOnPress: () {});
      }
    } catch (e) {
      print(e);
    }
  }

  //----------------------------------------------------------------------------

  Future<ApiResponseModel?> addPrescribe({
    required dynamic data,
    required context,
  }) async {
    try {
      var connectivityResult = await _appStore.checkConnectivity();

      if (connectivityResult) {
        ApiResponseModel? apiResponseModel =
            await _prescribeRepository.addPrescribe(
          data: data,
          context: context,
        );

        return apiResponseModel;
      } else {
        awesomeDialogWidget(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.NO_HEADER,
            title: 'Erro ao obter acesso',
            text:
                'Ops\nVerifique sua conexão com a internet e tente novamente.',
            borderColor: Colors.red,
            buttonColor: Colors.red.shade800,
            btnOkOnPress: () {});
      }
    } catch (e) {
      print(e);
    }
  }

  //----------------------------------------------------------------------------

  Future<ApiResponseModel?> uploadFormData(
      {required File file,
      required int precripId,
      required context,
      required Function(int send, int total) onSendProgress}) async {
    try {
      var connectivityResult = await _appStore.checkConnectivity();

      if (connectivityResult) {
        ApiResponseModel? apiResponseModel =
            await _prescribeRepository.uploadFormData(
                file: file,
                context: context,
                precripId: precripId,
                onSendProgress: onSendProgress);
        return apiResponseModel;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
//----------------------------------------------------------------------------
}
