import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../app_store.dart';
import '../controllers/recovery_password_controller.dart';

part 'recovery_password_store.g.dart';

class RecoveryPasswordStore = _RecoveryPasswordStoreBase
    with _$RecoveryPasswordStore;

abstract class _RecoveryPasswordStoreBase with Store {
  _RecoveryPasswordStoreBase({required this.recoveryPasswordController}) {
    focusEmail = FocusNode();
    focusPassword = FocusNode();
    focusPasswordConfirmation = FocusNode();
    focusCode = FocusNode();
  }

  final RecoveryPasswordController recoveryPasswordController;

  late final FocusNode focusEmail;
  late final FocusNode focusPassword;
  late final FocusNode focusPasswordConfirmation;
  late final FocusNode focusCode;

  @observable
  bool isValidate = false;

  @observable
  bool isLoading = false;

  @observable
  bool keepConnected = true;

  AppStore get appStore => recoveryPasswordController.appStore;

  //----------------------------------------------------------------------------

  @observable
  String? email;

  @action
  void setEmail(String newEmail) => email = newEmail;

  @observable
  String? messageEmailError;

//----------------------------------------------------------------------------
  @observable
  String? password;

  @action
  void setPassword(String newPassword) => password = newPassword;

  @observable
  String? messagePasswordError;

//----------------------------------------------------------------------------
  @observable
  String? passwordConfirmation;

  @action
  void setPasswordConfirmation(String newPasswordConfirmation) =>
      passwordConfirmation = newPasswordConfirmation;

  @observable
  String? messagePasswordConfirmationError;

//----------------------------------------------------------------------------
  @observable
  String? code;

  @action
  void setCode(String newCode) => code = newCode;

  @observable
  String? messageCodeError;

//----------------------------------------------------------------------------
  bool emailValidate(BuildContext context, {bool requestFocus = false}) {
    messageEmailError = null;
    RegExp regExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (email == null || email!.isEmpty) {
      messageEmailError = 'Campo obrigatório';
      if (requestFocus) {
        focusEmail.requestFocus();
      }
      return false;
    } else if (regExp.hasMatch(email!)) {
      messageEmailError = null;

      return true;
    } else {
      messageEmailError = 'Insira um email valido';
      if (requestFocus) {
        focusEmail.requestFocus();
      }
      return false;
    }
  }

//----------------------------------------------------------------------------
  bool passwordValidate(BuildContext context, {bool requestFocus = false}) {
    messagePasswordError = null;
    RegExp regExp = RegExp(
        "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\$%^&*.%()/-]).{8,}\$");

    if (password == null || password!.isEmpty) {
      messagePasswordError = 'Campo obrigatório';
      if (requestFocus) {
        focusPassword.requestFocus();
      }
      return false;
    } else if (regExp.hasMatch(password!)) {
      messagePasswordConfirmationError = null;
      messagePasswordError = null;

      return true;
    } else {
      messagePasswordError =
          'Utilize:\n* Minimo 8 caracteres.\n* Números de 0-9.\n* Letras maiusculas.\n* Letras minusculas.\n* Caracteres especiais (Exemplo: #?!@\$%^&*.%()/- ).';
      if (requestFocus) {
        focusPassword.requestFocus();
      }
      return false;
    }
  }

  //----------------------------------------------------------------------------
  bool passwordConfirmationValidate(BuildContext context,
      {bool requestFocus = false}) {
    messagePasswordConfirmationError = null;
    if (passwordConfirmation == null || passwordConfirmation!.isEmpty) {
      messagePasswordConfirmationError = 'Campo obrigatório';
      if (requestFocus) {
        focusPasswordConfirmation.requestFocus();
      }
      return false;
    } else if (password != passwordConfirmation) {
      messagePasswordConfirmationError = 'As senhas não coincidem';
      if (requestFocus) {
        focusPasswordConfirmation.requestFocus();
      }
      return false;
    } else {
      messagePasswordConfirmationError = null;
      messagePasswordError = null;
    }
    return true;
  }

//----------------------------------------------------------------------------
  bool codeValidate(BuildContext context, {bool requestFocus = false}) {
    messageCodeError = null;
    if (code == null || code!.isEmpty) {
      messageCodeError = 'Campo obrigatório';
      if (requestFocus) {
        focusCode.requestFocus();
      }
      return false;
    }
    return true;
  }

//----------------------------------------------------------------------------
  @action
  Future<void> autenticateEmail(BuildContext context) async {
    if (!emailValidate(context, requestFocus: true)) {
      return;
    }

    if (messageEmailError == null && !isLoading) {
      isLoading = true;
      bool? response = await recoveryPasswordController
          .recoveryPasswordValidadeEmail(email: email!, context: context);
      if (response!) {
        isLoading = false;
        isValidate = response;
      } else {
        isLoading = false;
      }
    }
  }

  @action
  Future<bool?> autenticate(BuildContext context) async {
    if (!emailValidate(context, requestFocus: true)) {
      return null;
    }
    if (!passwordValidate(context, requestFocus: true)) {
      return null;
    }
    if (!passwordConfirmationValidate(context, requestFocus: true)) {
      return null;
    }
    if (!passwordConfirmationValidate(context, requestFocus: true)) {
      return null;
    }

    if (messageEmailError == null &&
        messagePasswordError == null &&
        messagePasswordConfirmationError == null &&
        messageCodeError == null &&
        !isLoading) {
      isLoading = true;
      bool response = await recoveryPasswordController.recoveryPassword(
          context: context, password: password!, code: code!, email: email!);
      if (response) {
        isLoading = false;
        return true;
      } else {
        isLoading = false;
        return false;
      }
    }
  }
//----------------------------------------------------------------------------

}
