import 'package:cumpri/data/models/task_model.dart';
import 'package:cumpri/data/repositories/task_repository.dart';
import 'package:mobx/mobx.dart';

part 'task_store.g.dart';

class TaskStore = _TaskStore with _$TaskStore;

abstract class _TaskStore with Store {
  _TaskStore({required TaskRepository repository}) : _repository = repository {
    _observeTasks();
  }

  final TaskRepository _repository;

  void _observeTasks() async {
    final allTasks = await _repository.getAllTasks();
    tasks = ObservableList.of(allTasks);
  }

  @observable
  ObservableList<TaskModel> tasks = ObservableList<TaskModel>();

  @action
  Future<void> addTask(TaskModel task) async {
    final id = await _repository.createTask(task);
    final newTask = task.copyWith(id: id);
    tasks.add(newTask);
  }

  @action
  Future<void> toggleTaskDone(TaskModel task) async {
    final updatedTask = task.copyWith(isDone: !task.isDone);
    await _repository.updateTask(updatedTask);

    final index = tasks.indexOf(task);
    if (index != -1) {
      tasks[index] = updatedTask;
    }
  }

  @action
  Future<void> updateTask(TaskModel oldTask, TaskModel updatedTask) async {
    await _repository.updateTask(updatedTask);

    final index = tasks.indexOf(oldTask);
    if (index != -1) {
      tasks[index] = updatedTask;
    }
  }

  @action
  Future<void> deleteTask(TaskModel task) async {
    if (task.id == null) return;

    await _repository.deleteTask(task.id!);
    tasks.remove(task);
  }
}
