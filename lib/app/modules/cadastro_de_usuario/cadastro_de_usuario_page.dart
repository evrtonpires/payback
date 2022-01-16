import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:payback/app/modules/shared/auth/auth_controller.dart';
import 'package:payback/app/modules/util/colors/colors.dart';
import 'package:payback/app/modules/util/constants/icons_constants.dart';
import 'package:payback/app/modules/util/loading_page/loading_page_widget.dart';
import 'package:payback/app/modules/util/no_connection/no_connection_widget.dart';
import 'package:payback/app/modules/util/widgets/size_font.dart';
import 'package:payback/app/modules/util/widgets/text_field_with_validation_widget.dart';

import 'cadastro_de_usuario_store.dart';
import 'widgets/padding_with_observer_widget.dart';

class CadastroDeUsuarioPage extends StatefulWidget {
  final AuthController authController;

  const CadastroDeUsuarioPage({Key? key, required this.authController})
      : super(key: key);

  @override
  CadastroDeUsuarioPageState createState() => CadastroDeUsuarioPageState();
}

class CadastroDeUsuarioPageState
    extends ModularState<CadastroDeUsuarioPage, CadastroDeUsuarioStore> {
  late TextEditingController cnpjController;

  late TextEditingController nameController;

  late TextEditingController emailController;
  late TextEditingController emailConfirmationController;

  late TextEditingController cpfController;

  late TextEditingController passwordController;
  late TextEditingController passwordControllerConfirmation;

  MaskTextInputFormatter maskFormatterCNPJ = MaskTextInputFormatter(
      mask: '##.###.###/####-##', filter: {"#": RegExp(r'[0-9]')});
  MaskTextInputFormatter maskFormatterCPF = MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    super.initState();
    cnpjController = TextEditingController();
    nameController = TextEditingController();
    emailController = TextEditingController();
    emailConfirmationController = TextEditingController();
    cpfController = TextEditingController();
    passwordController = TextEditingController();
    passwordControllerConfirmation = TextEditingController();
  }

  @override
  void dispose() {
    cnpjController.dispose();
    nameController.dispose();
    emailController.dispose();
    emailConfirmationController.dispose();
    passwordController.dispose();
    passwordControllerConfirmation.dispose();
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
                                context, 'telaCadastroUsuario.cadastro'),
                            style: GoogleFonts.sriracha(
                              color: SweetPetColors.primary,
                              fontSize:
                                  getValueFont(context: context, valueMin: 24),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .12,
                              left: MediaQuery.of(context).size.width * .065,
                              right: MediaQuery.of(context).size.width * .065),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                PaddingWithObserverWidget(
                                  child: Observer(
                                    builder: (_) {
                                      return TextFieldWithValidationWidget(
                                        controller: cnpjController,
                                        focusNode: store.focusCnpj,
                                        textInputType: TextInputType.number,
                                        textInputFormatter: maskFormatterCNPJ,
                                        placeholder: FlutterI18n.translate(
                                            context,
                                            'telaCadastroUsuario.cnpj'),
                                        onChanged: (newCnpj) {
                                          store.setCnpj(newCnpj);
                                          store.cnpjValidate(context);
                                        },
                                        textInputAction: TextInputAction.next,
                                        messageError: store.messageCnpjError,
                                        onValidator: () =>
                                            store.cnpjValidate(context),
                                        onEditingComplete: () =>
                                            FocusScope.of(context)
                                                .requestFocus(store.focusName),
                                        isPassword: false,
                                      );
                                    },
                                  ),
                                ),
                                PaddingWithObserverWidget(
                                  child: Observer(
                                    builder: (_) {
                                      return TextFieldWithValidationWidget(
                                        controller: nameController,
                                        focusNode: store.focusName,
                                        placeholder: FlutterI18n.translate(
                                            context,
                                            'telaCadastroUsuario.nome'),
                                        onChanged: (newName) {
                                          store.setName(newName);
                                          store.nameValidate(context);
                                        },
                                        textInputAction: TextInputAction.next,
                                        messageError: store.messageNameError,
                                        onValidator: () =>
                                            store.nameValidate(context),
                                        onEditingComplete: () =>
                                            FocusScope.of(context)
                                                .requestFocus(store.focusEmail),
                                        isPassword: false,
                                      );
                                    },
                                  ),
                                ),
                                PaddingWithObserverWidget(
                                  child: Observer(
                                    builder: (_) {
                                      return TextFieldWithValidationWidget(
                                        controller: emailController,
                                        focusNode: store.focusEmail,
                                        placeholder: FlutterI18n.translate(
                                            context,
                                            'telaCadastroUsuario.email'),
                                        onChanged: (newEmail) {
                                          store.setEmail(newEmail);
                                          store.emailValidate(context);
                                        },
                                        textInputAction: TextInputAction.next,
                                        messageError: store.messageEmailError,
                                        onValidator: () =>
                                            store.emailValidate(context),
                                        onEditingComplete: () =>
                                            FocusScope.of(context).requestFocus(
                                                store.focusEmailConfirmation),
                                        isPassword: false,
                                      );
                                    },
                                  ),
                                ),
                                PaddingWithObserverWidget(
                                  child: Observer(
                                    builder: (_) {
                                      return TextFieldWithValidationWidget(
                                        controller: emailConfirmationController,
                                        focusNode: store.focusEmailConfirmation,
                                        placeholder: FlutterI18n.translate(
                                            context,
                                            'telaCadastroUsuario.confirmacaoEmail'),
                                        onChanged: (newEmailConfirmation) {
                                          store.setEmailConfirmation(
                                              newEmailConfirmation);
                                          store.emailConfirmationValidate(
                                              context);
                                        },
                                        textInputAction: TextInputAction.next,
                                        messageError:
                                            store.messageEmailConfirmationError,
                                        onValidator: () => store
                                            .emailConfirmationValidate(context),
                                        onEditingComplete: () =>
                                            FocusScope.of(context)
                                                .requestFocus(store.focusCpf),
                                        isPassword: false,
                                      );
                                    },
                                  ),
                                ),
                                PaddingWithObserverWidget(
                                  child: Observer(
                                    builder: (_) {
                                      return TextFieldWithValidationWidget(
                                        controller: cpfController,
                                        focusNode: store.focusCpf,
                                        textInputType: TextInputType.number,
                                        textInputFormatter: maskFormatterCPF,
                                        placeholder: FlutterI18n.translate(
                                            context, 'telaCadastroUsuario.cpf'),
                                        onChanged: (newCpf) {
                                          store.setCpf(newCpf);
                                          store.cpfValidate(context);
                                        },
                                        textInputAction: TextInputAction.next,
                                        messageError: store.messageCpfError,
                                        onValidator: () =>
                                            store.cpfValidate(context),
                                        onEditingComplete: () =>
                                            FocusScope.of(context).requestFocus(
                                                store.focusPassword),
                                        isPassword: false,
                                      );
                                    },
                                  ),
                                ),
                                PaddingWithObserverWidget(
                                  child: Observer(
                                    builder: (_) {
                                      return TextFieldWithValidationWidget(
                                        controller: passwordController,
                                        focusNode: store.focusPassword,
                                        placeholder: FlutterI18n.translate(
                                            context,
                                            'telaCadastroUsuario.senha'),
                                        onChanged: (newPassword) {
                                          store.setPassword(newPassword);
                                          store.passwordValidate(context);
                                        },
                                        textInputAction: TextInputAction.next,
                                        messageError:
                                            store.messagePasswordError,
                                        onValidator: () =>
                                            store.passwordValidate(context),
                                        onEditingComplete: () =>
                                            FocusScope.of(context).requestFocus(
                                                store
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
                                            passwordControllerConfirmation,
                                        focusNode:
                                            store.focusPasswordConfirmation,
                                        placeholder: FlutterI18n.translate(
                                            context,
                                            'telaCadastroUsuario.confirmacaoSenha'),
                                        onChanged: (newPasswordConfirmation) {
                                          store.setPasswordConfirmation(
                                              newPasswordConfirmation);
                                          store.passwordConfirmationValidate(
                                              context);
                                        },
                                        textInputAction: TextInputAction.done,
                                        messageError: store
                                            .messagePasswordConfirmationError,
                                        onValidator: () =>
                                            store.passwordConfirmationValidate(
                                                context),
                                        onEditingComplete: () =>
                                            FocusScope.of(context).nextFocus(),
                                        isPassword: true,
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(context).size.width * .04,
                                    top: MediaQuery.of(context).size.width * .02,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      store.autenticate(context);
                                    },
                                    child: Container(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: SweetPetColors
                                                .linearGradient),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          FlutterI18n.translate(
                                              context,
                                              'telaCadastroUsuario.cadastrar').toUpperCase(),
                                          style: GoogleFonts.capriola(
                                            color: SweetPetColors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SvgPicture.asset(
                                    IconConstant.logoColor,
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
