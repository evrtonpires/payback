import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../../core/models/api_response.model.dart';
import '../../../core/routes/api.routes.dart';
import '../../../core/interfaces/recovery_password_repository_interface.dart';
import '../../util/alert_awesome/alert_awesome_widget.dart';
import '../../../core/interfaces/api.interface.dart';

class RecoveryPasswordRepository implements IRecoveryPasswordRepository {
  RecoveryPasswordRepository(this._api);

  final IApi _api;

//----------------------------------------------------------------------------
  @override
  Future<bool> getRecoveryPasswordValidadeEmail(
      {required String email, context}) async {
    try {
      ApiResponseModel response = await _api.call(
          type: EApiType.post,
          url: ApiRoutes.sendEmail,
          data: {"email": email},
          headers: {'Content-Type': 'application/json'}).catchError((e) {
        awesomeDialogWidget(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.NO_HEADER,
            text: e.response.statusCode == 404
                ? e.response.data['messages'][0]['message']
                : e.response.data['errors'][0]['message'],
            title: e.response.data['title'],
            borderColor: Colors.red,
            buttonColor: Colors.red.shade800,
            btnOkOnPress: () {});
      });
      return response.data["success"];
    } catch (e) {
      return false;
    }
  }

  //----------------------------------------------------------------------------
  @override
  Future<bool> getRecoveryPassword({
    context,
    required String password,
    required String code,
  }) async {
    try {
      ApiResponseModel response = await _api
          .call(type: EApiType.post, url: ApiRoutes.replacePassByCode, data: {
        "newPass": password.trim(),
        "code": code.toUpperCase().trim(),
      }, headers: {
        'Content-Type': 'application/json'
      }).catchError((e) {
        awesomeDialogWidget(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.NO_HEADER,
            text: e.response.statusCode == 404
                ? e.response.data['messages'][0]['message']
                : e.response.data['errors'][0]['message'],
            title: e.response.data['title'],
            borderColor: Colors.red,
            buttonColor: Colors.red.shade800,
            btnOkOnPress: () {});
      });
      return response.data["success"];
    } catch (e) {
      return false;
    }
  }
}
