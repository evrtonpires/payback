import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../stores/login_store.dart';
import '../../../app_routing.dart';
import '../../util/colors/colors.dart';
import '../../util/constants/icons_constants.dart';
import '../../util/loading_page/loading_page_widget.dart';
import '../../util/widgets/size_font.dart';
import '../../util/widgets/text_field_with_validation_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, bool this.sucess = false}) : super(key: key);

  final bool sucess;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginStore>
    with SingleTickerProviderStateMixin {
  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
      mask: '##.###.###/####-##', filter: {"#": RegExp(r'[0-9]')});
  TextEditingController cnpjController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    store.loginController.appStore
        .getUserSharedPref(stringValue: 'cnpjValue')
        .then((value) {
      store.setCnpj(value);
      cnpjController.text = maskFormatter.maskText(value);
    });
    store.loginController.appStore
        .getUserSharedPref(stringValue: 'userValue')
        .then((value) {
      store.setLogin(value);
      loginController.text = value;
    });
    store.loginController.appStore
        .getUserSharedPref(stringValue: 'passwordValue')
        .then((value) {
      store.setPassword(value);
      senhaController.text = value;
    });
    if (widget.sucess) {
     store.startTimer(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: ColorsConstants.white,
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
                            IconConstant.logoColor,
                            height: MediaQuery.of(context).size.height * .2,
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
                                left: MediaQuery.of(context).size.width * .065,
                                right: MediaQuery.of(context).size.width * .065,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Observer(
                                      builder: (_) {
                                        return TextFieldWithValidationWidget(
                                          controller: cnpjController,
                                          focusNode: store.focusCnpj,
                                          textInputFormatter: maskFormatter,
                                          placeholder: FlutterI18n.translate(
                                              context, 'telaLogin.cnpj'),
                                          onChanged: (newCnpj) {
                                            store.setCnpj(maskFormatter.getUnmaskedText());
                                            store.cnpjValidate(context);
                                          },
                                          textInputAction: TextInputAction.next,
                                          textInputType: TextInputType.number,
                                          messageError: store.messageCnpjError,
                                          onValidator: () =>
                                              store.cnpjValidate(context),
                                          onEditingComplete: () =>
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      store.focusLogin),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * .065,
                                right: MediaQuery.of(context).size.width * .065,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Observer(
                                      builder: (_) {
                                        return TextFieldWithValidationWidget(
                                          controller: loginController,
                                          focusNode: store.focusLogin,
                                          placeholder: FlutterI18n.translate(
                                              context, 'telaLogin.usuario'),
                                          onChanged: (newLogin) {
                                            store.setLogin(newLogin);
                                            store.loginValidate(context);
                                          },
                                          textInputAction: TextInputAction.next,
                                          messageError: store.messageLoginError,
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
                                ],
                              )),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .065,
                              right: MediaQuery.of(context).size.width * .065,
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
                                            placeholder: FlutterI18n.translate(
                                                context, 'telaLogin.senha'),
                                            onChanged: (newPassword) {
                                              store.setPassword(newPassword);
                                              store.passwordValidate(context);
                                            },
                                            textInputAction:
                                                TextInputAction.done,
                                            messageError:
                                                store.messagePasswordError,
                                            onValidator: () =>
                                                store.passwordValidate(context),
                                            onEditingComplete: () =>
                                                FocusScope.of(context)
                                                    .nextFocus(),
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
                                                color: ColorsConstants.primary,
                                              ),
                                            ),
                                            onTap: () => store
                                                .loginController.appStore
                                                .checkConnectivityPushNamed(
                                              context: context,
                                              rout: AppRouteNamed
                                                  .recoveryPassword.fullPath!,
                                              isReplacement: false,
                                              title: FlutterI18n.translate(
                                                  context, 'global.aviso'),
                                              text: FlutterI18n.translate(
                                                  context,
                                                  'telaLogin.esqueceuSenhaSemConexao'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                      MediaQuery.of(context).size.width * .0,
                                  top: MediaQuery.of(context).size.width * .1,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    store.autenticate(
                                      context,
                                      FlutterI18n.translate(
                                          context, 'global.aviso'),
                                      FlutterI18n.translate(context,
                                          'telaLogin.entrarSemConexao'),
                                    );
                                  },
                                  child: Container(
                                    height: 45,
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors:
                                              ColorsConstants.linearGradient),
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
                                          color: ColorsConstants.white,
                                          fontWeight: FontWeight.bold,
                                        ),
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
                                      color: ColorsConstants.neutralGray),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    store.loginController.appStore
                                        .checkConnectivityPushNamed(
                                      context: context,
                                      rout: AppRouteNamed.signUp.fullPath!,
                                      isReplacement: false,
                                      title: FlutterI18n.translate(
                                          context, 'global.aviso'),
                                      text: FlutterI18n.translate(context,
                                          'telaLogin.cadastrarSemConexao'),
                                    );
                                  },
                                  child: Text(
                                    FlutterI18n.translate(
                                        context, 'telaLogin.cadastrar'),
                                    style: TextStyle(
                                      color: ColorsConstants.primary,
                                      fontSize: getValueFont(
                                        context: context,
                                        valueMin: 16,
                                      ),
                                    ),
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
    );
  }
}
