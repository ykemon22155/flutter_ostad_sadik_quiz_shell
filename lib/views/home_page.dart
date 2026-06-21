import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_shell/service/database_service.dart';
import 'package:quiz_shell/views/add_question.dart';
import 'package:quiz_shell/views/add_question_via_api.dart';
import 'package:quiz_shell/views/added_questions.dart';
import 'package:quiz_shell/views/questions_from_api.dart';
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
              HomePageHeader(),
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
                    CategoryCard(title: "From Local", imageFileName: "computer.png", loadFromLocalDatabase: true),
                    CategoryCard(title: "From Backend", imageFileName: "computer.png", loadFromServer: true),
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
              StreamBuilder<QuerySnapshot>(
                stream: DatabaseService().sessionHistoryStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("No Quiz Played Yet");
                  }
                  return Column(
                    children: snapshot.data!.docs.map((doc) {
                      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: RecentCard(
                          title: data['quizCategory'] ?? '--',
                          totalAttempt: data['totalAttempt'] ?? '--',
                          totalCorrect: data['totalCorrect'] ?? '--',
                          gainedScore: data['gainedScore'] ?? '--',
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
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
              SizedBox(height: 16),
              TitleSection(label: "Quiz from API Hub", showSeeAll: false),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddQuestionViaApi())),
                      child: Text("Add Question"),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionsFromApi())),
                      child: Text("View Questions"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
