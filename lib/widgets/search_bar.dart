import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final void Function(String)? onChanged;
  final String? hintText;
  final IconData? icon;
  final double? borderRadius;
  final int? minLines;
  final int? maxLines;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function(String)? onSubmitted;

  const SearchBar({
    super.key,
    this.onChanged,
    this.hintText,
    this.icon,
    this.borderRadius = 10,
    this.minLines = 1,
    this.maxLines = 1,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onSubmitted,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);


    return TextField(
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      onChanged: (text) {
        if (widget.onChanged != null) {
          setState(() {
            widget.onChanged!(text);
          });
        }
      },
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      onSubmitted: widget.onSubmitted,
      style: theme.textTheme.titleMedium?.copyWith(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.highlightColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        isDense: true,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
          borderSide: BorderSide.none,
        ),
        prefixIcon: widget.icon != null
            ? Padding(
                padding: const EdgeInsets.only(right: 2.0),
                child: Icon(widget.icon, size: 25.0),
              )
            : null,
      ),
    );
  }
}
