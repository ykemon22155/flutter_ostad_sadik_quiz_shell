import 'package:flutter/material.dart';

import '../widgets/title_section.dart';
import 'add_question.dart';
import 'add_question_via_api.dart';
import 'added_questions.dart';
import 'questions_from_api.dart';

class AdminOptions extends StatelessWidget {
  const AdminOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Options")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TitleSection(label: "Quiz from API Hub", showSeeAll: false),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddQuestion())),
                    child: Text("Add Question"),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddedQuestions())),
                    child: Text("View Questions"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            TitleSection(label: "Quiz from API Hub", showSeeAll: false),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddQuestionViaApi())),
                    child: Text("Add Question"),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionsFromApi())),
                    child: Text("View Questions"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
