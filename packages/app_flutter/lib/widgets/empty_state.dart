import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String message;
  const EmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    // Present a slightly elevated, rounded card so empty states match app styling
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Material(
          color: const Color.fromRGBO(255, 255, 255, 0.88),
          elevation: 0,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Text(message, textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
