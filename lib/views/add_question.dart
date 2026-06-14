import 'package:flutter/material.dart';
import 'package:quiz_shell/service/hive_database.dart';
import 'package:quiz_shell/widgets/my_text_field.dart';

import '../widgets/title_section.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({super.key});

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  TextEditingController questionTitleController = TextEditingController();
  TextEditingController optionAController = TextEditingController();
  TextEditingController optionBController = TextEditingController();
  TextEditingController optionCController = TextEditingController();
  TextEditingController optionDController = TextEditingController();
  TextEditingController markController = TextEditingController();
  int? currentAnswerIndex;

  Future<void> addQuestion() async {
    Map<String, dynamic> questionAsJson = {
      "id": DateTime.now().millisecondsSinceEpoch,
      "question": questionTitleController.text,
      "options": [optionAController.text, optionBController.text, optionCController.text, optionDController.text],
      "answerIndex": currentAnswerIndex,
      "mark": int.parse(markController.text),
    };
    await HiveDatabase.addQuestion(questionAsJson);
    resetForm();
    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Success"),
        content: const Text("Question saved successfully."),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
      ),
    );
  }

  void resetForm() {
    questionTitleController.clear();
    optionAController.clear();
    optionBController.clear();
    optionCController.clear();
    optionDController.clear();
    markController.clear();
    currentAnswerIndex = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Question")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Question
          MyTextField(controller: questionTitleController, label: "Question Title"),
          Container(
            padding: EdgeInsets.all(16) - EdgeInsets.only(bottom: 16) + EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.black26),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                MyTextField(controller: optionAController, label: "Answer Option A"),
                MyTextField(controller: optionBController, label: "Answer Option B"),
                MyTextField(controller: optionCController, label: "Answer Option C"),
                MyTextField(controller: optionDController, label: "Answer Option D"),
              ],
            ),
          ),
          SizedBox(height: 16),
          TitleSection(label: "Correct Answer", showSeeAll: false),
          Row(
            children: [
              Expanded(
                child: RadioListTile<int?>(dense: true, value: 0, title: Text("A"), groupValue: currentAnswerIndex, onChanged: (value) => setState(() => currentAnswerIndex = value)),
              ),
              Expanded(
                child: RadioListTile<int?>(dense: true, value: 1, title: Text("B"), groupValue: currentAnswerIndex, onChanged: (value) => setState(() => currentAnswerIndex = value)),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile<int?>(dense: true, value: 2, title: Text("C"), groupValue: currentAnswerIndex, onChanged: (value) => setState(() => currentAnswerIndex = value)),
              ),
              Expanded(
                child: RadioListTile<int?>(dense: true, value: 3, title: Text("D"), groupValue: currentAnswerIndex, onChanged: (value) => setState(() => currentAnswerIndex = value)),
              ),
            ],
          ),
          SizedBox(height: 16),
          MyTextField(controller: markController, label: "Total Mark", showNumberKeyboardOnly: true),
          SizedBox(height: 16),
          ElevatedButton(onPressed: addQuestion, child: Text("Submit")),
        ],
      ),
    );
  }
}
