import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_shell/model/quiz_ques_model.dart';
import 'package:quiz_shell/service/database_service.dart';
import 'package:quiz_shell/utils/numeric_serial_to_abc.dart';
import 'package:quiz_shell/widgets/answer_option.dart';
import 'package:quiz_shell/widgets/question_card.dart';
import 'package:quiz_shell/widgets/quiz_not_available.dart';
import 'package:quiz_shell/widgets/quiz_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/quiz_category_model.dart';
import '../widgets/quiz_result.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.category});

  final QuizCategory category;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int? selectedAnswerIndex;
  bool answerCorrect = false;
  bool answerSubmitted = false;
  int obtainedMark = 0;
  int totalCorrect = 0;
  int progress = 0;
  List<QuizQuestion> questions = [];
  bool isLoading = false;
  bool isQuizOver = false;

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
      totalCorrect++;
      obtainedMark = obtainedMark + questions[progress].mark;
      SharedPreferences pref = await SharedPreferences.getInstance();
      int currentTotalScore = pref.getInt('score') ?? 0;
      pref.setInt('score', currentTotalScore + questions[progress].mark);
    }
    setState(() {});
  }

  Future<void> prepareNextQuestion() async {
    if (progress < questions.length - 1) {
      progress++;
      answerCorrect = false;
      answerSubmitted = false;
      selectedAnswerIndex = null;
      setState(() {});
    } else {
      isQuizOver = true;
      setState(() {});
      await DatabaseService().saveQuizSession(gainedScore: obtainedMark, totalAttempt: questions.length, totalCorrect: totalCorrect, category: widget.category.name);
    }
  }

  // Future<void> loadAllQuestionsOfThisCategory() async {
  //   setState(() => isLoading = true);
  //   List<QuizQuestion> allQuestionsOfThisCategory = [];
  //   if (widget.loadFromLocalDatabase) {
  //     allQuestionsOfThisCategory = HiveDatabase.myQuestions.map((e) => QuizQuestion.fromJson(Map<String, dynamic>.from(e))).toList();
  //   }
  //   if (widget.loadFromServer) {
  //     String url = "https://sadiks-quiz-apihub.lovable.app/api/v1/categories/1/questions";
  //     var response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       var result = jsonDecode(response.body);
  //       List data = result["data"];
  //       setState(() => allQuestionsOfThisCategory = data.map((item) => QuizQuestion.fromJson(item)).toList());
  //     } else {
  //       if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to load questions from server")));
  //     }
  //   } else {
  //     if (widget.category == "Math") allQuestionsOfThisCategory = mathQuestions;
  //     if (widget.category == "Chemistry") allQuestionsOfThisCategory = chemistryQuestions;
  //     if (widget.category == "Biology") allQuestionsOfThisCategory = biologyQuestions;
  //     if (widget.category == "Computer") allQuestionsOfThisCategory = computerQuestions;
  //   }
  //   setState(() => questions = (List<QuizQuestion>.from(allQuestionsOfThisCategory)..shuffle()).take(5).toList());
  //   setState(() => isLoading = false);
  // }

  Future<void> loadAllQuestionsOfThisCategory() async {
    setState(() => isLoading = true);
    List<QuizQuestion> allQuestionsOfThisCategory = [];
    String url = "https://sadiks-quiz-apihub.lovable.app/api/v1/categories/${widget.category.id}/questions";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      List data = result["data"];
      setState(() => allQuestionsOfThisCategory = data.map((item) => QuizQuestion.fromJson(item)).toList());
    } else {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to load questions from server")));
    }
    setState(() => questions = (List<QuizQuestion>.from(allQuestionsOfThisCategory)..shuffle()).take(5).toList());
    setState(() => isLoading = false);
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
        title: Text("${widget.category.name} Quiz"),
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : questions.isEmpty
          ? QuizNotAvailable(categoryName: widget.category.name)
          : isQuizOver
          ? QuizResult(totalQuestions: questions.length, totalCorrect: totalCorrect, obtainedMark: obtainedMark)
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 32,
                children: [
                  QuizProgress(currentProgress: progress + 1, totalCount: questions.length),
                  QuestionCard(question: questions[progress].question),
                  Column(
                    spacing: 12,
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
                  Column(
                    spacing: 16,
                    children: [
                      if (answerSubmitted)
                        Text(
                          selectedAnswerIndex == questions[progress].answerIndex ? "Correct Answer" : "Incorrect Answer",
                          style: TextStyle(color: selectedAnswerIndex == questions[progress].answerIndex ? Colors.green.shade800 : Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      SafeArea(
                        child: selectedAnswerIndex == null
                            ? SizedBox()
                            : answerSubmitted
                            ? ElevatedButton(
                                onPressed: prepareNextQuestion,
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(Color(0xff2200a6)),
                                  fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 56)),
                                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12))),
                                ),
                                child: Text(
                                  "Next",
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              )
                            : OutlinedButton(
                                onPressed: submitAnswer,
                                style: ButtonStyle(
                                  fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 56)),
                                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12))),
                                ),
                                child: Text("Submit", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
