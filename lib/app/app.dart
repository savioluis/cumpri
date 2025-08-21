import 'package:cumpri/core/theme/app_theme.dart';
import 'package:cumpri/views/home/home_view.dart';
import 'package:flutter/material.dart';

class CumpriApp extends StatelessWidget {
  const CumpriApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cumpri',
      routes: {
        '/': (_) => HomeView(),
      },
      initialRoute: '/',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.dark,
    );
  }
}
