import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

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
  void setCnpj(String newCnpj) => cnpj = newCnpj;

  //----------------------------------------------------------------------------
  @observable
  String? messageCnpjError;

  //----------------------------------------------------------------------------

  @observable
  String? user;

  //----------------------------------------------------------------------------
  @action
  void setLogin(String newUser) => user = newUser;

  //----------------------------------------------------------------------------
  @observable
  String? messageLoginError;

  //----------------------------------------------------------------------------
  @observable
  String? password;

  //----------------------------------------------------------------------------
  @action
  void setPassword(String newPassword) => password = newPassword;

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

  @action
  Future<void> autenticate(
      BuildContext context, String title, String text) async {
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
      LoginResponseModel? loginResponse = await loginController.signIn(
        loginFormulary: LoginFormularyModel(
            login: user!.trim(),
            password: password!.trim(),
            cnpj: cnpj!.trim()),
        context: context,
      );
      if (loginResponse != null) {
        isLoading = false;
        appStore.userModel = loginResponse.user;
        appStore.checkConnectivityPushNamed(
          context: context,
          rout: AppRouteNamed.home.fullPath!,
          isReplacement: false,
          title: title,
          text: text,
        );
      } else {
        isLoading = false;
      }
    }
  }
}
