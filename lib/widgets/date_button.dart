import 'package:flutter/material.dart';

class DateButton extends StatelessWidget {
  final String title;
  final String hintText;
  final IconData icon;
  final Function onTap;
  final String? value;

  const DateButton({
    super.key,
    required this.title,
    required this.hintText,
    required this.icon,
    required this.onTap,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          GestureDetector(
            onTap: () => onTap(),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 6.0),
                    child: Icon(
                      icon,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  Text(
                    value ?? hintText,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: value != null
                          ? Theme.of(context).inputDecorationTheme.focusColor
                          : Theme.of(context).hintColor,
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
