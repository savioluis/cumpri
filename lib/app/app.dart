import 'package:cumpri/core/theme/app_theme.dart';
import 'package:cumpri/stores/theme_store.dart';
import 'package:cumpri/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CumpriApp extends StatelessWidget {
  CumpriApp({super.key});

  final ThemeStore themeStore = ThemeStore();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cumpri',
        routes: {
          '/': (_) => HomeView(
            themeStore: themeStore,
          ),
        },
        initialRoute: '/',
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        themeMode: themeStore.themeMode,
      ),
    );
  }
}
