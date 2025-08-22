import 'dart:io';

import 'package:cumpri/data/database/tables/task_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [TaskTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase._([QueryExecutor? executor]) : super(executor ?? _openConnection());

  static AppDatabase? _instance;

  factory AppDatabase.instance() {
    _instance ??= AppDatabase._();
    return _instance!;
  }

  static LazyDatabase _openConnection() {
    return LazyDatabase(
      () async {
        final dbFolder = await getApplicationSupportDirectory();

        final file = File(path.join(dbFolder.path, 'cumpri.sqlite'));

        return NativeDatabase.createInBackground(file);
      },
    );
  }

  @override
  int get schemaVersion => 1;
}
