import 'package:flutter/material.dart';

class RecentCard extends StatelessWidget {
  const RecentCard({super.key, required this.title, required this.questionCount, required this.isComplete});

  final String title;
  final int questionCount;
  final bool isComplete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Color(0xfff5f3fb),
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text("$questionCount Questions"),
      leading: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(color: Color(0xffe8e5f6), borderRadius: BorderRadius.circular(6)),
        child: Icon(Icons.label_important_outline_rounded),
      ),
      trailing: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(color: isComplete ? Color(0xffd9ebe0) : Color(0xfff3e4de), borderRadius: BorderRadius.circular(6)),
        child: Text(isComplete ? "Completed" : "Incomplete", style: TextStyle(color: isComplete ? Colors.green.shade800 : Colors.orangeAccent.shade700)),
      ),
    );
  }
}
