import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/models.dart';
import '../states_provider.dart';
import '../widgets/widgets.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  String title = "";
  String description = "";
  List<Subtask> subtasks = [];
  String? date;
  String? time;

  _onCreate() {
    Task task = Task(
      id: const Uuid().v4(),
      title: title,
      description: description,
      subtasks: subtasks,
      date: date!,
      time: time!,
    );

    Provider.of<StateProvider>(context, listen: false).createTask(task);
    Navigator.of(context).pop();
  }

  bool disabled() {
    if (title.isNotEmpty &&
        subtasks.isNotEmpty &&
        date != null &&
        time != null) {
      return false;
    }

    return true;
  }

  String formatInt(int value) {
    return value > 9 ? "$value" : "0$value";
  }

  String formatTime(TimeOfDay time) {
    return "${formatInt(time.hour)}:${formatInt(time.minute)}";
  }

  String formatDate(DateTime date) {
    return "${date.year}-${formatInt(date.month)}-${formatInt(date.day)}";
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final double width = Responsive.isDesktop(context)
        ? size.width / 3
        : Responsive.isTablet(context)
            ? size.width / 2
            : double.infinity;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create new task"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                InputCard(
                  title: "Title Task",
                  hintText: "Add Task name...",
                  onChanged: (text) {
                    setState(() {
                      title = text;
                    });
                  },
                ),
                InputCard(
                  title: "Description",
                  hintText: "Add descriptions...",
                  minLines: 4,
                  maxLines: 10,
                  onChanged: (text) {
                    setState(() {
                      description = text;
                    });
                  },
                ),
                CreateSubtask(
                  onCreate: (items) {
                    setState(() {
                      subtasks = items;
                    });
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: DateButton(
                        hintText: "dd/mm/yy",
                        value: date,
                        icon: Icons.date_range,
                        title: "Date",
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse("2050-12-31"),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              date = formatDate(pickedDate);
                            });
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: DateButton(
                        hintText: "hh : mm",
                        icon: Icons.schedule,
                        value: time,
                        title: "Time",
                        onTap: () async {
                          final pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              time = formatTime(pickedTime);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                ButtonsCard(
                  onCreate: _onCreate,
                  disabled: disabled(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
