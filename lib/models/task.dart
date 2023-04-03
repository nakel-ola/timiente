class Task {
  final String id;
  final String title;
  final String? description;
  final List<Subtask> subtasks;
  final String date;
  final String time;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.subtasks,
    required this.date,
    required this.time,
  });

  Map toJson() => {
        'id': id,
        'title': title,
        'description': description ?? "",
        'subtasks': subtasks.map((e) => e.toJson()).toList(),
        'date': date,
        'time': time
      };
}

class Subtask {
  final String id;
  final String title;
  final bool checked;

  Subtask({
    required this.id,
    required this.title,
    required this.checked,
  });

  Map toJson() => {
        'id': id,
        'title': title,
        "checked": checked,
      };
}
