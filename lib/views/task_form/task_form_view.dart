// ignore_for_file: deprecated_member_use

import 'package:cumpri/core/extensions/color_extension.dart';
import 'package:cumpri/core/extensions/navigator_extension.dart';
import 'package:cumpri/core/extensions/text_extension.dart';
import 'package:cumpri/core/theme/color/app_colors.dart';
import 'package:cumpri/core/widgets/cumpri_appbar.dart';
import 'package:cumpri/core/widgets/cumpri_text_field.dart';
import 'package:cumpri/data/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:cumpri/stores/task_store.dart';

class TaskFormView extends StatefulWidget {
  final TaskStore taskStore;
  final TaskModel? task;

  const TaskFormView({
    super.key,
    required this.taskStore,
    this.task,
  });

  @override
  State<TaskFormView> createState() => _TaskFormViewState();
}

class _TaskFormViewState extends State<TaskFormView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  late final bool isEditing;

  bool _isEditing() {
    return widget.task != null;
  }

  @override
  void initState() {
    isEditing = _isEditing();
    if (isEditing && widget.task != null) {
      titleController.text = widget.task!.title;
      descriptionController.text = widget.task!.description ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

                  if (isEditing && widget.task != null) {
                    final updatedTask = widget.task!.copyWith(
                      title: title,
                      description: description.isEmpty ? null : description,
                    );
                    widget.taskStore.updateTask(widget.task!, updatedTask);
                  } else {
                    widget.taskStore.addTask(
                      TaskModel(
                        title: title,
                        description: description.isEmpty ? null : description,
                      ),
                    );
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
                        return context.primaryColor;
                      }),
                      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                        if (states.contains(WidgetState.disabled)) {
                          return AppColors.grey.withOpacity(0.38);
                        }
                        return context.onPrimaryColor;
                      }),

                      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(WidgetState.pressed)) {
                          return AppColors.lightGrey.withOpacity(0.2);
                        }
                        return null;
                      }),
                      textStyle: WidgetStatePropertyAll(context.displayLarge?.copyWith(fontSize: 20)),
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
