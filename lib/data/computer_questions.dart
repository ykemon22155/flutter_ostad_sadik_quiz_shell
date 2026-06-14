import '../model/quiz_ques_model.dart';

List<QuizQuestion> computerQuestions = [
  QuizQuestion(
    id: 1,
    question: "What does CPU stand for?",
    options: ["Central Process Unit", "Central Processing Unit", "Computer Personal Unit", "Central Processor Universal"],
    answerIndex: 1,
  ),
  QuizQuestion(id: 2, question: "Who is known as the father of computers?", options: ["Bill Gates", "Steve Jobs", "Charles Babbage", "Alan Turing"], answerIndex: 2),
  QuizQuestion(id: 3, question: "What is the main storage device in a computer?", options: ["RAM", "ROM", "Hard Drive/SSD", "CPU"], answerIndex: 2),
  QuizQuestion(id: 4, question: "One byte consists of how many bits?", options: ["4", "8", "16", "32"], answerIndex: 1),
  QuizQuestion(id: 5, question: "Which of these is an operating system?", options: ["Python", "Windows", "Chrome", "Word"], answerIndex: 1),
  QuizQuestion(id: 6, question: "What does WWW stand for?", options: ["World Wide Web", "World Whole Web", "Wide World Web", "Web World Wide"], answerIndex: 0),
  QuizQuestion(id: 7, question: "Which company developed the Java programming language?", options: ["Microsoft", "Apple", "Sun Microsystems", "Google"], answerIndex: 2),
  QuizQuestion(id: 8, question: "What is the shortcut key for copying text?", options: ["Ctrl+V", "Ctrl+X", "Ctrl+C", "Ctrl+Z"], answerIndex: 2),
  QuizQuestion(id: 9, question: "What is the smallest unit of data in a computer?", options: ["Byte", "Nibble", "Bit", "Pixel"], answerIndex: 2),
  QuizQuestion(id: 10, question: "Which of these is an input device?", options: ["Monitor", "Printer", "Keyboard", "Speaker"], answerIndex: 2),
];
