import 'package:flutter/material.dart';

class RecentCard extends StatelessWidget {
  const RecentCard({super.key, required this.title, required this.gainedScore, required this.totalCorrect, required this.totalAttempt});

  final String title;
  final int gainedScore;
  final int totalCorrect;
  final int totalAttempt;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Color(0xfff5f3fb),
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text("Score: $gainedScore"),
      leading: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(color: Color(0xffe8e5f6), borderRadius: BorderRadius.circular(6)),
        child: Icon(Icons.label_important_outline_rounded),
      ),
      trailing: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(color: Color(0xffd9ebe0), borderRadius: BorderRadius.circular(6)),
        child: Text("$totalCorrect / $totalAttempt", style: TextStyle(color: Colors.green.shade800, fontSize: 14),),
      ),
    );
  }
}
