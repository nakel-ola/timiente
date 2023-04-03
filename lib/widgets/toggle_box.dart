import 'package:flutter/material.dart';

class ToggleBox extends StatelessWidget {
  final Function onPressed;
  final bool value;
  const ToggleBox({super.key, required this.onPressed, required this.value});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: AnimatedContainer(
        height: 25.0,
        width: 25.0,
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: value
              ? const Color(0xFFC00014)
              : Theme.of(context).highlightColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: value
            ? const Icon(Icons.done, color: Colors.white)
            : const SizedBox(),
      ),
    );
  }
}
