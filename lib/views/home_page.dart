import 'package:flutter/material.dart';
import 'package:quiz_shell/views/add_question.dart';
import 'package:quiz_shell/views/added_questions.dart';
import 'package:quiz_shell/widgets/banner_card.dart';
import 'package:quiz_shell/widgets/category_card.dart';
import 'package:quiz_shell/widgets/home_page_header.dart';
import 'package:quiz_shell/widgets/recent_card.dart';
import 'package:quiz_shell/widgets/title_section.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? totalScore;

  @override
  void initState() {
    super.initState();
    getScore();
  }

  Future<void> getScore() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    totalScore = pref.getInt('score');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => await getScore(),
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              HomePageHeader(totalScore: totalScore),
              SizedBox(height: 16),
              BannerCard(),
              SizedBox(height: 32),
              TitleSection(label: "Subject"),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 12,
                  children: [
                    CategoryCard(title: "Local", imageFileName: "computer.png", loadFromLocalDatabase: true),
                    CategoryCard(title: "Math", imageFileName: "math.png"),
                    CategoryCard(title: "Chemistry", imageFileName: "chemistry.png"),
                    CategoryCard(title: "Computer", imageFileName: "computer.png"),
                    CategoryCard(title: "Biology", imageFileName: "biology.png"),
                    CategoryCard(title: "Physics", imageFileName: "computer.png"),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TitleSection(label: "Recent", showSeeAll: false),
              SizedBox(height: 16),
              RecentCard(title: "Biology", questionCount: 12, isComplete: true),
              SizedBox(height: 16),
              RecentCard(title: "English", questionCount: 96, isComplete: false),
              SizedBox(height: 16),
              RecentCard(title: "Computer", questionCount: 19, isComplete: true),
              SizedBox(height: 32),
              TitleSection(label: "Quiz from Local Storage", showSeeAll: false),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddQuestion())),
                      child: Text("Add Question"),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddedQuestions())),
                      child: Text("View Questions"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
