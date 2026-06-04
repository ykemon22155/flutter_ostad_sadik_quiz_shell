import 'package:flutter/material.dart';

class QuizProgress extends StatelessWidget {
  const QuizProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Questions", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
                Row(
                  children: [
                    Text(
                      "6",
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
                    ),
                    Text("/20", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(width: 56, height: 56, child: CircularProgressIndicator(value: 0.5, backgroundColor: Color(0xffe1deee))),
                Text("00:25"),
              ],
            ),
          ],
        ),
        LinearProgressIndicator(value: 6 / 20),
      ],
    );
  }
}
