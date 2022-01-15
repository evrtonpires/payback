import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:payback/app/modules/util/colors/colors.dart';

class BasicDateField extends StatelessWidget {
  BasicDateField({Key? key, required this.onChanged, required this.controller})
      : super(key: key);

  final TextEditingController controller;
  final Function(DateTime?)? onChanged;

  final format = DateFormat("dd-MM-yyyy");

  InputDecoration get _defaultInputDecoration => InputDecoration(
        contentPadding:
            const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
        alignLabelWithHint: true,
        hintStyle: const TextStyle(color: SweetPetColors.primary),
        labelText: 'Data de Nascimento',
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
      );

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        format: format,
        controller: controller,
        onChanged: onChanged,
        decoration: _defaultInputDecoration,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
            context: context,
            firstDate: DateTime(2000),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime.now(),
          );
        },
      ),
    ]);
  }
}

class BasicTimeField extends StatelessWidget {
  final format = DateFormat("HH:mm");

  BasicTimeField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}

class BasicDateTimeField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");

  BasicDateTimeField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    ]);
  }
}
