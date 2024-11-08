import 'package:flutter/material.dart';

class StfScreen extends StatefulWidget {
  const StfScreen({super.key});

  @override
  State<StfScreen> createState() => _StfScreenState();
}

class _StfScreenState extends State<StfScreen> {
  int num = 0;

  void _onTap() {
    setState(() {
      num += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$num",
            style: const TextStyle(
              fontSize: 48,
            ),
          ),
          TextButton(
            onPressed: _onTap,
            child: const Text("+"),
          ),
        ],
      ),
    );
  }
}
