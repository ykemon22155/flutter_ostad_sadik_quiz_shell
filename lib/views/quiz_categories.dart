import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_shell/model/quiz_category_model.dart';

import '../widgets/category_card.dart';

class QuizCategories extends StatefulWidget {
  const QuizCategories({super.key});

  @override
  State<QuizCategories> createState() => _QuizCategoriesState();
}

class _QuizCategoriesState extends State<QuizCategories> {
  List<QuizCategory> allCategories = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadQuizCategories();
  }

  Future<void> loadQuizCategories() async {
    setState(() => isLoading = true);
    String url = "https://sadiks-quiz-apihub.lovable.app/api/v1/categories";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        List data = result["data"];
        setState(() => allCategories = data.map((item) => QuizCategory.fromJson(item)).toList());
      } else {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to load categories")));
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz Categories")),
      body: RefreshIndicator(
        onRefresh: loadQuizCategories,
        child: isLoading && allCategories.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16) + const EdgeInsets.only(bottom: 16),
                children: allCategories.map((cat) => CategoryCard(category: cat)).toList(),
              ),
      ),
    );
  }
}
