import 'package:flutter/material.dart' hide ReorderableList;
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:uuid/uuid.dart';

import '../models/models.dart';
import 'create_subtask_tile.dart';

class CreateSubtask extends StatefulWidget {
  final Function(List<Subtask>) onCreate;
  const CreateSubtask({super.key, required this.onCreate});

  @override
  State<CreateSubtask> createState() => _CreateSubtaskState();
}

class _CreateSubtaskState extends State<CreateSubtask> {
  List<Subtask> _items = [];

  // Returns index of item with given key
  int _indexOfKey(Key key) {
    return _items.indexWhere((d) => ValueKey(d.id) == key);
  }

  bool _onReorder(Key item, Key newPosition) {
    int draggingIndex = _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);

    final draggedItem = _items[draggingIndex];

    List<Subtask> newItems = [..._items];
    newItems.removeAt(draggingIndex);
    newItems.insert(newPositionIndex, draggedItem);

    setState(() {
      _items = newItems;
    });
    return true;
  }

  _onDelete(String item) {
    int inx = _indexOfKey(ValueKey(item));

    List<Subtask> newItems = [..._items];
    newItems.removeAt(inx);

    setState(() {
      _items = newItems;
    });
  }

  _onCreate(String title) {
    Subtask newTask = Subtask(
      checked: false,
      id: const Uuid().v4(),
      title: title,
    );
    setState(() {
      _items.add(newTask);
      widget.onCreate(_items);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Text(
              "Subtasks",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ReorderableList(
            decoratePlaceholder: (widget, decorationOpacity) {
              return DecoratedPlaceholder(widget: Container(), offset: 0.0);
            },
            onReorder: _onReorder,
            child: Column(
              children: _items
                  .map(
                    (e) => _TaskTile(
                      id: e.id,
                      title: e.title,
                      onDelete: _onDelete,
                    ),
                  )
                  .toList(),
            ),
          ),
          CreateSubtaskTile(onCreate: _onCreate),
        ],
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  final String id;
  final String title;
  final Function(String) onDelete;

  const _TaskTile({
    required this.id,
    required this.title,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // _buildChild
    return ReorderableItem(
      key: ValueKey(id),
      childBuilder: (BuildContext context, ReorderableItemState state) {
        return Opacity(
          opacity: state == ReorderableItemState.placeholder ? 0.5 : 1.0,
          child: Row(
            children: [
              ReorderableListener(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.reorder),
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => onDelete(title),
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        );
      },
    );
  }
}

