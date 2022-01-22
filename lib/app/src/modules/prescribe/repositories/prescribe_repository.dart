import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../../modules/prescribe/interfaces/prescribe_repository_interface.dart';
import '../../../core/models/api_response.model.dart';
import '../../../core/routes/api.routes.dart';
import '../../util/alert_awesome/alert_awesome_widget.dart';
import '../../../core/interfaces/api.interface.dart';

class PrescribeRepository implements IPrescribeRepository {
  PrescribeRepository(this._api);

  final IApi _api;

//----------------------------------------------------------------------------
  @override
  Future<ApiResponseModel?> addPrescribe({required context}) async {
    try {
      ApiResponseModel response = await _api.call(
          type: EApiType.post,
          url: ApiRoutes.addPrescription,
          data: {},
          headers: {'Content-Type': 'application/json'}).catchError((e) {
        awesomeDialogWidget(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.NO_HEADER,
            text: e.response.data['messages'][0]['message'],
            title: e.response.data['title'],
            borderColor: Colors.red,
            buttonColor: Colors.red.shade800,
            btnOkOnPress: () {});
      });
      return response;
    } catch (e) {
      print(e);
    }
  }

//----------------------------------------------------------------------------
  @override
  Future<ApiResponseModel?> deletePrescribe({required context}) async {
    try {
      ApiResponseModel response = await _api.call(
          type: EApiType.post,
          url: ApiRoutes.deletePrescriptionByCode(1),
          data: {},
          headers: {'Content-Type': 'application/json'}).catchError((e) {
        awesomeDialogWidget(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.NO_HEADER,
            text: e.response.data['messages'][0]['message'],
            title: e.response.data['title'],
            borderColor: Colors.red,
            buttonColor: Colors.red.shade800,
            btnOkOnPress: () {});
      });
      return response;
    } catch (e) {
      print(e);
    }
  }

//----------------------------------------------------------------------------
  @override
  Future<ApiResponseModel?> updatePrescribe({required context}) async {
    try {
      ApiResponseModel response = await _api.call(
          type: EApiType.post,
          url: ApiRoutes.addPrescription,
          data: {},
          headers: {'Content-Type': 'application/json'}).catchError((e) {
        awesomeDialogWidget(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.NO_HEADER,
            text: e.response.data['messages'][0]['message'],
            title: e.response.data['title'],
            borderColor: Colors.red,
            buttonColor: Colors.red.shade800,
            btnOkOnPress: () {});
      });
      return response;
    } catch (e) {
      print(e);
    }
  }
//----------------------------------------------------------------------------
  @override
  Future<ApiResponseModel?> getAllPrescribes({required context}) async{
    try {
      ApiResponseModel response = await _api.call(
          type: EApiType.post,
          url: ApiRoutes.getPrescriptions,
          data: {},
          headers: {'Content-Type': 'application/json'}).catchError((e) {
        awesomeDialogWidget(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.NO_HEADER,
            text: e.response.data['messages'][0]['message'],
            title: e.response.data['title'],
            borderColor: Colors.red,
            buttonColor: Colors.red.shade800,
            btnOkOnPress: () {});
      });
      return response;
    } catch (e) {
      print(e);
    }
  }
//----------------------------------------------------------------------------
}
