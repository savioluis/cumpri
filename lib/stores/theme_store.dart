import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'theme_store.g.dart';

class ThemeStore = _ThemeStoreBase with _$ThemeStore;

abstract class _ThemeStoreBase with Store {
  @observable
  ThemeMode themeMode = ThemeMode.light;

  @computed
  bool get isDarkMode => themeMode == ThemeMode.dark;

  @action
  void toggleTheme() {
    themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
  }

  @action
  void setTheme(ThemeMode mode) {
    themeMode = mode;
  }
}
