import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart' as Encrypt;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:payback/app/modules/shared/models/user/user_model.dart';
import 'package:payback/app/modules/util/alert_awesome/alert_awesome_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_repositories/auth_repository_interface.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthController with _$AuthController;

abstract class _AuthController with Store {
  final LENGHT_VETOR = 16;

  String keySTR = "4Rtv9UH56xWtAyNcS5Yr3jrPmWs26Wa6";
  String ivSTR = "anhsudrmfo29xuc8";

  String? token;

  final IAuthRepository _authRepository = Modular.get();

  @observable
  bool isEnableConnecticonnectivity = true;

  //----------------------------------------------------------------------------
  @action
  void checkConnectivityListen() {
    Connectivity().onConnectivityChanged.listen((connectivity) {
      if (connectivity == ConnectivityResult.wifi ||
          connectivity == ConnectivityResult.mobile) {
        isEnableConnecticonnectivity = true;
      } else {
        isEnableConnecticonnectivity = false;
      }
    });
  }

  //----------------------------------------------------------------------------
  @observable
  UserModel? userModel = UserModel.padrao();

  Future<bool?> signIn({
    required String user,
    required String password,
    required context,
  }) async {
    try {
      var connectivityResult = await checkConnectivity();

      if (connectivityResult) {
        password = encrypt(password);
        userModel = await _authRepository.getLogin(
            user: user,
            password: password,
            context: context,
            authController: Modular.get());
        if (userModel != null) {
          saveUserSharedPrefs(stringValue: 'userValue', data: user);
          saveUserSharedPrefs(
              stringValue: 'passwordValue', data: decrypt(password));
          return true;
        } else {
          return false;
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
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  //----------------------------------------------------------------------------
  Future<bool?> signUp({
    required UserModel user,
    required context,
  }) async {
    try {
      var connectivityResult = await checkConnectivity();

      if (connectivityResult) {
        user.password = encrypt(user.password);
        userModel = await _authRepository.getSignUp(
            userModel: user, authController: Modular.get(), context: context);
        if (userModel != null) {
          saveUserSharedPrefs(stringValue: 'userValue', data: userModel!.email);
          saveUserSharedPrefs(
              stringValue: 'passwordValue', data: decrypt(userModel!.password));
          return true;
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

          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

//----------------------------------------------------------------------------
  Future<bool?> recoveryPasswordValidadeEmail({
    required String email,
    required context,
  }) async {
    try {
      var connectivityResult = await checkConnectivity();
      if (connectivityResult) {
        final validate = await _authRepository.getRecoverPasswordValidadeEmail(
            email: email, context: context);
        if (validate) {
          return true;
        }
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//----------------------------------------------------------------------------
  Future<bool> recoveryPassword({
    required String password,
    required String passwordConfirmation,
    required String code,
    required String email,
    required context,
  }) async {
    try {
      var connectivityResult = await checkConnectivity();
      if (connectivityResult) {
        final success = await _authRepository.getRecoveryPassword(
          context: context,
          password: password,
          passwordConfirmation: passwordConfirmation,
          code: code,
        );
        if (success) {
          UserModel user = UserModel.padrao();
          user.email = email;
          userModel = user;

          if (userModel != null) {
            userModel!.password = encrypt(password);
            saveUserSharedPrefs(
                stringValue: 'passwordValue',
                data: decrypt(userModel!.password));
          }
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//----------------------------------------------------------------------------
  Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

//----------------------------------------------------------------------------
  Future<String> getUserSharedPref({required stringValue}) async {
    final prefs = await SharedPreferences.getInstance();
    final userValue = prefs.getString('$stringValue');
    if (userValue == null) {
      return '';
    }
    return userValue;
  }

//----------------------------------------------------------------------------
  saveUserSharedPrefs({required stringValue, required data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('$stringValue', "$data");
  }

//----------------------------------------------------------------------------
  String encrypt(senha) {
    final key = Encrypt.Key.fromUtf8(keySTR);
    final iv = Encrypt.IV.fromUtf8(ivSTR);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
    final senhaEncrypted = encrypter.encrypt(senha, iv: iv);
    return senhaEncrypted.base64;
  }

//----------------------------------------------------------------------------
  String decrypt(senhaEncrypted) {
    final key = Encrypt.Key.fromUtf8(keySTR);
    final iv = Encrypt.IV.fromUtf8(ivSTR);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
    final decrypted = encrypter.decrypt64(senhaEncrypted, iv: iv);
    return decrypted;
  }

//----------------------------------------------------------------------------

  signOut() {}
}
