import 'package:flutter/material.dart';
import 'package:quiz_shell/service/hive_database.dart';

import 'views/home_page.dart';

Future<void> main() async {
  await HiveDatabase.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, title: 'Quiz Shell', home: const HomePage());
  }
}
