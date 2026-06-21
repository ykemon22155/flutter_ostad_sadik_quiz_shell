import 'package:flutter/material.dart';

class QuizResult extends StatelessWidget {
  const QuizResult({super.key, required this.totalQuestions, required this.totalCorrect, required this.obtainedMark});
  final int totalQuestions;
  final int totalCorrect;
  final int obtainedMark;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.emoji_events, size: 100, color: Colors.amber),
          const SizedBox(height: 24),
          const Text(
            "Quiz Completed!",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text("Total Correct: $totalCorrect / $totalQuestions", style: const TextStyle(fontSize: 18)),
          Text("Score Gained: $obtainedMark", style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff2200a6),
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Back to Home", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
