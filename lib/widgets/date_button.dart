import 'package:flutter/material.dart';

class DateButton extends StatelessWidget {
  final String title;
  final String hintText;
  final IconData? icon;
  final Function onTap;
  final String value;

  const DateButton({
    super.key,
    required this.title,
    required this.hintText,
    this.icon,
    required this.onTap,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Text(
              title,
              style: theme.textTheme.titleMedium,
            ),
          ),
          GestureDetector(
            onTap: () => onTap(),
            child: Container(
              padding: const EdgeInsets.only(
                bottom: 12.0,
                left: 10.0,
                right: 12.0,
                top: 12.0,
              ),
              decoration: BoxDecoration(
                color: theme.highlightColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Icon(
                      icon,
                      color: theme.hintColor,
                    ),
                  ),
                  Text(
                    value.isNotEmpty ? value : hintText,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: value.isNotEmpty
                          ? theme.inputDecorationTheme.focusColor
                          : theme.hintColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
