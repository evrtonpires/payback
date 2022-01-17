import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobx/mobx.dart';

import 'modules/login/models/user_model.dart';
import 'modules/util/alert_awesome/alert_awesome_widget.dart';

part 'app_store.g.dart';

class AppStore = _AppStoreBase with _$AppStore;

abstract class _AppStoreBase with Store {
  _AppStoreBase() {
    checkConnectivityListen();
  }

  String keySTR = "4Rtv9UH56xWtAyNcS5Yr3jrPmWs26Wa6";
  String ivSTR = "anhsudrmfo29xuc8";

  @observable
  late UserModel userModel;

  @observable
  bool isDeviceConnected = false;

  @observable
  bool beforeIsDeviceConnected = true;

  StreamSubscription? streamSubscription;

  //----------------------------------------------------------------------------

  Future<void> checkConnectivityPushNamed(
      {context, required String rout, bool isReplacement = true}) async {
    var connectivityResult = await checkConnectivity();
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
  Future<void> pushNamed(
      {context, required String rout, bool isReplacement = true}) async {
    if (isReplacement) {
      Modular.to.pushReplacementNamed(rout);
    } else {
      Modular.to.pushNamed(rout);
    }
  }

//----------------------------------------------------------------------------
  Future<bool> checkConnectivity() async {
    InternetConnectionStatus connectionStatus =
        await InternetConnectionChecker().connectionStatus;

    if (connectionStatus == InternetConnectionStatus.connected) {
      ConnectivityResult result = await Connectivity().checkConnectivity();
      if (result != ConnectivityResult.none) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

//----------------------------------------------------------------------------
  void cancelConnectivityListen() {
    streamSubscription?.cancel();
  }

//----------------------------------------------------------------------------

  void checkConnectivityListen() async {
    streamSubscription =
        InternetConnectionChecker().onStatusChange.listen((event) async {
      if (event == InternetConnectionStatus.connected) {
        if (Platform.isAndroid) {
          Connectivity().onConnectivityChanged.listen((connectivity) async {
            if (connectivity != ConnectivityResult.none) {
              isDeviceConnected =
                  await InternetConnectionChecker().hasConnection;
            } else {
              isDeviceConnected = false;
              beforeIsDeviceConnected = false;
            }
          });
        } else {
          ConnectivityResult connectivityResult =
              await Connectivity().checkConnectivity();
          if (connectivityResult != ConnectivityResult.none) {
            isDeviceConnected = await InternetConnectionChecker().hasConnection;
          } else {
            isDeviceConnected = false;
            beforeIsDeviceConnected = false;
          }
        }
      } else {
        isDeviceConnected = false;
        beforeIsDeviceConnected = false;
      }
    });
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
  Future<void> saveUserSharedPrefs(
      {required stringValue, required data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('$stringValue', "$data");
  }

//----------------------------------------------------------------------------
  String encryptFunction(senha) {
    final key = encrypt.Key.fromUtf8(keySTR);
    final iv = encrypt.IV.fromUtf8(ivSTR);
    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
    final senhaEncrypted = encrypter.encrypt(senha, iv: iv);
    return senhaEncrypted.base64;
  }

//----------------------------------------------------------------------------
  String decryptFunction(senhaEncrypted) {
    final key = encrypt.Key.fromUtf8(keySTR);
    final iv = encrypt.IV.fromUtf8(ivSTR);
    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
    final decrypted = encrypter.decrypt64(senhaEncrypted, iv: iv);
    return decrypted;
  }

//----------------------------------------------------------------------------
}
