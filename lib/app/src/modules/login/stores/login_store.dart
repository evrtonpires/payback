import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:mobx/mobx.dart';
import 'package:payback/app/src/core/models/api_response.model.dart';
import 'package:payback/app/src/modules/util/alert_awesome/alert_awesome_widget.dart';
import 'dart:async';

import '../../../../../app/src/app_store.dart';
import '../../../core/models/login_response_model.dart';
import '../controllers/login_controller.dart';
import '../models/login_formulary_model.dart';
import '../../../app_routing.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  //----------------------------------------------------------------------------
  LoginStoreBase({required this.loginController}) {
    focusCnpj = FocusNode();
    focusLogin = FocusNode();
    focusPassword = FocusNode();
  }

  final LoginController loginController;

  late final FocusNode focusCnpj;
  late final FocusNode focusLogin;
  late final FocusNode focusPassword;

  AppStore get appStore => loginController.appStore;

  //----------------------------------------------------------------------------
  @observable
  String? cnpj;

  //----------------------------------------------------------------------------
  @action
  void setCnpj(String newCnpj) => cnpj = newCnpj.trimRight();

  //----------------------------------------------------------------------------
  @observable
  String? messageCnpjError;

  //----------------------------------------------------------------------------

  @observable
  String? user;

  //----------------------------------------------------------------------------
  @action
  void setLogin(String newUser) => user = newUser.trimRight();

  //----------------------------------------------------------------------------
  @observable
  String? messageLoginError;

  //----------------------------------------------------------------------------
  @observable
  String? password;

  //----------------------------------------------------------------------------
  @action
  void setPassword(String newPassword) => password = newPassword.trimRight();

  //----------------------------------------------------------------------------
  @observable
  String? messagePasswordError;

  //----------------------------------------------------------------------------
  @observable
  bool isLoading = false;

  //----------------------------------------------------------------------------
  @observable
  bool keepConnected = true;

  //----------------------------------------------------------------------------
  bool cnpjValidate(BuildContext context, {bool requestFocus = false}) {
    messageCnpjError = null;
    if (cnpj == null || cnpj!.isEmpty) {
      messageCnpjError = 'Campo obrigatório';
      if (requestFocus) {
        focusCnpj.requestFocus();
      }
      return false;
    }
    return true;
  }

  //----------------------------------------------------------------------------
  bool loginValidate(BuildContext context, {bool requestFocus = false}) {
    messageLoginError = null;
    if (user == null || user!.isEmpty) {
      messageLoginError = 'Campo obrigatório';
      if (requestFocus) {
        focusLogin.requestFocus();
      }
      return false;
    }
    return true;
  }

  //----------------------------------------------------------------------------
  bool passwordValidate(BuildContext context, {bool requestFocus = false}) {
    messagePasswordError = null;
    if (password == null || password!.isEmpty) {
      messagePasswordError = 'Campo obrigatório';
      if (requestFocus) {
        focusPassword.requestFocus();
      }
      return false;
    }
    return true;
  }

  //----------------------------------------------------------------------------
  void startTimer(context) {
    Timer.periodic(const Duration(milliseconds: 500), (Timer t) {
      awesomeDialogWidget(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.SUCCES,
          title: FlutterI18n.translate(context, 'telaCadastroUsuario.sucesso'),
          text: FlutterI18n.translate(
              context, 'telaCadastroUsuario.msgConfirmacaoCadastro'),
          borderColor: Colors.green,
          buttonColor: Colors.green.shade800,
          btnOkOnPress: () {});

      t.cancel();
    });
  }

  //----------------------------------------------------------------------------

  @action
  Future<void> autenticate(
      BuildContext context, String title, String text) async {
    if (!cnpjValidate(context, requestFocus: true)) {
      return;
    }
    if (!loginValidate(context, requestFocus: true)) {
      return;
    }
    if (!passwordValidate(context, requestFocus: true)) {
      return;
    }
    if (messageLoginError == null &&
        messagePasswordError == null &&
        messageCnpjError == null &&
        !isLoading) {
      isLoading = true;
      ApiResponseModel? apiResponseModel = await loginController.signIn(
        loginFormulary: LoginFormularyModel(
            login: user!.trim(),
            password: password!.trim(),
            cnpj: cnpj!.trim()),
        context: context,
      );
      if (apiResponseModel != null && apiResponseModel.statusCode == 200) {
        isLoading = false;
        appStore.userModel =
            LoginResponseModel.fromJson(apiResponseModel.data).user;
        appStore.token =
            LoginResponseModel.fromJson(apiResponseModel.data).token;
        appStore.checkConnectivityPushNamed(
          context: context,
          rout: AppRouteNamed.home.fullPath!,
          isReplacement: true,
          title: title,
          text: text,
        );
      } else {
        isLoading = false;
      }
    }
  }
}
