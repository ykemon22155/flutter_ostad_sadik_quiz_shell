import 'package:flutter/material.dart';

class RecentCard extends StatelessWidget {
  const RecentCard({super.key, required this.title, required this.gainedScore, required this.totalCorrect, required this.totalAttempt, required this.playedOn});

  final String title;
  final int gainedScore;
  final int totalCorrect;
  final int totalAttempt;
  final String playedOn;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Color(0xfff5f3fb),
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text("Played on: $playedOn"),
      leading: Container(
        height: 48,
        width: 48,
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(color: Color(0xffe8e5f6), borderRadius: BorderRadius.circular(6)),
        child: Text(gainedScore.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff2b229c)),),
      ),
      trailing: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(color: Color(0xffd9ebe0), borderRadius: BorderRadius.circular(6)),
        child: Text("$totalCorrect / $totalAttempt", style: TextStyle(color: Colors.green.shade800, fontSize: 14),),
      ),
    );
  }
}
