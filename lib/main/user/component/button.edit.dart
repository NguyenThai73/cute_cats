import 'package:flutter/material.dart';

class ButtonEdit extends StatelessWidget {
  final Function() onTap;
  const ButtonEdit({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(color: const Color(0xFF6C6B6B), borderRadius: BorderRadius.circular(30)),
          child: const Center(
              child: Icon(
            Icons.edit,
            size: 13,
            color: Color(0xFFF99FB7),
          )),
        ));
  }
}
