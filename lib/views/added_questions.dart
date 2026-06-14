import 'package:flutter/material.dart';
import 'package:quiz_shell/service/hive_database.dart';
import 'package:quiz_shell/widgets/question_preview.dart';

import '../model/quiz_ques_model.dart';

class AddedQuestions extends StatefulWidget {
  const AddedQuestions({super.key});

  @override
  State<AddedQuestions> createState() => _AddedQuestionsState();
}

class _AddedQuestionsState extends State<AddedQuestions> {
  List<QuizQuestion> allQuestions = [];

  @override
  void initState() {
    super.initState();
    loadAllQuestions();
  }

  void loadAllQuestions() {
    // 1. Create an empty list to hold our questions
    List<QuizQuestion> tempQuestions = [];
    // 2. Loop through each item saved in the Database
    for (var item in HiveDatabase.myQuestions) {
      // 3. Convert each item to a Map format
      Map<String, dynamic> singleQuestion = Map<String, dynamic>.from(item);
      // 4. Create a QuizQuestion object from that data
      QuizQuestion q = QuizQuestion.fromJson(singleQuestion);
      // 5. Add it to our list
      tempQuestions.add(q);
    }
    // 6. Refresh the screen with the new list
    setState(() => allQuestions = tempQuestions);

    // allQuestions = HiveDatabase.myQuestions.map((e) => QuizQuestion.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Locally Added Questions")),
      body: allQuestions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: allQuestions.length,
              itemBuilder: (context, index) => QuestionPreview(question: allQuestions[index], index: index),
            ),
    );
  }
}
