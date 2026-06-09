import 'package:flutter/material.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({super.key, required this.userName, required this.userImageUrl, this.totalScore});

  final String userName;
  final String userImageUrl;
  final int? totalScore;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        //Profile Picture
        Container(
          height: 72,
          width: 72,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.pinkAccent, width: 2),
            shape: BoxShape.circle,
            image: DecorationImage(image: NetworkImage(userImageUrl)),
          ),
        ),
        //Name, Greeting
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hi, $userName", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
              Text(
                "Ready to play",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        //Points
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(color: Color(0xfff6f4fc), borderRadius: BorderRadius.circular(12)),
          child: Row(
            spacing: 10,
            children: [
              CircleAvatar(radius: 16, backgroundColor: Color(0xfff4e2fa), foregroundColor: Colors.pinkAccent, child: Icon(Icons.diamond_outlined, size: 20)),
              Text(
                totalScore == null ? "..." : totalScore.toString(),
                style: TextStyle(color: Color(0xff220c87), fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
