import 'package:flutter/material.dart';

class AnswerOption extends StatelessWidget {
  const AnswerOption({super.key, required this.option, required this.serial, this.isSelected = false});

  final String option;
  final String serial;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xffe2dff2) : Color(0xfff5f5f5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isSelected ? Color(0xff3e2788) : Colors.transparent, width: 2),
      ),
      child: Row(
        spacing: 16,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xff3e2788).withValues(alpha: .15),
            child: Text(
              serial,
              style: TextStyle(color: isSelected ? Color(0xff3e2788) : Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Text(option, style: TextStyle(fontSize: 16, color: isSelected ? Color(0xff3e2788) : Colors.black)),
        ],
      ),
    );
  }
}
