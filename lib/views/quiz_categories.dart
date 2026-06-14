import 'package:flutter/material.dart';

import '../widgets/category_card.dart';

class QuizCategories extends StatelessWidget {
  const QuizCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz Categories"),),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16) + EdgeInsets.only(bottom: 16),
        children: [
          CategoryCard(title: "Local", imageFileName: "computer.png", loadFromLocalDatabase: true),
          CategoryCard(title: "Math", imageFileName: "math.png"),
          CategoryCard(title: "Chemistry", imageFileName: "chemistry.png"),
          CategoryCard(title: "Computer", imageFileName: "computer.png"),
          CategoryCard(title: "Biology", imageFileName: "biology.png"),
          CategoryCard(title: "Physics", imageFileName: "computer.png"),
        ],
      ),
    );
  }
}
