import 'package:cumpri/data/models/task_model.dart';
import 'package:cumpri/data/repositories/i_task_repository.dart';
import 'package:mobx/mobx.dart';

part 'task_store.g.dart';

sealed class TaskState {}

class TaskLoading extends TaskState {}

class TaskSuccess extends TaskState {
  final List<TaskModel> tasks;

  TaskSuccess({required this.tasks});
}

class TaskError extends TaskState {
  final String message;

  TaskError({required this.message});
}

class TaskStore = _TaskStore with _$TaskStore;

abstract class _TaskStore with Store {
  _TaskStore({required ITaskRepository repository}) : _repository = repository;

  final ITaskRepository _repository;

  @observable
  TaskState state = TaskLoading();

  @action
  Future<void> loadInitialTasks() async {
    state = TaskLoading();

    try {
      final allTasks = await _repository.getAllTasks();
      state = TaskSuccess(tasks: allTasks);
    } catch (e) {
      state = TaskError(message: e.toString());
    }
  }

  @action
  Future<void> addTask(TaskModel task) async {
    if (state is! TaskSuccess) return;

    try {
      final id = await _repository.createTask(task);
      final newTask = task.copyWith(id: id);

      final currentTasks = List<TaskModel>.from((state as TaskSuccess).tasks)..add(newTask);

      state = TaskSuccess(tasks: currentTasks);
    } catch (e) {
      state = TaskError(message: e.toString());
    }
  }

  @action
  Future<void> toggleTaskDone(TaskModel task) async {
    if (state is! TaskSuccess) return;

    try {
      final updatedTask = task.copyWith(isDone: !task.isDone);
      await _repository.updateTask(updatedTask);

      final currentTasks = List<TaskModel>.from((state as TaskSuccess).tasks);
      final index = currentTasks.indexWhere((t) => t.id == task.id);

      if (index != -1) {
        currentTasks[index] = updatedTask;
        state = TaskSuccess(tasks: currentTasks);
      }
    } catch (e) {
      state = TaskError(message: e.toString());
    }
  }

  @action
  Future<void> updateTask(TaskModel oldTask, TaskModel updatedTask) async {
    if (state is! TaskSuccess) return;

    try {
      await _repository.updateTask(updatedTask);

      final currentTasks = List<TaskModel>.from((state as TaskSuccess).tasks);
      final index = currentTasks.indexWhere((t) => t.id == oldTask.id);

      if (index != -1) {
        currentTasks[index] = updatedTask;
        state = TaskSuccess(tasks: currentTasks);
      }
    } catch (e) {
      state = TaskError(message: e.toString());
    }
  }

  @action
  Future<void> deleteTask(TaskModel task) async {
    if (state is! TaskSuccess || task.id == null) return;

    try {
      await _repository.deleteTask(task.id!);

      final currentTasks = List<TaskModel>.from((state as TaskSuccess).tasks)..removeWhere((t) => t.id == task.id);

      state = TaskSuccess(tasks: currentTasks);
    } catch (e) {
      state = TaskError(message: e.toString());
    }
  }
}
