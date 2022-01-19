import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:payback/app/src/core/models/api_response.model.dart';

import '../interfaces/login_repository_interface.dart';
import '../../../core/models/login_response_model.dart';
import '../models/login_formulary_model.dart';
import '../../util/alert_awesome/alert_awesome_widget.dart';
import '../../../app_store.dart';

class LoginController {
  LoginController(this._loginRepository, this._appStore);

  final ILoginRepository _loginRepository;

  final AppStore _appStore;

  AppStore get appStore => _appStore;

  //----------------------------------------------------------------------------
  Future<ApiResponseModel?> signIn({
    required LoginFormularyModel loginFormulary,
    required context,
  }) async {
    try {
      var connectivityResult = await _appStore.checkConnectivity();

      if (connectivityResult) {
        loginFormulary.password =
            _appStore.encryptFunction(loginFormulary.password);
        ApiResponseModel? apiResponseModel = await _loginRepository.getLogin(
          loginFormulary: loginFormulary,
          context: context,
        );
        if (apiResponseModel != null) {
          if (apiResponseModel.statusCode == 200) {
            _appStore.saveUserSharedPrefs(
                stringValue: 'cnpjValue', data: loginFormulary.cnpj);

            _appStore.saveUserSharedPrefs(
                stringValue: 'userValue',
                data: LoginResponseModel.fromJson(apiResponseModel.data)
                    .user
                    .email);

            _appStore.saveUserSharedPrefs(
                stringValue: 'passwordValue',
                data: _appStore.decryptFunction(loginFormulary.password));

            return apiResponseModel;
          } else {
            awesomeDialogWidget(
                context: context,
                animType: AnimType.SCALE,
                dialogType: DialogType.NO_HEADER,
                text: apiResponseModel.data['messages'][0]['message'],
                title: apiResponseModel.data['title'],
                borderColor: Colors.red,
                buttonColor: Colors.red.shade800,
                btnOkOnPress: () {});
          }
        } else {
          return null;
        }
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
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
