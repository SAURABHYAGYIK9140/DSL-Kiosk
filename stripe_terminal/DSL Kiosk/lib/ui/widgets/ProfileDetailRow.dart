import 'package:flutter/material.dart';
class ProfileDetailRow extends StatelessWidget {
  final IconData icon;
  final String detail;

  ProfileDetailRow({required this.icon, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          SizedBox(width: 10),
          Text(
            detail,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
