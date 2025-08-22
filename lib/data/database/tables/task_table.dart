import 'package:drift/drift.dart';

class TaskTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
}