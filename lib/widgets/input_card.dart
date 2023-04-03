import 'package:flutter/material.dart';

import 'search_bar.dart';

class InputCard extends StatefulWidget {
  final String title;
  final void Function(String)? onChanged;
  final String hintText;
  final int? minLines;
  final int? maxLines;
  final IconData? icon;
  final TextInputType? keyboardType;

  const InputCard({
    super.key,
    required this.title,
    this.onChanged,
    required this.hintText,
    this.minLines = 1,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  State<InputCard> createState() => _InputCardState();
}

class _InputCardState extends State<InputCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          SearchBar(
            hintText: widget.hintText,
            onChanged: widget.onChanged,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            icon: widget.icon,
            keyboardType: widget.keyboardType,
          ),
        ],
      ),
    );
  }
}
