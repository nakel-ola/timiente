import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';
import 'responsive.dart';

class TaskList extends StatelessWidget {
  final String searchText;
  final List<Task> tasks;
  const TaskList({super.key, required this.searchText, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return tasks.isNotEmpty
        ? SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isMobile(context) ? 8.0 : 0.0),
              child: Wrap(
                spacing: 8.0,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.start,
                children: tasks
                    .map(
                      (e) => _TaskTile(
                        key: ValueKey(e.id),
                        id: e.id,
                        title: e.title,
                        description: e.description ?? "",
                        subtasks: e.subtasks,
                        date: e.date,
                        time: e.time,
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        : Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset("assets/no-data-pana.png"),
                Positioned(
                  bottom: 30.0,
                  child: Text(
                    searchText.isNotEmpty
                        ? "No tasks founded "
                        : "No tasks yet!",
                    style: const TextStyle(fontSize: 24.0),
                  ),
                )
              ],
            ),
          );
  }
}

class _TaskTile extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final List<Subtask> subtasks;
  final String date;
  final String time;
  const _TaskTile({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.subtasks,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    String datetime = "$date $time";

    DateTime parseDate = DateTime.parse(datetime);

    List<Subtask> checkedTask =
        subtasks.where((subtask) => subtask.checked == true).toList();

    double progress = double.parse(
        ((checkedTask.length / subtasks.length) * 1).toStringAsFixed(1));

    int percentage = (progress * 100).round();

    final ThemeData theme = Theme.of(context);

    final double width = Responsive.isDesktop(context)
        ? 300
        : Responsive.isTablet(context)
            ? 300
            : double.infinity;

    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed("/task", arguments: id),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(fontSize: 18.0),
            ),
            const SizedBox(height: 4.0),
            Text(
              DateFormat("EEEE, d MMMM yyyy").format(parseDate),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.hintColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(child: LinearProgressIndicator(value: progress)),
                  const SizedBox(width: 24.0),
                  Text(
                    "$percentage%",
                    style: TextStyle(
                      color: theme.hintColor,
                      fontSize: 16.0,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
