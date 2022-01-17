import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/alert_awesome/alert_awesome_widget.dart';
import '../../util/colors/colors.dart';
import '../../util/constants/icons_constants.dart';
import '../../util/loading_page/loading_page_widget.dart';
import '../../util/no_connection/no_connection_widget.dart';
import '../../util/widgets/padding_with_observer_widget.dart';
import '../../util/widgets/size_font.dart';
import '../../util/widgets/text_field_with_validation_widget.dart';
import '../stores/recovery_password_store.dart';

class RecoveryPasswordPage extends StatefulWidget {
  const RecoveryPasswordPage({Key? key}) : super(key: key);

  @override
  RecoveryPasswordPageState createState() => RecoveryPasswordPageState();
}

class RecoveryPasswordPageState
    extends ModularState<RecoveryPasswordPage, RecoveryPasswordStore> {
  late TextEditingController emailController;

  late TextEditingController codeController;

  late TextEditingController newPasswordController;
  late TextEditingController newPasswordConfirmationController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    codeController = TextEditingController();
    newPasswordController = TextEditingController();
    newPasswordConfirmationController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    codeController.dispose();
    newPasswordController.dispose();
    newPasswordConfirmationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (store.appStore.isDeviceConnected) {
        return Stack(
          children: [
            Scaffold(
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: SweetPetColors.white,
                child: Stack(
                  children: [
                    Align(
                      alignment: const Alignment(-0.95, -0.9),
                      child: IconButton(
                        onPressed: Modular.to.pop,
                        icon: const Icon(
                          Icons.arrow_back_sharp,
                          color: SweetPetColors.primary,
                          size: 30,
                        ),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0, -0.88),
                      child: Text(
                        FlutterI18n.translate(
                            context, 'telaRecoveryPassword.recuperarSenha'),
                        style: GoogleFonts.sriracha(
                          color: SweetPetColors.primary,
                          fontSize:
                              getValueFont(context: context, valueMin: 24),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .14,
                          left: MediaQuery.of(context).size.width * .05,
                          right: MediaQuery.of(context).size.width * .05),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            PaddingWithObserverWidget(
                              child: Observer(
                                builder: (_) {
                                  return TextFieldWithValidationWidget(
                                    controller: emailController,
                                    focusNode: store.focusEmail,
                                    placeholder: FlutterI18n.translate(
                                        context, 'telaRecoveryPassword.email'),
                                    onChanged: (newEmail) {
                                      store.setEmail(newEmail);
                                      store.emailValidate(context);
                                    },
                                    textInputAction: TextInputAction.done,
                                    messageError: store.messageEmailError,
                                    onValidator: () =>
                                        store.emailValidate(context),
                                    onEditingComplete: () =>
                                        store.autenticateEmail(context),
                                    isPassword: false,
                                    isEnabled: !store.isValidate,
                                  );
                                },
                              ),
                            ),
                            Observer(builder: (_) {
                              return store.isValidate
                                  ? Column(
                                      children: [
                                        PaddingWithObserverWidget(
                                          child: Observer(
                                            builder: (_) {
                                              return TextFieldWithValidationWidget(
                                                controller:
                                                    newPasswordController,
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
                                                    TextInputAction.next,
                                                messageError:
                                                    store.messagePasswordError,
                                                onValidator: () => store
                                                    .passwordValidate(context),
                                                onEditingComplete: () => FocusScope
                                                        .of(context)
                                                    .requestFocus(store
                                                        .focusPasswordConfirmation),
                                                isPassword: true,
                                              );
                                            },
                                          ),
                                        ),
                                        PaddingWithObserverWidget(
                                          child: Observer(
                                            builder: (_) {
                                              return TextFieldWithValidationWidget(
                                                controller:
                                                    newPasswordConfirmationController,
                                                focusNode: store
                                                    .focusPasswordConfirmation,
                                                placeholder: FlutterI18n.translate(
                                                    context,
                                                    'telaRecoveryPassword.confirmacaoDeSEnha'),
                                                onChanged:
                                                    (newPasswordConfirmation) {
                                                  store.setPasswordConfirmation(
                                                      newPasswordConfirmation);
                                                  store
                                                      .passwordConfirmationValidate(
                                                          context);
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                messageError: store
                                                    .messagePasswordConfirmationError,
                                                onValidator: () => store
                                                    .passwordConfirmationValidate(
                                                        context),
                                                onEditingComplete: () => FocusScope
                                                        .of(context)
                                                    .requestFocus(store
                                                        .focusPasswordConfirmation),
                                                isPassword: true,
                                              );
                                            },
                                          ),
                                        ),
                                        PaddingWithObserverWidget(
                                          child: Observer(
                                            builder: (_) {
                                              return TextFieldWithValidationWidget(
                                                controller: codeController,
                                                focusNode: store.focusCode,
                                                placeholder: FlutterI18n.translate(
                                                    context,
                                                    'telaRecoveryPassword.codigo'),
                                                onChanged: (newCode) {
                                                  store.setCode(newCode);
                                                  store.codeValidate(context);
                                                },
                                                textInputAction:
                                                    TextInputAction.done,
                                                messageError:
                                                    store.messageCodeError,
                                                onValidator: () =>
                                                    store.codeValidate(context),
                                                onEditingComplete: () =>
                                                    FocusScope.of(context)
                                                        .nextFocus(),
                                                isPassword: false,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox();
                            }),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.width * .05,
                                top: MediaQuery.of(context).size.width * .1,
                              ),
                              child: InkWell(
                                onTap: () {
                                  if (!store.isValidate) {
                                    store.autenticateEmail(context);
                                  } else {
                                    store.autenticate(context).then((success) {
                                      if (success!) {
                                        Modular.to.pop();
                                        awesomeDialogWidget(
                                            context: context,
                                            animType: AnimType.SCALE,
                                            dialogType: DialogType.NO_HEADER,
                                            title: FlutterI18n.translate(
                                                context,
                                                'telaRecoveryPassword.infoAlteracaoDeSenha'),
                                            text: FlutterI18n.translate(context,
                                                'telaRecoveryPassword.infoSenhaAlteradaComSucesso'),
                                            borderColor: Colors.green,
                                            buttonColor: Colors.green.shade800,
                                            btnOkOnPress: () {});
                                      }
                                    });
                                  }
                                },
                                child: Container(
                                  height: 45,
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: SweetPetColors.linearGradient),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  child: Center(
                                    child: Observer(builder: (_) {
                                      return Text(
                                        !store.isValidate
                                            ? FlutterI18n.translate(context,
                                                    'telaRecoveryPassword.verificarEmail')
                                                .toUpperCase()
                                            : FlutterI18n.translate(context,
                                                    'telaRecoveryPassword.alterarSenha')
                                                .toUpperCase(),
                                        style: GoogleFonts.capriola(
                                          color: SweetPetColors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.height * .1,
                              ),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: SvgPicture.asset(
                                  IconConstant.logoColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
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
            ),
          ],
        );
      } else {
        return const NoConnectionWidget();
      }
    });
  }
}
