// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TaskStore on _TaskStore, Store {
  late final _$stateAtom = Atom(name: '_TaskStore.state', context: context);

  @override
  TaskState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(TaskState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$loadInitialTasksAsyncAction = AsyncAction(
    '_TaskStore.loadInitialTasks',
    context: context,
  );

  @override
  Future<void> loadInitialTasks() {
    return _$loadInitialTasksAsyncAction.run(() => super.loadInitialTasks());
  }

  late final _$addTaskAsyncAction = AsyncAction(
    '_TaskStore.addTask',
    context: context,
  );

  @override
  Future<void> addTask(TaskModel task) {
    return _$addTaskAsyncAction.run(() => super.addTask(task));
  }

  late final _$toggleTaskDoneAsyncAction = AsyncAction(
    '_TaskStore.toggleTaskDone',
    context: context,
  );

  @override
  Future<void> toggleTaskDone(TaskModel task) {
    return _$toggleTaskDoneAsyncAction.run(() => super.toggleTaskDone(task));
  }

  late final _$updateTaskAsyncAction = AsyncAction(
    '_TaskStore.updateTask',
    context: context,
  );

  @override
  Future<void> updateTask(TaskModel oldTask, TaskModel updatedTask) {
    return _$updateTaskAsyncAction.run(
      () => super.updateTask(oldTask, updatedTask),
    );
  }

  late final _$deleteTaskAsyncAction = AsyncAction(
    '_TaskStore.deleteTask',
    context: context,
  );

  @override
  Future<void> deleteTask(TaskModel task) {
    return _$deleteTaskAsyncAction.run(() => super.deleteTask(task));
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
