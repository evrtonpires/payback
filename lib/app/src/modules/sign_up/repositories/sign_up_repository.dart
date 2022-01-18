import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:payback/app/src/core/models/login_response_model.dart';
import 'package:payback/app/src/modules/sign_up/models/sign_up_formulary_model.dart';

import '../interfaces/sign_up_repository_interface.dart';
import '../../../core/models/api_response.model.dart';
import '../../../core/routes/api.routes.dart';
import '../../util/alert_awesome/alert_awesome_widget.dart';
import '../../../core/interfaces/api.interface.dart';

class SignUpRepository implements ISignUpRepository {
  SignUpRepository(this._api);

  final IApi _api;

//----------------------------------------------------------------------------
  @override
  Future<LoginResponseModel?> getSignUp({
    context,
    required SignUpFormularyModel signUpFormularyModel,
  }) async {
    try {
      ApiResponseModel response = await _api.call(
          type: EApiType.post,
          url: ApiRoutes.addUser(signUpFormularyModel.cnpj),
          data: signUpFormularyModel.toJson(),
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

      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(response.data);
      }
    } catch (e) {}
  }

//----------------------------------------------------------------------------

}
