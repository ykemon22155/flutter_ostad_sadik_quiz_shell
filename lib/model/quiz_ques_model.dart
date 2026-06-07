class QuizQuestion {
  int id;
  String question;
  List<String> options;
  int answerIndex;
  int mark;

  QuizQuestion({required this.id, required this.question, required this.options, required this.answerIndex, this.mark = 10});
}
