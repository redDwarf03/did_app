import 'package:flutter/material.dart';

/// Widget displaying a simple statistic with icon, count, and label.
class StatsItem extends StatelessWidget {
  const StatsItem({
    required this.icon,
    required this.count,
    required this.label,
    super.key,
  });

  final IconData icon;
  final String count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 28),
        const SizedBox(height: 8),
        Text(
          count,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
