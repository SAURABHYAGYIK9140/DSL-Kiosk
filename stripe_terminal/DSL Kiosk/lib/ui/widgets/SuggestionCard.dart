import 'package:flutter/material.dart';
class SuggestionCard extends StatelessWidget {
  final String title;
  final IconData icon;

  SuggestionCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[200],
          child: Icon(icon, size: 30, color: Colors.black),
        ),
        SizedBox(height: 8),
        Text(title, style: TextStyle(color: Colors.black)),
      ],
    );
  }
}