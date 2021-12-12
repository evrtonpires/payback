import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:payback/app/modules/shared/auth/auth_controller.dart';
import 'package:payback/app/modules/shared/models/user/user_model.dart';

part 'cadastro_de_usuario_store.g.dart';

class CadastroDeUsuarioStore = _CadastroDeUsuarioStoreBase
    with _$CadastroDeUsuarioStore;

abstract class _CadastroDeUsuarioStoreBase with Store {
  _CadastroDeUsuarioStoreBase({required this.authController}) {
    focusName = FocusNode();
    focusEmail = FocusNode();
    focusEmailConfirmation = FocusNode();
    focusPassword = FocusNode();
    focusPasswordConfirmation = FocusNode();
    focusCRMV = FocusNode();
  }

  final AuthController authController;

  late final FocusNode focusName;
  late final FocusNode focusEmail;
  late final FocusNode focusEmailConfirmation;
  late final FocusNode focusPassword;
  late final FocusNode focusPasswordConfirmation;
  late final FocusNode focusCRMV;

  @observable
  bool isLoading = false;

  @observable
  bool keepConnected = true;

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
  String? crmv;

  @action
  void setCRMV(String newCRMV) => crmv = newCRMV;

  @observable
  String? messageCRMVError;

//----------------------------------------------------------------------------

  @observable
  int? intETypeUser = 1;

  @action
  void setUserOrCRMV(int value) {
    intETypeUser = value;
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
  bool crmvValidate(BuildContext context, {bool requestFocus = false}) {
    messageCRMVError = null;
    if (crmv == null || crmv!.isEmpty && intETypeUser == 2) {
      messageCRMVError = 'Campo obrigatório';
      if (requestFocus) {
        focusCRMV.requestFocus();
      }
      return false;
    } else {
      crmv = null;
    }
    return true;
  }

//----------------------------------------------------------------------------
  @action
  Future<void> autenticate(BuildContext context) async {
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
    if (intETypeUser == 2 && !crmvValidate(context, requestFocus: true)) {
      return;
    }
    if (messageNameError == null &&
        messageEmailError == null &&
        messagePasswordError == null &&
        messageCRMVError == null &&
        !isLoading) {

      UserModel user = UserModel(
          id: null,
          name: name!,
          email: email!,
          password: password!);

      isLoading = true;
      bool? response = await authController.signUp(
        user: user,
        context: context,
      );
      if (response!) {
        isLoading = false;
        Modular.to.pushReplacementNamed('/home');
      } else {
        isLoading = false;
      }
    }
  }
//----------------------------------------------------------------------------
}
