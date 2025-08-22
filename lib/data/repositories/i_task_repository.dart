import 'package:cumpri/data/models/task_model.dart';

abstract interface class ITaskRepository {
  Future<TaskModel?> getTaskById(int id);

  Future<List<TaskModel>> getAllTasks();

  Future<int> createTask(TaskModel task);

  Future<bool> updateTask(TaskModel task);

  Future<int> deleteTask(int id);
}
