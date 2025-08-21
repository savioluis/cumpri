import 'package:flutter/material.dart';

extension NavigatorExtensions on BuildContext {
  Future<T?> pushView<T>(Widget Function(BuildContext) builder) {
    return Navigator.push<T>(
      this,
      MaterialPageRoute(builder: builder),
    );
  }

  Future<T?> pushReplacementView<T, TO>(Widget Function(BuildContext) builder) {
    return Navigator.pushReplacement<T, TO>(
      this,
      MaterialPageRoute(builder: builder),
    );
  }

  Future<T?> pushAndRemoveUntilPage<T>(Widget Function(BuildContext) builder) {
    return Navigator.pushAndRemoveUntil<T>(
      this,
      MaterialPageRoute(builder: builder),
      (route) => false,
    );
  }

  void popView(BuildContext context, [dynamic result]) {
    return Navigator.pop(context, result);
  }
}
