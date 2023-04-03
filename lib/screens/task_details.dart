import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../states_provider.dart';
import '../widgets/widgets.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({super.key});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    final String taskId = ModalRoute.of(context)!.settings.arguments as String;

    final Task? task = Provider.of<StateProvider>(context).findTask(taskId);

    if (task == null) return const SizedBox.shrink();

    String datetime = "${task.date} ${task.time}";

    DateTime parseDate = DateTime.parse(datetime);

    bool isChecked = task.subtasks.every((subtask) => subtask.checked == true);

    onDelete() {
      showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text(
              "Are you sure you want to delete ?",
              style: TextStyle(fontSize: 18.0),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel", style: TextStyle(fontSize: 16.0)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/", (_) => false);
                  Provider.of<StateProvider>(context, listen: false)
                      .deleteTask(taskId);
                },
                child: const Text("Ok", style: TextStyle(fontSize: 16.0)),
              ),
            ],
            contentPadding: EdgeInsets.zero,
            actionsPadding: const EdgeInsets.only(bottom: 8.0, right: 16.0),
            titlePadding: const EdgeInsets.all(16.0),
          );
        },
      );
    }

    final Size size = MediaQuery.of(context).size;

    final double width = Responsive.isDesktop(context)
        ? size.width / 3
        : Responsive.isTablet(context)
            ? size.width / 2
            : double.infinity;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Details"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () => onDelete(),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24.0),
                TitleCard(
                  title: task.title,
                  isChecked: isChecked,
                  onPressed: () {
                    Provider.of<StateProvider>(context, listen: false)
                        .checkAllSubtask(taskId, isChecked ? false : true);
                  },
                ),
                const SizedBox(height: 24.0),
                TextCard(
                  title: "Due Date",
                  description:
                      DateFormat("EEEE, d MMMM yyyy").format(parseDate),
                  icon: Icons.date_range,
                ),
                const SizedBox(height: 24.0),
                if (task.description != null)
                  TextCard(
                    title: "Description",
                    description: task.description ?? "",
                  ),
                if (task.description != null) const SizedBox(height: 24.0),
                SubtaskCard(
                  taskId: task.id,
                  subtasks: task.subtasks,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TitleCard extends StatelessWidget {
  final String title;
  final bool isChecked;
  final void Function() onPressed;
  const TitleCard({
    super.key,
    required this.title,
    required this.isChecked,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ToggleBox(
          value: isChecked,
          onPressed: onPressed,
        ),
        const SizedBox(width: 12.0),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        )
      ],
    );
  }
}

class TextCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData? icon;

  const TextCard({
    super.key,
    required this.title,
    required this.description,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            color: Theme.of(context).hintColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              description,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (icon != null) Icon(icon),
          ],
        ),
      ],
    );
  }
}
