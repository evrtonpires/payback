import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http_parser/http_parser.dart';
import 'package:payback/app/src/app_store.dart';

import '../../interfaces/prescribe/prescribe_repository_interface.dart';
import '../../../../core/models/api_response.model.dart';
import '../../../../core/routes/api.routes.dart';
import '../../../util/alert_awesome/alert_awesome_widget.dart';
import '../../../../core/interfaces/api.interface.dart';

class PrescribeRepository implements IPrescribeRepository {
  PrescribeRepository(this._api);

  final IApi _api;

//----------------------------------------------------------------------------
  @override
  Future<ApiResponseModel?> addPrescribe(
      {required context, required dynamic data}) async {
    try {
      ApiResponseModel response = await _api.call(
          type: EApiType.post,
          url: ApiRoutes.addPrescription,
          data: data,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${Modular.get<AppStore>().token}'
          }).catchError((e) {
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
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${Modular.get<AppStore>().token}'
          }).catchError((e) {
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
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${Modular.get<AppStore>().token}'
          }).catchError((e) {
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
  Future<ApiResponseModel?> getAllPrescribes({required context}) async {
    try {
      ApiResponseModel response = await _api.call(
          type: EApiType.post,
          url: ApiRoutes.getPrescriptions,
          data: {},
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${Modular.get<AppStore>().token}'
          }).catchError((e) {
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

  Future<FormData> transformFormData(File file) async {
    final String fileName = file.path.split('/').last;
    return FormData.fromMap(<String, dynamic>{
      'file': await MultipartFile.fromFile(
        file.path,
        filename: fileName,
        contentType: MediaType("image", "jpg"), //im
      ),
    });
  }

  @override
  Future<ApiResponseModel?> uploadFormData(
      {required context,
      required File file,
      required int precripId,
      required Function(int send, int total) onSendProgress}) async {
    try {
      final FormData formData = await transformFormData(file);

      ApiResponseModel? apiResponseModel = await _api
          .call(
              type: EApiType.post,
              url: ApiRoutes.postImage(precripId),
              data: formData,
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'multipart/form-data',
                'Authorization': 'Bearer ${Modular.get<AppStore>().token}'
              },
              onSendProgress: onSendProgress)
          .catchError((e) {
        print(e.cause);
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
      return apiResponseModel;
    } on DioError catch (e) {
      throw e.error as Exception;
    }
  }
//----------------------------------------------------------------------------
}
