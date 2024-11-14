import 'package:flutter/material.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class StatsColumn extends StatelessWidget {
  final String number;
  final String text;

  const StatsColumn({
    super.key,
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size18,
          ),
        ),
        Gaps.v3,
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        )
      ],
    );
  }
}
