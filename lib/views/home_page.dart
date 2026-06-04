import 'package:flutter/material.dart';
import 'package:quiz_shell/widgets/banner_card.dart';
import 'package:quiz_shell/widgets/category_card.dart';
import 'package:quiz_shell/widgets/home_page_header.dart';
import 'package:quiz_shell/widgets/recent_card.dart';
import 'package:quiz_shell/widgets/title_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userImageUrl = "https://i0.wp.com/sadik.work/wp-content/uploads/2020/05/Shared-from-Lightroom-mobile-2.jpg";
  String userName = "S.a. Sadik";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            children: [
              HomePageHeader(userName: userName, userImageUrl: userImageUrl),
              BannerCard(),
              TitleSection(label: "Subject"),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 16,
                  children: [
                    CategoryCard(title: "Math", imageFileName: "math.png"),
                    CategoryCard(title: "Chemistry", imageFileName: "chemistry.png"),
                    CategoryCard(title: "Computer", imageFileName: "computer.png"),
                    CategoryCard(title: "Biology", imageFileName: "biology.png"),
                  ],
                ),
              ),
              TitleSection(label: "Recent", showSeeAll: false),
              RecentCard(title: "Biology", questionCount: 12, isComplete: true),
              RecentCard(title: "English", questionCount: 96, isComplete: false),
              RecentCard(title: "Computer", questionCount: 19, isComplete: true),
            ],
          ),
        ),
      ),
    );
  }
}
