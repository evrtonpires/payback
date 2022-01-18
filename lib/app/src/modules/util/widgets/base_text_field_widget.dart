import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:payback/app/src/modules/util/colors/colors.dart';

class BaseTextFieldWidget extends StatefulWidget {
  const BaseTextFieldWidget({
    Key? key,
    this.controller,
    this.placeholder,
    this.isPassword = false,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.textInputAction,
    this.isError = false,
    this.isEnable = true,
    this.focusNode,
    this.showCursor = true,
    this.floatingLabelBehavior,
    this.maxLength,
    this.textInputType,
    this.textInputFormatter,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? placeholder;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function(String)? onSubmitted;
  final bool isPassword;
  final bool isError;
  final bool? isEnable;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final FocusNode? focusNode;
  final bool showCursor;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextInputFormatter? textInputFormatter;

  @override
  _BaseTextFieldWidgetState createState() => _BaseTextFieldWidgetState();
}

class _BaseTextFieldWidgetState extends State<BaseTextFieldWidget> {
  Widget get _iconPasswordHidden => const Icon(
        Icons.remove_red_eye_outlined,
        semanticLabel: 'Exibir senha',
        color: SweetPetColors.primary,
      );

  Widget get _iconPasswordShowed => const Icon(
        Icons.remove_red_eye,
        semanticLabel: 'Esconder senha',
        color: SweetPetColors.primary,
      );

  bool _isObscured = false;

  Widget get _togglePasswordSuffix => GestureDetector(
        child: _isObscured ? _iconPasswordHidden : _iconPasswordShowed,
        onTap: () => setState(
          () => _isObscured = !_isObscured,
        ),
      );

  InputDecoration get _errorInputDecoration => InputDecoration(
        contentPadding: const EdgeInsets.only(
          top: 0,
          left: 10,
          right: 10,
          bottom: 0,
        ),
        alignLabelWithHint: true,
        labelText: widget.placeholder,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Theme.of(context).errorColor,
            width: .5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Theme.of(context).errorColor,
            width: .5,
          ),
        ),
        labelStyle: TextStyle(color: Theme.of(context).errorColor),
        suffixIcon: widget.isPassword ? _togglePasswordSuffix : null,
      );

  InputDecoration get _defaultInputDecoration => InputDecoration(
        contentPadding:
            const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
        alignLabelWithHint: true,
        hintStyle: const TextStyle(color: SweetPetColors.primary),
        labelText: widget.placeholder,
        labelStyle: const TextStyle(color: SweetPetColors.primary),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: SweetPetColors.primary,
            width: .5,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: SweetPetColors.primary,
            width: .5,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: SweetPetColors.primary,
            width: .5,
          ),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        floatingLabelBehavior: widget.floatingLabelBehavior,
        suffixIcon: widget.isPassword ? _togglePasswordSuffix : null,
      );

  @override
  void initState() {
    if (widget.isPassword) {
      _isObscured = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: SweetPetColors.laranjaSGS,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: SweetPetColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          obscureText: _isObscured,
          textInputAction: widget.textInputAction,
          showCursor: widget.showCursor,
          enabled: widget.isEnable,
          maxLength: widget.maxLength,
          inputFormatters: widget.textInputFormatter != null
              ? [widget.textInputFormatter!]
              : null,
          decoration:
              widget.isError ? _errorInputDecoration : _defaultInputDecoration,
          cursorColor: SweetPetColors.yellow,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onSubmitted,
          keyboardType: widget.textInputType,
        ),
      ),
    );
  }
}
