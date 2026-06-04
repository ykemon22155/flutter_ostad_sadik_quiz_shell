import 'package:flutter/material.dart';
import 'package:quiz_shell/widgets/answer_option.dart';
import 'package:quiz_shell/widgets/question_card.dart';
import 'package:quiz_shell/widgets/quiz_progress.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz Screen")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 32,
          children: [
            QuizProgress(),
            QuestionCard(question: "Which 3 numbers have the same answer whether they're added or multiplied together"),
            Column(
              spacing: 16,
              children: [
                AnswerOption(serial: 'a', option: "6, 3 and 4"),
                AnswerOption(serial: 'b', option: "1, 2 and 3", isSelected: true),
                AnswerOption(serial: 'c', option: "2, 4 and 6"),
                AnswerOption(serial: 'd', option: "1, 2 and 4"),
              ],
            ),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xff2200a6)),
                  fixedSize: MaterialStatePropertyAll(Size(double.maxFinite, 56)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12))),
                ),
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
