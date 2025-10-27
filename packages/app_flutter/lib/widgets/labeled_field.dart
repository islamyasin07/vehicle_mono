import 'package:flutter/material.dart';

class LabeledField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const LabeledField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface.withAlpha(230),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: validator,
    );
  }
}
