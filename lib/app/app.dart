import 'package:cumpri/core/theme/app_theme.dart';
import 'package:cumpri/data/database/app_database.dart';
import 'package:cumpri/data/models/task_model.dart';
import 'package:cumpri/data/repositories/task_repository.dart';
import 'package:cumpri/stores/task_store.dart';
import 'package:cumpri/stores/theme_store.dart';
import 'package:cumpri/views/home/home_view.dart';
import 'package:cumpri/views/task_form/task_form_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CumpriApp extends StatelessWidget {
  CumpriApp({super.key});

  final ThemeStore themeStore = ThemeStore();
  final TaskStore taskStore = TaskStore(
    repository: TaskRepository(
      database: AppDatabase.instance(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cumpri',
        routes: {
          '/': (_) => HomeView(
            themeStore: themeStore,
            taskStore: taskStore,
          ),
          '/task_form': (context) {
            final args = ModalRoute.of(context)!.settings.arguments;
            final task = args is TaskModel ? args : null;

            return TaskFormView(
              taskStore: taskStore,
              task: task,
            );
          },
        },
        initialRoute: '/',
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        themeMode: themeStore.themeMode,
      ),
    );
  }
}
