import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase {
  /// Basic
  static Box? hiveDataStorage;

  static Future<void> initialize() async {
    await Hive.initFlutter();
    hiveDataStorage = await Hive.openBox("QuizShell");
  }

  static Box get box {
    if (hiveDataStorage == null) {
      throw Exception("HiveDatabase not initialized. Call initialize() first.");
    }
    return hiveDataStorage!;
  }

  /// Get
  static List get categories => box.get('categories') ?? [];

  static List get mathQuestions => box.get('mathQuestions') ?? [];

  /// Set
  static Future<void> saveCategories(List data) async => await box.put('categories', data);

  static Future<void> saveMathQuestions(List data) async => await box.put('mathQuestions', data);
}
