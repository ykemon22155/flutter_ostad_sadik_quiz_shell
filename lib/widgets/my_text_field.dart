import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.label,
    this.showNumberKeyboardOnly = false,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final bool showNumberKeyboardOnly;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: showNumberKeyboardOnly ? TextInputType.number : TextInputType.text,
      validator: validator,
      decoration: InputDecoration(
        label: Text(label),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
