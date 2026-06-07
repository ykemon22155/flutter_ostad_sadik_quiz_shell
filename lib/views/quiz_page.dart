import 'package:flutter/material.dart';
import 'package:quiz_shell/model/quiz_ques_model.dart';
import 'package:quiz_shell/utils/numeric_serial_to_abc.dart';
import 'package:quiz_shell/widgets/answer_option.dart';
import 'package:quiz_shell/widgets/question_card.dart';
import 'package:quiz_shell/widgets/quiz_progress.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int? selectedAnswerIndex;
  bool answerCorrect = false;
  bool answerSubmitted = false;
  int obtainedMark = 0;
  int progress = 0;
  QuizQuestion questionData = QuizQuestion(
    id: 1,
    question: "Which 3 numbers have the same answer whether they're added or multiplied together",
    options: ["6, 3 and 4", "1, 2 and 3", "2, 4 and 6", "1, 2 and 4"],
    answerIndex: 2,
  );

  void setAnswer(int currentIndex) {
    if (selectedAnswerIndex == currentIndex) {
      selectedAnswerIndex = null;
    } else {
      selectedAnswerIndex = currentIndex;
    }
    setState(() {});
  }

  void submitAnswer() {
    //todo: selectedAnswerIndex != null
    if (selectedAnswerIndex == null) return;
    //todo: check if the selectedAnswerIndex == questionData.answerIndex
    answerCorrect = (selectedAnswerIndex == questionData.answerIndex);
    answerSubmitted = true;
    //todo: If correct, mark++
    obtainedMark = obtainedMark + questionData.mark;
    //todo: update progress
    progress++;
    setState(() {});
  }

  void prepareNextQuestion() {
    questionData = QuizQuestion(id: 1, question: "What is the National flower of Bangladesh", options: ["Rose", "Cherry Blossom", "Shapla"], answerIndex: 2);
    answerCorrect = false;
    answerSubmitted = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz Screen")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 32,
          children: [
            QuizProgress(currentProgress: progress + 1, totalCount: 5),
            QuestionCard(question: questionData.question),
            Column(
              spacing: 16,
              children: List.generate(
                questionData.options.length,
                (currentIndex) => AnswerOption(
                  option: questionData.options[currentIndex],
                  serial: numericSerialToAbc(currentIndex),
                  isSelected: selectedAnswerIndex == currentIndex,
                  onTap: answerSubmitted ? null : () => setAnswer(currentIndex),
                  showCorrectAnswer: questionData.answerIndex == currentIndex && answerSubmitted,
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            if (answerSubmitted)
              Text(
                selectedAnswerIndex == questionData.answerIndex ? "Correct Answer" : "Incorrect Answer",
                style: TextStyle(color: selectedAnswerIndex == questionData.answerIndex ? Colors.green.shade800 : Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                onPressed: answerSubmitted ? prepareNextQuestion : submitAnswer,
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xff2200a6)),
                  fixedSize: MaterialStatePropertyAll(Size(double.maxFinite, 56)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12))),
                ),
                child: Text(
                  answerSubmitted ? "Next" : "Submit",
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
