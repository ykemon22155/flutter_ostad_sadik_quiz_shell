import 'package:flutter/material.dart';
import 'package:quiz_shell/data/biology_questions.dart';
import 'package:quiz_shell/data/chemistry_questions.dart';
import 'package:quiz_shell/data/computer_questions.dart';
import 'package:quiz_shell/data/math_questions.dart';
import 'package:quiz_shell/model/quiz_ques_model.dart';
import 'package:quiz_shell/utils/numeric_serial_to_abc.dart';
import 'package:quiz_shell/widgets/answer_option.dart';
import 'package:quiz_shell/widgets/question_card.dart';
import 'package:quiz_shell/widgets/quiz_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/hive_database.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.category, this.loadFromLocalDatabase = false});

  final String category;
  final bool loadFromLocalDatabase;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int? selectedAnswerIndex;
  bool answerCorrect = false;
  bool answerSubmitted = false;
  int obtainedMark = 0;
  int progress = 0;
  List<QuizQuestion> questions = [];

  void setAnswer(int currentIndex) {
    if (selectedAnswerIndex == currentIndex) {
      selectedAnswerIndex = null;
    } else {
      selectedAnswerIndex = currentIndex;
    }
    setState(() {});
  }

  Future<void> submitAnswer() async {
    if (selectedAnswerIndex == null) return;
    answerCorrect = (selectedAnswerIndex == questions[progress].answerIndex);
    answerSubmitted = true;
    if (answerCorrect) {
      obtainedMark = obtainedMark + questions[progress].mark;
      SharedPreferences pref = await SharedPreferences.getInstance();
      int currentTotalScore = pref.getInt('score') ?? 0;
      pref.setInt('score', currentTotalScore + questions[progress].mark);
    }
    setState(() {});
  }

  void prepareNextQuestion() {
    answerCorrect = false;
    answerSubmitted = false;
    selectedAnswerIndex = null;
    if (progress < questions.length) progress++;
    setState(() {});
  }

  void loadAllQuestionsOfThisCategory() {
    List<QuizQuestion> allQuestionsOfThisCategory = [];
    if (widget.loadFromLocalDatabase) {
      allQuestionsOfThisCategory = HiveDatabase.myQuestions.map((e) => QuizQuestion.fromJson(Map<String, dynamic>.from(e))).toList();
    } else {
      if (widget.category == "Math") allQuestionsOfThisCategory = mathQuestions;
      if (widget.category == "Chemistry") allQuestionsOfThisCategory = chemistryQuestions;
      if (widget.category == "Biology") allQuestionsOfThisCategory = biologyQuestions;
      if (widget.category == "Computer") allQuestionsOfThisCategory = computerQuestions;
    }
    setState(() => questions = List<QuizQuestion>.from(allQuestionsOfThisCategory)..shuffle());
  }

  @override
  void initState() {
    super.initState();
    loadAllQuestionsOfThisCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("${widget.category} Quiz"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xff2200a5)),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text("Score: $obtainedMark", style: TextStyle(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
      body: questions.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12,
                children: [
                  Icon(Icons.warning_amber_outlined, size: 110, color: Colors.redAccent),
                  Text("${widget.category} Quiz is not available right now!"),
                ],
              ),
            )
          : progress == questions.length
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 24,
                    children: [
                      Icon(Icons.emoji_events_outlined, size: 120, color: Colors.orange),
                      Text("Quiz Completed!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      Text("Your Score: $obtainedMark", style: TextStyle(fontSize: 18)),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Back to Home"),
                      ),
                    ],
                  ),
                )
              : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 32,
                children: [
                  QuizProgress(currentProgress: progress + 1, totalCount: questions.length),
                  QuestionCard(question: questions[progress].question),
                  Column(
                    spacing: 16,
                    children: List.generate(
                      questions[progress].options.length,
                      (currentIndex) => AnswerOption(
                        option: questions[progress].options[currentIndex],
                        serial: numericSerialToAbc(currentIndex),
                        isSelected: selectedAnswerIndex == currentIndex,
                        onTap: answerSubmitted ? null : () => setAnswer(currentIndex),
                        showCorrectAnswer: questions[progress].answerIndex == currentIndex && answerSubmitted,
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  if (answerSubmitted)
                    Text(
                      selectedAnswerIndex == questions[progress].answerIndex ? "Correct Answer" : "Incorrect Answer",
                      style: TextStyle(color: selectedAnswerIndex == questions[progress].answerIndex ? Colors.green.shade800 : Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
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
