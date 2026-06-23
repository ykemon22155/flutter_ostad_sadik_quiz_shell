import 'package:flutter/material.dart';

import '../model/quiz_category_model.dart';
import '../views/quiz_page.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final QuizCategory category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => QuizPage(category: category))),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(color: Color(0xfffeeafe), borderRadius: BorderRadius.circular(12)),
          width: 180,
          height: 120,
          child: Stack(
            children: [
              Positioned(
                bottom: -62,
                right: -16,
                child: Text(
                  category.name[0],
                  style: TextStyle(fontSize: 136, fontWeight: FontWeight.w100, color: Color(0xff230a94).withValues(alpha: .2)),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    category.name,
                    style: TextStyle(color: Color(0xff230a94), fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
