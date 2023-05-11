import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MealItemTray extends StatelessWidget {
  const MealItemTray({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: Colors.white,
          ),
        const SizedBox(width: 6,),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white
          ),
        )
      ],
    );
  }
}