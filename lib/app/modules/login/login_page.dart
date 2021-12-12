import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payback/app/app_routing.dart';
import 'package:payback/app/modules/login/login_store.dart';
import 'package:payback/app/modules/recovery_password/recovery_password_routing.dart';
import 'package:payback/app/modules/shared/auth/auth_controller.dart';
import 'package:payback/app/modules/util/colors/colors.dart';
import 'package:payback/app/modules/util/constants/Icons_constants.dart';
import 'package:payback/app/modules/util/loading_page/loading_page_widget.dart';
import 'package:payback/app/modules/util/widgets/size_font.dart';
import 'package:payback/app/modules/util/widgets/text_field_with_validation_widget.dart';

import 'login_routing.dart';
import 'widgets/help_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.authController}) : super(key: key);

  final AuthController authController;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginStore>
    with SingleTickerProviderStateMixin {
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.authController.checkConnectivityListen();
    widget.authController
        .getUserSharedPref(stringValue: 'userValue')
        .then((value) {
      store.setLogin(value);
      loginController.text = value;
    });
    widget.authController
        .getUserSharedPref(stringValue: 'passwordValue')
        .then((value) {
      store.setPassword(value);
      senhaController.text = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: Platform.isAndroid,
        child: Stack(
          children: [
            Scaffold(
              body: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: SweetPetColors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .15,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                IconConstant.iconLogoSvg,
                                height:
                                    MediaQuery.of(context).size.height * .14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .6,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(top: 62),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          .1,
                                      right: MediaQuery.of(context).size.width *
                                          .0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Observer(
                                          builder: (_) {
                                            return TextFieldWithValidationWidget(
                                              controller: loginController,
                                              focusNode: store.focusLogin,
                                              placeholder:
                                                  FlutterI18n.translate(context,
                                                      'telaLogin.usuario'),
                                              onChanged: (newLogin) {
                                                store.setLogin(newLogin);
                                                store.loginValidate(context);
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              messageError:
                                                  store.messageLoginError,
                                              onValidator: () =>
                                                  store.loginValidate(context),
                                              onEditingComplete: () =>
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          store.focusPassword),
                                            );
                                          },
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return HelpDialog(
                                                  text: 'Insira seu email',
                                                  y: -.55,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .1,
                                                );
                                              });
                                        },
                                        icon: const Icon(Icons.help),
                                        iconSize: 20,
                                        color: SweetPetColors.orangeLight,
                                      ),
                                    ],
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * .1,
                                  right: MediaQuery.of(context).size.width * .0,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Observer(
                                            builder: (_) {
                                              return TextFieldWithValidationWidget(
                                                controller: senhaController,
                                                focusNode: store.focusPassword,
                                                placeholder:
                                                    FlutterI18n.translate(
                                                        context,
                                                        'telaLogin.senha'),
                                                onChanged: (newPassword) {
                                                  store
                                                      .setPassword(newPassword);
                                                  store.passwordValidate(
                                                      context);
                                                },
                                                textInputAction:
                                                    TextInputAction.done,
                                                messageError:
                                                    store.messagePasswordError,
                                                onValidator: () => store
                                                    .passwordValidate(context),
                                                onEditingComplete: () =>
                                                    store.autenticate(context),
                                                isPassword: true,
                                              );
                                            },
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 16,
                                              ),
                                              child: GestureDetector(
                                                child: Text(
                                                  FlutterI18n.translate(context,
                                                      'telaLogin.esqueceuSuaSenha'),
                                                  style: const TextStyle(
                                                    color: SweetPetColors
                                                        .primary800,
                                                  ),
                                                ),
                                                onTap: () {
                                                  store
                                                      .checkConnectivityPushReplacementNamed(
                                                    context: context,
                                                    rout:
                                                        RecoveryPasswordRouteNamed
                                                            .recoveryPassword
                                                            .fullPath!,
                                                    isReplacement: false,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return HelpDialog(
                                                text:
                                                    '* Minimo 8 caracteres.\n* Números de 0-9.\n* Letras maiusculas.\n* Letras minusculas.\n* Caracteres especiais: #?!@\$%^&*.%()/-',
                                                y: -.25,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .13,
                                              );
                                            });
                                      },
                                      icon: const Icon(Icons.help),
                                      iconSize: 20,
                                      color: SweetPetColors.orangeLight,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.width * .1,
                                top: MediaQuery.of(context).size.width * .0,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.width *
                                              .0,
                                      top: MediaQuery.of(context).size.width *
                                          .2,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        store.autenticate(context);
                                      },
                                      child: Container(
                                        height: 45,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: SweetPetColors
                                                  .linearGradientButton),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(50),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            FlutterI18n.translate(
                                                    context, 'telaLogin.entrar')
                                                .toUpperCase(),
                                            style: const TextStyle(
                                                color: SweetPetColors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Center(
                                    child: Text(
                                      FlutterI18n.translate(
                                          context, 'telaLogin.ou'),
                                      style: const TextStyle(
                                          color: SweetPetColors.neutralGray),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        store
                                            .checkConnectivityPushReplacementNamed(
                                                context: context,
                                                rout: AppRouteNamed
                                                    .login.fullPath!);
                                      },
                                      child: Text(
                                        FlutterI18n.translate(
                                            context, 'telaLogin.cadastrar'),
                                        style: TextStyle(
                                            color: SweetPetColors.primary800,
                                            fontSize: getValueFont(
                                                context: context,
                                                valueMin: 16)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Observer(
              builder: (_) {
                return store.isLoading
                    ? LoadingPageWidget(
                        store: store,
                      )
                    : const SizedBox();
              },
            )
          ],
        ));
  }
}
