import 'package:flutter/material.dart';

extension NavigatorExtensions on BuildContext {
  Future<T?> pushView<T>(String routeName, {Object? arguments}) {
    return Navigator.pushNamed<T>(
      this,
      routeName,
      arguments: arguments,
    );
  }

  Future<T?> pushReplacementView<T, TO>(String routeName, {Object? arguments}) {
    return Navigator.pushReplacementNamed<T, TO>(
      this,
      routeName,
      arguments: arguments,
    );
  }

  Future<T?> pushAndRemoveUntilPage<T>(String routeName, {Object? arguments}) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      this,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  void popView(BuildContext context, [dynamic result]) {
    return Navigator.pop(context, result);
  }
}
