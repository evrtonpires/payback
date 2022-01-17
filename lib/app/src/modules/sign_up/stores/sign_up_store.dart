import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

import '../../../core/models/login_response_model.dart';
import '../controllers/sign_up_controller.dart';
import '../models/sign_up_formulary_model.dart';
import '../../../app_routing.dart';
import '../../../app_store.dart';

part 'sign_up_store.g.dart';

class SignUpStore = _SignUpStoreBase with _$SignUpStore;

abstract class _SignUpStoreBase with Store {
  _SignUpStoreBase({required this.signUpController}) {
    focusCnpj = FocusNode();
    focusName = FocusNode();
    focusEmail = FocusNode();
    focusEmailConfirmation = FocusNode();
    focusCpf = FocusNode();
    focusPassword = FocusNode();
    focusPasswordConfirmation = FocusNode();
  }

  final SignUpController signUpController;

  late final FocusNode focusCnpj;
  late final FocusNode focusName;
  late final FocusNode focusEmail;
  late final FocusNode focusEmailConfirmation;
  late final FocusNode focusCpf;
  late final FocusNode focusPassword;
  late final FocusNode focusPasswordConfirmation;

  AppStore get appStore => signUpController.appStore;

  @observable
  bool isLoading = false;

  @observable
  bool keepConnected = true;

//----------------------------------------------------------------------------
  @observable
  String? cnpj;

  @action
  void setCnpj(String newCnpj) => cnpj = newCnpj;

  @observable
  String? messageCnpjError;

//----------------------------------------------------------------------------
  @observable
  String? name;

  @action
  void setName(String newName) => name = newName;

  @observable
  String? messageNameError;

//----------------------------------------------------------------------------

  @observable
  String? email;

  @action
  void setEmail(String newEmail) => email = newEmail;

  @observable
  String? messageEmailError;

//----------------------------------------------------------------------------
  @observable
  String? emailConfirmation;

  @action
  void setEmailConfirmation(String newEmailConfirmation) =>
      emailConfirmation = newEmailConfirmation;

  @observable
  String? messageEmailConfirmationError;

//----------------------------------------------------------------------------
  @observable
  String? cpf;

  @action
  void setCpf(String newCpf) => cpf = newCpf;

  @observable
  String? messageCpfError;

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

  bool cnpjValidate(BuildContext context, {bool requestFocus = false}) {
    messageCnpjError = null;

    if (cnpj == null || cnpj!.isEmpty) {
      messageCnpjError = 'Campo obrigatório';
      if (requestFocus) {
        focusCnpj.requestFocus();
      }
      return false;
    } else if (CNPJValidator.isValid(cnpj)) {
      messageCnpjError = null;
      return true;
    } else {
      messageCnpjError = 'Informe um CNPJ válido';
      if (requestFocus) {
        focusCnpj.requestFocus();
      }
      return false;
    }
  }

//----------------------------------------------------------------------------
  bool nameValidate(BuildContext context, {bool requestFocus = false}) {
    messageNameError = null;
    if (name == null || name!.isEmpty) {
      messageNameError = 'Campo obrigatório';
      if (requestFocus) {
        focusName.requestFocus();
      }
      return false;
    }
    return true;
  }

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
      messageEmailConfirmationError = null;
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
  bool emailConfirmationValidate(BuildContext context,
      {bool requestFocus = false}) {
    messageEmailConfirmationError = null;
    if (emailConfirmation == null || emailConfirmation!.isEmpty) {
      messageEmailConfirmationError = 'Campo obrigatório';
      if (requestFocus) {
        focusEmailConfirmation.requestFocus();
      }
      return false;
    } else if (email != emailConfirmation) {
      messageEmailConfirmationError = 'Os emails não coincidem';
      if (requestFocus) {
        focusEmailConfirmation.requestFocus();
      }
      return false;
    } else {
      messageEmailConfirmationError = null;
      messageEmailError = null;
    }
    return true;
  }

//----------------------------------------------------------------------------

  bool cpfValidate(BuildContext context, {bool requestFocus = false}) {
    messageCpfError = null;

    if (cpf == null || cpf!.isEmpty) {
      messageCpfError = 'Campo obrigatório';
      if (requestFocus) {
        focusCpf.requestFocus();
      }
      return false;
    } else if (CPFValidator.isValid(cpf)) {
      messageCpfError = null;
      return true;
    } else {
      messageCpfError = 'Informe um CPF válido';
      if (requestFocus) {
        focusCpf.requestFocus();
      }
      return false;
    }
  }

  //----------------------------------------------------------------------------
  final RegExp _regExp = RegExp(
      "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\$%^&*.%()/-]).{8,}\$");

  bool passwordValidate(BuildContext context, {bool requestFocus = false}) {
    messagePasswordError = null;

    if (password == null || password!.isEmpty) {
      messagePasswordError = 'Campo obrigatório';
      if (requestFocus) {
        focusPassword.requestFocus();
      }
      return false;
    } else if (_regExp.hasMatch(password!)) {
      if (passwordConfirmation != null &&
          passwordConfirmation!.isNotEmpty &&
          password != passwordConfirmation) {
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
  @action
  Future<void> autenticate(BuildContext context) async {
    if (!cnpjValidate(context, requestFocus: true)) {
      return;
    }
    if (!nameValidate(context, requestFocus: true)) {
      return;
    }
    if (!emailValidate(context, requestFocus: true)) {
      return;
    }
    if (!emailConfirmationValidate(context, requestFocus: true)) {
      return;
    }
    if (!passwordValidate(context, requestFocus: true)) {
      return;
    }
    if (!passwordConfirmationValidate(context, requestFocus: true)) {
      return;
    }

    if (messageCnpjError == null &&
        messageNameError == null &&
        messageEmailError == null &&
        messagePasswordError == null &&
        messagePasswordConfirmationError == null &&
        !isLoading) {
      SignUpFormularyModel signUpFormulary = SignUpFormularyModel(
        name: name!,
        email: email!,
        password: password!,
        cnpj: cnpj!,
        type: 1,
      );

      isLoading = true;
      LoginResponseModel? loginResponse = await signUpController.signUp(
        signUpFormularyModel: signUpFormulary,
        context: context,
      );

      if (loginResponse != null) {
        isLoading = false;
        appStore.userModel = loginResponse.user;
        appStore.checkConnectivityPushNamed(
          context: context,
          rout: AppRouteNamed.home.fullPath!,
          isReplacement: false,
        );
      } else {
        isLoading = false;
      }
    }
  }
//----------------------------------------------------------------------------
}
