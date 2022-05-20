import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';

class TextFormFiledWidget extends StatelessWidget {
  final String label;
  final String hint;
  final bool isOptional;
  final bool showSuffixIcon;
  final TextEditingController controller;
  final int delay;
  final bool isEnabled;
  final Function(String ss) onTextChanged;
  final VoidCallback? closeSearch;

  const TextFormFiledWidget({
    Key? key,
    required this.label,
    required this.hint,
    this.isOptional = false,
    this.showSuffixIcon = false,
    this.closeSearch,
    required this.controller,
    required this.onTextChanged,
    this.delay = 0,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: DelayedDisplay(
          delay: Duration(milliseconds: delay),
          child: TextFormField(
            controller: controller,
            enabled: isEnabled,
            onChanged: onTextChanged,
            obscureText: label == StringsEn.password,
            decoration: InputDecoration(
                border: label == StringsEn.searchUser
                    ? const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      )
                    : const OutlineInputBorder(),
                labelText: label,
                suffixText: isOptional ? StringsEn.optional : "",
                suffixIcon: showSuffixIcon
                    ? IconButton(
                        icon: controller.text != ""
                            ? Icon(
                                Icons.close,
                                color: RingyColors.unSelectedColor,
                              )
                            : Icon(
                                Icons.search,
                                color: RingyColors.primaryColor,
                              ),
                        onPressed: closeSearch,
                      )
                    : null,
                suffixStyle: TextStyle(color: RingyColors.primaryColor),
                hintText: hint),
          ),
        ),
      ),
    );
  }
}
