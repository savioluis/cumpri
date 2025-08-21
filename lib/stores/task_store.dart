import 'package:cumpri/data/models/task_model.dart';
import 'package:mobx/mobx.dart';

part 'task_store.g.dart';

class TaskStore = _TaskStore with _$TaskStore;

abstract class _TaskStore with Store {
  @observable
  ObservableList<TaskModel> tasks = ObservableList<TaskModel>();

  @action
  void addTask(TaskModel task) {
    tasks.add(task);
  }

  @action
  void toggleTaskDone(TaskModel task) {
    final index = tasks.indexOf(task);
    if (index != -1) {
      tasks[index] = task.copyWith(isDone: !task.isDone);
    }
  }

  @action
  void updateTask(TaskModel oldTask, TaskModel updatedTask) {
    final index = tasks.indexOf(oldTask);
    if (index != -1) {
      tasks[index] = updatedTask;
    }
  }

  @action
  void deleteTask(TaskModel task) {
    final index = tasks.indexOf(task);
    if (index != -1) {
      tasks.removeAt(index);
    }
  }
}
