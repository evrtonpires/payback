import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../../core/models/api_response.model.dart';
import '../../../core/models/login_response_model.dart';
import '../../../core/routes/api.routes.dart';
import '../models/login_formulary_model.dart';
import '../../util/alert_awesome/alert_awesome_widget.dart';
import '../../../core/interfaces/login_repository_interface.dart';
import '../../../core/interfaces/api.interface.dart';

class LoginRepository implements ILoginRepository {
  LoginRepository(this._api);

  final IApi _api;

//----------------------------------------------------------------------------
  @override
  Future<LoginResponseModel?> getLogin({
    required LoginFormularyModel loginFormulary,
    context,
  }) async {
    try {
      ApiResponseModel response = await _api
          .call(
        type: EApiType.post,
        url: ApiRoutes.authAuthenticate,
        data: loginFormulary.toJson(),
        headers: {'Content-Type' : 'application/json'}
      )
          .catchError((e) {
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

      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(response.data);
      }else{
        awesomeDialogWidget(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.NO_HEADER,
            text: response.data['messages'][0]['message'],
            title: response.data['title'],
            borderColor: Colors.red,
            buttonColor: Colors.red.shade800,
            btnOkOnPress: () {});
        return null;
      }
    } catch (e) {}
  }
}
