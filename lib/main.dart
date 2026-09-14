import 'package:flutter/material.dart';
import 'package:pressure_diary/app/app_bootstrap.dart';
import 'package:pressure_diary/core/db/app_database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(AppBootstrap(database: AppDatabase()));
}
