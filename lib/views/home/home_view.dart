import 'package:cumpri/core/extensions/navigator_extension.dart';
import 'package:cumpri/core/widgets/cumpri_appbar.dart';
import 'package:cumpri/data/models/task_model.dart';
import 'package:cumpri/stores/task_store.dart';
import 'package:cumpri/views/form/task_form_view.dart';
import 'package:cumpri/views/home/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final TaskStore taskStore = TaskStore()
    ..addTask(TaskModel(title: 'Tarefa 1', description: 'Fazer tal coisa'))
    ..addTask(TaskModel(title: 'Tarefa 2', description: 'Outra coisa'));

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Scaffold(
          appBar: CumpriAppBar(
            title: 'Bem-vindo',
            subtitle: '${taskStore.tasks.length} tarefas encontradas',
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
