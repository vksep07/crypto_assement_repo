import 'package:crypto_assignment/app/app.dart';
import 'package:crypto_assignment/util/database/database_helper.dart';
import 'package:flutter/material.dart';

final dbHelper = DatabaseHelper();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize the database
  await dbHelper.init();
  runApp(const App());
}


