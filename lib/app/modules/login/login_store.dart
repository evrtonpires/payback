import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:payback/app/modules/shared/auth/auth_controller.dart';
import 'package:payback/app/modules/util/alert_awesome/alert_awesome_widget.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  //----------------------------------------------------------------------------
  LoginStoreBase({this.authController}) {
    focusLogin = FocusNode();
    focusPassword = FocusNode();
  }

  final AuthController? authController;
  late final FocusNode focusLogin;
  late final FocusNode focusPassword;

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
  Future<void> checkConnectivityPushReplacementNamed(
      {context, required String rout, bool isReplacement = true}) async {
    var connectivityResult = await authController!.checkConnectivity();
    if (connectivityResult) {
      if (isReplacement) {
        Modular.to.pushReplacementNamed(rout);
      } else {
        Modular.to.pushNamed(rout);
      }
    } else {
      awesomeDialogWidget(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.NO_HEADER,
          title: 'Aviso',
          text:
              'É necessario estar conectado a internet para realizar o cadrastro.',
          borderColor: Colors.yellow,
          buttonColor: Colors.yellow.shade800,
          btnOkOnPress: () {});
    }
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
  Future<void> autenticate(BuildContext context) async {
    if (!loginValidate(context, requestFocus: true)) {
      return;
    }
    if (!passwordValidate(context, requestFocus: true)) {
      return;
    }
    if (messageLoginError == null &&
        messagePasswordError == null &&
        !isLoading) {
      isLoading = true;
      bool? response = await authController!.signIn(
        user: user!.trim(),
        password: password!.trim(),
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
}
