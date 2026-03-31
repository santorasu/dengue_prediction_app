import 'package:flutter/material.dart';

class ResultSection extends StatelessWidget {
  final String result;

  ResultSection({required this.result});

  @override
  Widget build(BuildContext context) {
    final bool isPositive = result.toLowerCase().contains('positive');
    final Color resultColor = isPositive ? Colors.red : Colors.green;
    final IconData icon = isPositive ? Icons.warning : Icons.check_circle;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: resultColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(icon, color: resultColor, size: 36),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              result,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: resultColor),
            ),
          ),
        ],
      ),
    );
  }
}
