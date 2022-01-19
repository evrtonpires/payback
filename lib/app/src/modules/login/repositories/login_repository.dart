import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../../core/models/api_response.model.dart';
import '../../../core/routes/api.routes.dart';
import '../models/login_formulary_model.dart';
import '../../util/alert_awesome/alert_awesome_widget.dart';
import '../interfaces/login_repository_interface.dart';
import '../../../core/interfaces/api.interface.dart';

class LoginRepository implements ILoginRepository {
  LoginRepository(this._api);

  final IApi _api;

//----------------------------------------------------------------------------
  @override
  Future<ApiResponseModel?> getLogin({
    required LoginFormularyModel loginFormulary,
    context,
  }) async {
    try {
      ApiResponseModel response = await _api.call(
          type: EApiType.post,
          url: ApiRoutes.authAuthenticate,
          data: loginFormulary.toJson(),
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
}
