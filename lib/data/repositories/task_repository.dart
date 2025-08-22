import 'package:cumpri/data/database/app_database.dart';
import 'package:cumpri/data/models/task_model.dart';
import 'package:cumpri/data/repositories/i_task_repository.dart';
import 'package:drift/drift.dart';

class TaskRepository implements ITaskRepository {
  TaskRepository({required AppDatabase database}) : _database = database;

  final AppDatabase _database;

  @override
  Future<int> createTask(TaskModel task) async {
    final taskEntity = TaskTableCompanion.insert(
      title: task.title,
      description: Value(task.description),
      isDone: Value(task.isDone),
    );

    return _database.into(_database.taskTable).insert(taskEntity);
  }

  @override
  Future<int> deleteTask(int id) {
    return (_database.delete(_database.taskTable)..where((table) => table.id.equals(id))).go();
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    final rows = await _database.select(_database.taskTable).get();

    return rows
        .map(
          (row) => TaskModel(
            id: row.id,
            title: row.title,
            description: row.description,
            isDone: row.isDone,
          ),
        )
        .toList();
  }

  @override
  Future<TaskModel?> getTaskById(int id) async {
    final row = await (_database.select(_database.taskTable)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

    if (row == null) return null;
    return TaskModel(
      id: row.id,
      title: row.title,
      description: row.description,
      isDone: row.isDone,
    );
  }

  @override
  Future<bool> updateTask(TaskModel task) {
    final taskEntity = TaskTableCompanion(
      id: Value(task.id!),
      title: Value(task.title),
      description: Value(task.description),
      isDone: Value(task.isDone),
    );

    return _database.update(_database.taskTable).replace(taskEntity);
  }
}
