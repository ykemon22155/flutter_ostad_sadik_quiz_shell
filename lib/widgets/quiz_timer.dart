import 'package:flutter/material.dart';

class QuizTimer extends StatefulWidget {
  const QuizTimer({super.key});

  @override
  State<QuizTimer> createState() => _QuizTimerState();
}

class _QuizTimerState extends State<QuizTimer> {
  int remainingSecond = 30;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() => remainingSecond--);
    if (remainingSecond > 0) startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 56,
          height: 56,
          child: CircularProgressIndicator(value: remainingSecond / 30, backgroundColor: Color(0xffe1deee), color: remainingSecond < 10 ? Colors.red : Color(0xff2200a5)),
        ),
        Text("00:${remainingSecond < 10 ? '0' : ''}$remainingSecond", style: TextStyle(color: remainingSecond < 10 ? Colors.red : Colors.black)),
      ],
    );
  }
}
