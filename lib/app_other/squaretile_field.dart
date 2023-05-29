import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final Function()? onTap;
  final String imagePath;
  const SquareTile({super.key, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(border: Border.all(color: Color.fromARGB(255, 131, 130, 130)),
        borderRadius: BorderRadius.circular(30),
        color: Color.fromARGB(255, 253, 250, 250)),
        child: Image.asset(
          imagePath,
          height: 40,
        ),
      ),
    );
  }
}