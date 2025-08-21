// ignore_for_file: deprecated_member_use

import 'package:cumpri/core/extensions/color_extension.dart';
import 'package:cumpri/core/extensions/text_extension.dart';
import 'package:cumpri/core/extensions/text_field_extension.dart';
import 'package:flutter/material.dart';

class CumpriTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool isEnabled;
  final InputDecoration? decoration;
  final int? maxLines;

  const CumpriTextField({
    this.controller,
    this.hintText,
    this.isEnabled = true,
    this.decoration,
    this.maxLines = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled,
      controller: controller,
      maxLines: maxLines,
      decoration:
          decoration ??
          context.textFieldDecoration.copyWith(
            hintText: hintText,
            hintStyle: context.bodyLarge!.copyWith(
              color: context.lightGreyColor.withOpacity(0.7),
            ),
          ),
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}
