import 'package:cumpri/core/extensions/navigator_extension.dart';
import 'package:cumpri/core/utils/date_time_util.dart';
import 'package:cumpri/core/utils/dialog_util.dart';
import 'package:cumpri/core/widgets/cumpri_appbar.dart';
import 'package:cumpri/stores/task_store.dart';
import 'package:cumpri/stores/theme_store.dart';
import 'package:cumpri/views/task_form/task_form_view.dart';
import 'package:cumpri/views/home/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeView extends StatelessWidget {
  HomeView({
    required this.themeStore,
    super.key,
  });

  final ThemeStore themeStore;
  final TaskStore taskStore = TaskStore();

  final currentDay = DateTime.now().day;
  final currentMonth = DateTimeUtil.getMonthName(DateTime.now().month);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Scaffold(
          appBar: CumpriAppBar(
            title: '$currentDay de $currentMonth',
            subtitle: taskStore.tasks.isNotEmpty
                ? '${taskStore.tasks.length} tarefas encontradas'
                : 'Nenhuma tarefa encontrada',
            actionIcon: themeStore.isDarkMode ? Icon(Icons.light_mode) : Icon(Icons.dark_mode),
            onActionPressed: themeStore.toggleTheme,
          ),
          body: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
            itemCount: taskStore.tasks.length,
            separatorBuilder: (_, _) => const SizedBox(height: 24),
            itemBuilder: (context, index) {
              final task = taskStore.tasks[index];
              return TaskWidget(
                title: task.title,
                description: task.description,
                isDone: task.isDone,
                onCheckPressed: () => taskStore.toggleTaskDone(task),
                onTaskPressed: () => context.pushView(
                  (context) => TaskFormView(
                    taskStore: taskStore,
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
                    taskStore.deleteTask(task);
                    context.popView(context);
                  },
                  onCancel: () => context.popView(context),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.pushView(
                (context) => TaskFormView(
                  taskStore: taskStore,
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
