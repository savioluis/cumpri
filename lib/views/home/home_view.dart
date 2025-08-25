import 'dart:developer';

import 'package:cumpri/core/extensions/color_extension.dart';
import 'package:cumpri/core/extensions/navigator_extension.dart';
import 'package:cumpri/core/extensions/text_extension.dart';
import 'package:cumpri/core/utils/date_time_util.dart';
import 'package:cumpri/core/utils/dialog_util.dart';
import 'package:cumpri/core/widgets/cumpri_appbar.dart';
import 'package:cumpri/stores/task_store.dart';
import 'package:cumpri/stores/theme_store.dart';
import 'package:cumpri/views/task_form/task_form_view.dart';
import 'package:cumpri/views/home/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    required this.themeStore,
    required this.taskStore,
    super.key,
  });

  final ThemeStore themeStore;
  final TaskStore taskStore;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final currentDay = DateTime.now().day;
  final currentMonth = DateTimeUtil.getMonthName(DateTime.now().month);

  PreferredSize? appBar;
  Widget? floatingActionButton;
  Widget? body;

  @override
  void initState() {
    widget.taskStore.loadInitialTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final state = widget.taskStore.state;
        log('current state: $state');

        if (state is TaskLoading) {
          appBar = CumpriAppBar(
            title: '$currentDay de $currentMonth',
            actionIcon: widget.themeStore.isDarkMode ? const Icon(Icons.light_mode) : const Icon(Icons.dark_mode),
            onActionPressed: widget.themeStore.toggleTheme,
            subtitle: 'Encontrando tarefas...',
          );

          body = const Center(child: CircularProgressIndicator());
        }

        if (state is TaskError) {
          body = Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12,
              children: [
                Text(
                  'Falha ao carregar os dados: ${state.message}',
                  style: context.displaySmall,
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await widget.taskStore.loadInitialTasks();
                  },
                  child: const Text('Tentar novamente'),
                ),
              ],
            ),
          );
        }

        if (state is TaskSuccess) {
          final tasks = state.tasks;

          appBar = CumpriAppBar(
            title: '$currentDay de $currentMonth',
            subtitle: tasks.isNotEmpty
                ? tasks.length > 1
                      ? '${tasks.length} tarefas encontradas'
                      : '1 tarefa encontrada'
                : null,
            actionIcon: widget.themeStore.isDarkMode ? const Icon(Icons.light_mode) : const Icon(Icons.dark_mode),
            onActionPressed: widget.themeStore.toggleTheme,
          );

          floatingActionButton = tasks.isNotEmpty
              ? FloatingActionButton(
                  onPressed: () {
                    context.pushView(
                      (context) => TaskFormView(
                        taskStore: widget.taskStore,
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                )
              : null;

          body = RefreshIndicator(
            backgroundColor: context.surfaceColor,
            color: context.onSurfaceColor,
            onRefresh: () async => await widget.taskStore.loadInitialTasks(),
            child: tasks.isNotEmpty
                ? ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
                    itemCount: tasks.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 24),
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return TaskWidget(
                        title: task.title,
                        description: task.description,
                        isDone: task.isDone,
                        onCheckPressed: () => widget.taskStore.toggleTaskDone(task),
                        onTaskPressed: () => context.pushView(
                          (context) => TaskFormView(
                            taskStore: widget.taskStore,
                            task: task,
                          ),
                        ),
                        onTaskLongPressed: () => DialogUtil.showAlert(
                          context: context,
                          message: 'Deseja mesmo apagar essa atividade e todos os seus dados ?',
                          title: 'Aviso',
                          confirmLabel: 'Apagar',
                          cancelLabel: 'Cancelar',
                          onConfirm: () {
                            widget.taskStore.deleteTask(task);
                            context.popView(context);
                          },
                          onCancel: () => context.popView(context),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        bottom: kToolbarHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          Text(
                            'Nada por aqui...',
                            style: context.headlineLarge?.copyWith(
                              fontSize: 32,
                              color: context.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          FilledButton.icon(
                            onPressed: () {
                              context.pushView(
                                (context) => TaskFormView(
                                  taskStore: widget.taskStore,
                                ),
                              );
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('Nova Tarefa'),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        }

        return Scaffold(
          appBar: appBar,
          body: body,
          floatingActionButton: floatingActionButton,
        );
      },
    );
  }
}
