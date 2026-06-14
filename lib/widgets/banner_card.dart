import 'package:flutter/material.dart';
import 'package:quiz_shell/views/quiz_categories.dart';

class BannerCard extends StatelessWidget {
  const BannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: AssetImage("asset/card_bg.png"), fit: BoxFit.cover),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Play and Win",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            "Start a quiz now and enjoy",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white),
          ),
          SizedBox(height: 18),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => QuizCategories())),
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10))),
              padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 12)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 6,
              children: [
                Text(
                  "Get Started",
                  style: TextStyle(color: Color(0xff220c87), fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: Color(0xff220c87)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
