import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../../core/interfaces/sign_up_repository_interface.dart';
import '../models/sign_up_formulary_model.dart';
import '../../../core/models/login_response_model.dart';
import '../../util/alert_awesome/alert_awesome_widget.dart';
import '../../../app_store.dart';

class SignUpController {
  SignUpController(this._signUpRepository, this._appStore);

  final ISignUpRepository _signUpRepository;

  final AppStore _appStore;

  AppStore get appStore => _appStore;

  //----------------------------------------------------------------------------
  Future<LoginResponseModel?> signUp({
    required SignUpFormularyModel signUpFormularyModel,
    required context,
  }) async {
    try {
      LoginResponseModel? loginResponseModel;
      var connectivityResult = await _appStore.checkConnectivity();

      if (connectivityResult) {
        signUpFormularyModel.password =
            _appStore.encryptFunction(signUpFormularyModel.password);

        loginResponseModel = await _signUpRepository.getSignUp(
            signUpFormularyModel: signUpFormularyModel, context: context);

        if (loginResponseModel != null) {
          _appStore.saveUserSharedPrefs(
              stringValue: 'cnpjValue', data: signUpFormularyModel.cnpj);

          _appStore.saveUserSharedPrefs(
              stringValue: 'userValue', data: loginResponseModel.user.email);

          _appStore.saveUserSharedPrefs(
              stringValue: 'passwordValue',
              data: _appStore.decryptFunction(signUpFormularyModel.password));

          return loginResponseModel;
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
                'Caso tenha um cadastro conosco, ative sua internet e realize o login para termos os dados necessarios em nossa base local.\n\nCaso não tenha, obtenha um cadastro em nosso aplicativo para realizar o login.',
            borderColor: Colors.red,
            buttonColor: Colors.red.shade800,
            btnOkOnPress: () {});

        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
