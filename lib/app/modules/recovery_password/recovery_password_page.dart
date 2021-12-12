import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payback/app/modules/cadastro_de_usuario/widgets/padding_with_observer_widget.dart';
import 'package:payback/app/modules/shared/auth/auth_controller.dart';
import 'package:payback/app/modules/util/alert_awesome/alert_awesome_widget.dart';
import 'package:payback/app/modules/util/colors/colors.dart';
import 'package:payback/app/modules/util/constants/Icons_constants.dart';
import 'package:payback/app/modules/util/loading_page/loading_page_widget.dart';
import 'package:payback/app/modules/util/no_connection/no_connection_widget.dart';
import 'package:payback/app/modules/util/widgets/size_font.dart';
import 'package:payback/app/modules/util/widgets/text_field_with_validation_widget.dart';

import 'recovery_password_store.dart';

class RecoveryPasswordPage extends StatefulWidget {
  const RecoveryPasswordPage(
      {Key? key, required this.authController, required this.store})
      : super(key: key);

  final AuthController authController;
  final RecoveryPasswordStore store;

  @override
  RecoveryPasswordPageState createState() => RecoveryPasswordPageState();
}

class RecoveryPasswordPageState extends State<RecoveryPasswordPage> {
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
      if (widget.authController.isEnableConnecticonnectivity) {
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
                            onPressed: () {
                              Modular.to.pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back_sharp,
                              color: SweetPetColors.primary800,
                              size: 30,
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0, -0.88),
                          child: Text(
                            'Cadastro',
                            style: GoogleFonts.sriracha(
                              color: SweetPetColors.primary800,
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
                                        focusNode: widget.store.focusEmail,
                                        placeholder: 'Email',
                                        onChanged: (newEmail) {
                                          widget.store.setEmail(newEmail);
                                          widget.store.emailValidate(context);
                                        },
                                        textInputAction: TextInputAction.done,
                                        messageError:
                                            widget.store.messageEmailError,
                                        onValidator: () =>
                                            widget.store.emailValidate(context),
                                        onEditingComplete: () => widget.store
                                            .autenticateEmail(context),
                                        isPassword: false,
                                        isEnabled: !widget.store.isValidate,
                                      );
                                    },
                                  ),
                                ),
                                Observer(builder: (_) {
                                  return widget.store.isValidate
                                      ? Column(
                                          children: [
                                            PaddingWithObserverWidget(
                                              child: Observer(
                                                builder: (_) {
                                                  return TextFieldWithValidationWidget(
                                                    controller:
                                                        newPasswordController,
                                                    focusNode: widget
                                                        .store.focusPassword,
                                                    placeholder: 'Senha',
                                                    onChanged: (newPassword) {
                                                      widget.store.setPassword(
                                                          newPassword);
                                                      widget.store
                                                          .passwordValidate(
                                                              context);
                                                    },
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    messageError: widget.store
                                                        .messagePasswordError,
                                                    onValidator: () => widget
                                                        .store
                                                        .passwordValidate(
                                                            context),
                                                    onEditingComplete: () =>
                                                        FocusScope.of(context)
                                                            .requestFocus(widget
                                                                .store
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
                                                    focusNode: widget.store
                                                        .focusPasswordConfirmation,
                                                    placeholder:
                                                        'Confirmacao de Senha',
                                                    onChanged:
                                                        (newPasswordConfirmation) {
                                                      widget.store
                                                          .setPasswordConfirmation(
                                                              newPasswordConfirmation);
                                                      widget.store
                                                          .passwordConfirmationValidate(
                                                              context);
                                                    },
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    messageError: widget.store
                                                        .messagePasswordConfirmationError,
                                                    onValidator: () => widget
                                                        .store
                                                        .passwordConfirmationValidate(
                                                            context),
                                                    onEditingComplete: () =>
                                                        FocusScope.of(context)
                                                            .requestFocus(widget
                                                                .store
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
                                                    focusNode:
                                                        widget.store.focusCode,
                                                    placeholder: 'Código',
                                                    onChanged: (newCode) {
                                                      widget.store
                                                          .setCode(newCode);
                                                      widget.store.codeValidate(
                                                          context);
                                                    },
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    messageError: widget
                                                        .store.messageCodeError,
                                                    onValidator: () => widget
                                                        .store
                                                        .codeValidate(context),
                                                    onEditingComplete: () =>
                                                        widget.store
                                                            .autenticate(
                                                                context)
                                                            .then((success) {
                                                      if (success!) {
                                                        Modular.to.pop();
                                                        awesomeDialogWidget(
                                                            context: context,
                                                            animType:
                                                                AnimType.SCALE,
                                                            dialogType:
                                                                DialogType
                                                                    .NO_HEADER,
                                                            title:
                                                                'Alteração de senha',
                                                            text:
                                                                'Sua senha foi alterada com sucesso!',
                                                            borderColor:
                                                                Colors.green,
                                                            buttonColor: Colors
                                                                .green.shade800,
                                                            btnOkOnPress:
                                                                () {});
                                                      }
                                                    }),
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
                                    bottom:
                                        MediaQuery.of(context).size.width * .05,
                                    top: MediaQuery.of(context).size.width * .1,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      if (!widget.store.isValidate) {
                                        widget.store.autenticateEmail(context);
                                      } else {
                                        widget.store
                                            .autenticate(context)
                                            .then((success) {
                                          if (success!) {
                                            Modular.to.pop();
                                            awesomeDialogWidget(
                                                context: context,
                                                animType: AnimType.SCALE,
                                                dialogType:
                                                    DialogType.NO_HEADER,
                                                title: 'Alteração de senha',
                                                text:
                                                    'Sua senha foi alterada com sucesso!',
                                                borderColor: Colors.green,
                                                buttonColor:
                                                    Colors.green.shade800,
                                                btnOkOnPress: () {});
                                          }
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width /
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
                                        child: Observer(builder: (_) {
                                          return Text(
                                            !widget.store.isValidate
                                                ? 'Verificar Email'
                                                    .toUpperCase()
                                                : 'Alterar Senha'.toUpperCase(),
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
                                    bottom:
                                        MediaQuery.of(context).size.height * .1,
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SvgPicture.asset(
                                      IconConstant.iconLogoTextSvg,
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
                    return widget.store.isLoading
                        ? LoadingPageWidget(
                            store: widget.store,
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
