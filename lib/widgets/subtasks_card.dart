import 'package:flutter/material.dart' hide ReorderableList;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/models.dart';
import '../states_provider.dart';
import 'create_subtask_tile.dart';
import 'toggle_box.dart';

class SubtaskCard extends StatefulWidget {
  final String taskId;
  final List<Subtask> subtasks;
  const SubtaskCard({super.key, required this.subtasks, required this.taskId});

  @override
  State<SubtaskCard> createState() => _SubtaskCardState();
}

class _SubtaskCardState extends State<SubtaskCard> {
  _onCreate(String title) {
    Subtask newTask = Subtask(
      checked: false,
      id: const Uuid().v4(),
      title: title,
    );

    Provider.of<StateProvider>(context, listen: false).createSubtask(
      widget.taskId,
      newTask,
    );
  }

  _onDelete(String id) {
    Provider.of<StateProvider>(context, listen: false)
        .deleteSubtask(widget.taskId, id);
  }

  _onCheckedPressed(String id, bool checked) {
    Provider.of<StateProvider>(context, listen: false)
        .checkSubtask(widget.taskId, id, checked);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Subtasks",
          style: TextStyle(
            fontSize: 16.0,
            color: Theme.of(context).hintColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4.0),
        Column(
          children: widget.subtasks
              .map(
                (e) => _TaskTile(
                  id: e.id,
                  title: e.title,
                  onDelete: _onDelete,
                  isChecked: e.checked,
                  onCheckedPressed: () => _onCheckedPressed(e.id, !e.checked),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 24.0),
        CreateSubtaskTile(onCreate: _onCreate)
      ],
    );
  }
}

class _TaskTile extends StatelessWidget {
  final String id;
  final String title;
  final Function(String) onDelete;
  final bool isChecked;
  final Function onCheckedPressed;

  const _TaskTile({
    required this.id,
    required this.title,
    required this.onDelete,
    required this.isChecked,
    required this.onCheckedPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ToggleBox(
          value: isChecked,
          onPressed: onCheckedPressed,
        ),
        const SizedBox(width: 12.0),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () => onDelete(id),
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }
}
