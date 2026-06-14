import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({super.key, required this.label, this.showSeeAll = true});

  final String label;
  final bool showSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        if (showSeeAll)
          InkWell(
            onTap: () {},
            child: Text(
              "See All",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xff230a94)),
            ),
          ),
      ],
    );
  }
}
