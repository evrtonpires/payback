import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payback/app/src/modules/util/colors/colors.dart';

import 'base_text_field_widget.dart';

class TextFieldWithValidationWidget extends StatelessWidget {
  const TextFieldWithValidationWidget({
    GlobalKey? key,
    this.controller,
    this.placeholder,
    this.isPassword = false,
    this.textInputAction,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onValidator,
    this.focusNode,
    this.messageError,
    this.isEnabled,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.maxLength,
    this.textInputType,
    this.textInputFormatter,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? placeholder;
  final Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final Function? onValidator;
  final bool isPassword;
  final bool? isEnabled;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final FocusNode? focusNode;
  final int? maxLength;
  final String? messageError;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextInputFormatter? textInputFormatter;

  bool get isError {
    return messageError != null && messageError!.isNotEmpty;
  }

  Widget _showValidation(BuildContext context) {
    if (!isError) {
      return Container();
    }
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.error_outline,
            color: ColorsConstants.white,
            size: 15,
          ),
          const SizedBox(
            width: 6,
          ),
          Expanded(
            child: Text(
              messageError!,
              textAlign: TextAlign.left,
              softWrap: true,
              style: TextStyle(
                color: Theme.of(context).errorColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseTextFieldWidget(
          controller: controller,
          focusNode: focusNode,
          isPassword: isPassword,
          isError: isError,
          placeholder: placeholder,
          textInputAction: textInputAction,
          textInputType: textInputType,
          isEnable: isEnabled,
          onChanged: onChanged,
          maxLength: maxLength,
          textInputFormatter: textInputFormatter,
          onEditingComplete: () {
            if (textInputAction == TextInputAction.next) {
              FocusScope.of(context).nextFocus();
            } else {
              FocusScope.of(context).unfocus();
            }
            onValidator?.call();
            onEditingComplete?.call();
          },
          onSubmitted: onFieldSubmitted,
          floatingLabelBehavior: floatingLabelBehavior,
        ),
        _showValidation(context),
      ],
    );
  }
}
