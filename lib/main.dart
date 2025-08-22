import 'package:cumpri/app/app.dart';
import 'package:cumpri/data/database/app_database.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase.instance();

  runApp(CumpriApp());
}
