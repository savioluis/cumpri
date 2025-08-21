// ignore_for_file: deprecated_member_use

import 'package:cumpri/core/extensions/navigator_extension.dart';
import 'package:cumpri/core/theme/color/app_colors.dart';
import 'package:cumpri/core/widgets/cumpri_appbar.dart';
import 'package:cumpri/core/widgets/cumpri_text_field.dart';
import 'package:cumpri/data/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:cumpri/stores/task_store.dart';

class TaskFormView extends StatelessWidget {
  final TaskStore taskStore;
  final TaskModel? task;

  TaskFormView({
    super.key,
    required this.taskStore,
    this.task,
  });

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool _isEditing() {
    return task != null;
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = _isEditing();

    if (isEditing && task != null) {
      titleController.text = task!.title;
      descriptionController.text = task!.description ?? '';
    }

    return Scaffold(
      appBar: CumpriAppBar(
        title: isEditing ? 'Editar tarefa' : 'Nova tarefa',
        onBackPressed: () => context.popView(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Título'),
            SizedBox(height: 8),
            CumpriTextField(
              controller: titleController,
              hintText: 'Título',
            ),
            const SizedBox(height: 36),
            Text('Descrição'),
            SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 156),
              child: CumpriTextField(
                controller: descriptionController,
                hintText: 'Descrição',
                maxLines: null,
              ),
            ),
            const SizedBox(height: 24),

            const Spacer(),
            SafeArea(
              bottom: true,
              child: ElevatedButton(
                onPressed: () {
                  final title = titleController.text.trim();
                  final description = descriptionController.text.trim();

                  if (title.isEmpty) return;

                  if (isEditing && task != null) {
                    final updatedTask = task!.copyWith(
                      title: title,
                      description: description.isEmpty ? null : description,
                    );
                    taskStore.updateTask(task!, updatedTask);
                  } else {
                    taskStore.addTask(TaskModel(title: title, description: description));
                  }

                  context.popView(context);
                },
                style:
                    ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      minimumSize: const Size(double.infinity, 56),
                    ).copyWith(
                      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                        if (states.contains(WidgetState.disabled)) {
                          return AppColors.grey.withOpacity(0.12);
                        }
                        return AppColors.primary;
                      }),
                      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                        if (states.contains(WidgetState.disabled)) {
                          return AppColors.grey.withOpacity(0.38);
                        }
                        return AppColors.onPrimary;
                      }),

                      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(WidgetState.pressed)) {
                          return Colors.grey.withOpacity(0.2);
                        }
                        return null;
                      }),
                    ),
                child: Text(isEditing ? 'Salvar Alterações' : 'Criar Tarefa'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
