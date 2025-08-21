import 'package:cumpri/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

extension TextFieldThemeExtension on BuildContext {
  InputDecorationThemeData get textFieldTheme => theme.inputDecorationTheme;

  InputDecoration get textFieldDecoration => InputDecoration(
    contentPadding: textFieldTheme.contentPadding,
    filled: textFieldTheme.filled,
    fillColor: textFieldTheme.fillColor,
    labelStyle: textFieldTheme.labelStyle,
    floatingLabelStyle: textFieldTheme.floatingLabelStyle,
    enabledBorder: textFieldTheme.enabledBorder,
    focusedBorder: textFieldTheme.focusedBorder,
    errorBorder: textFieldTheme.errorBorder,
    focusedErrorBorder: textFieldTheme.focusedErrorBorder,
  );

  Color get textFieldFillColor => textFieldTheme.fillColor ?? Colors.transparent;
}