import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';

class TextFormFiledWidget extends StatelessWidget {
  final String label;
  final String hint;
  final bool isOptional;
  final TextEditingController controller;
  final int delay;

  const TextFormFiledWidget(
      {Key? key,
      required this.label,
      required this.hint,
      this.isOptional = false,
      required this.controller,
      this.delay = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.all(12),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: DelayedDisplay(
          delay: Duration(milliseconds: delay),
          child: TextFormField(
            controller: controller,
            obscureText: label == StringsEn.password,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: label,
                suffixText: isOptional ? StringsEn.optional : "",
                suffixStyle: TextStyle(color: RingyColors.primaryColor),
                hintText: hint),
          ),
        ),
      ),
    );
  }
}
