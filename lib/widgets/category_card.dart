import 'package:flutter/material.dart';

import '../views/quiz_page.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.title, required this.imageFileName, this.loadFromLocalDatabase = false, this.loadFromServer = false});

  final String title;
  final String imageFileName;
  final bool loadFromLocalDatabase;
  final bool loadFromServer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizPage(category: title, loadFromLocalDatabase: loadFromLocalDatabase, loadFromServer: loadFromServer),
          ),
        ),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(color: Color(0xfffeeafe), borderRadius: BorderRadius.circular(12)),
          width: 180,
          height: 120,
          child: Stack(
            children: [
              Align(alignment: Alignment.bottomRight, child: Image.asset("asset/category/$imageFileName", height: 84)),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    title,
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
