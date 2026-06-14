import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key, required this.controller, required this.label, this.showNumberKeyboardOnly = false});

  final TextEditingController controller;
  final String label;
  final bool showNumberKeyboardOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: showNumberKeyboardOnly ? TextInputType.number :TextInputType.text,
        decoration: InputDecoration(
          label: Text(label),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
        ),
      ),
    );
  }
}
