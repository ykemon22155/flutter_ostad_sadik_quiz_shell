import 'package:flutter/material.dart';
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
  String userImageUrl = "https://i0.wp.com/sadik.work/wp-content/uploads/2020/05/Shared-from-Lightroom-mobile-2.jpg";
  String userName = "S.a. Sadik";
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
              HomePageHeader(userName: userName, userImageUrl: userImageUrl, totalScore: totalScore),
              SizedBox(height: 16),
              BannerCard(),
              SizedBox(height: 16),
              TitleSection(label: "Subject"),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 16,
                  children: [
                    CategoryCard(title: "Math", imageFileName: "math.png"),
                    CategoryCard(title: "Chemistry", imageFileName: "chemistry.png"),
                    CategoryCard(title: "Computer", imageFileName: "computer.png"),
                    CategoryCard(title: "Biology", imageFileName: "biology.png"),
                    CategoryCard(title: "Physics", imageFileName: "computer.png"),
                  ],
                ),
              ),
              SizedBox(height: 16),
              TitleSection(label: "Recent", showSeeAll: false),
              SizedBox(height: 16),
              RecentCard(title: "Biology", questionCount: 12, isComplete: true),
              SizedBox(height: 16),
              RecentCard(title: "English", questionCount: 96, isComplete: false),
              SizedBox(height: 16),
              RecentCard(title: "Computer", questionCount: 19, isComplete: true),
            ],
          ),
        ),
      ),
    );
  }
}
