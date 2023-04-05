import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/models.dart';

const String modeKey = "theme-mode";
const String taskKey = "task";

class StateProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  String _themeMode = "light";

  List<Task> tasks(String query) {
    List<Task> matchTasks = [];

    for (var task in _tasks) {
      if (task.title.toLowerCase().contains(query.toLowerCase())) {
        matchTasks.add(task);
      }
    }
    return matchTasks;
  }

  bool get isDarkMode => _themeMode == "dark";

  ThemeMode get themeMode =>
      _themeMode == "dark" ? ThemeMode.dark : ThemeMode.light;

  Task? findTask(String taskId) {
    return _tasks.firstWhere(
      (task) => task.id == taskId,
      orElse: () => Task(
          id: "", title: "", subtasks: [], date: "2023-01-01", time: "00:00"),
    );
  }

  Future<void> changeTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String mode = isDarkMode ? "light" : "dark";

    prefs.setString(modeKey, mode);

    _themeMode = mode;

    notifyListeners();
  }

  void createTask(Task newTask) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Task> tasks = [..._tasks];
    tasks.add(newTask);

    prefs.setString(taskKey, jsonEncode(tasks));

    _tasks = tasks;
    notifyListeners();
  }

  void deleteTask(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Task> tasks = [..._tasks];
    tasks.removeWhere((task) => task.id == id);

    prefs.setString(taskKey, jsonEncode(tasks));

    _tasks = tasks;
    notifyListeners();
  }

  void createSubtask(String taskId, Subtask subtask) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Task> tasks = [..._tasks];

    int taskInx = tasks.indexWhere((task) => task.id == taskId);

    Task task = tasks[taskInx];

    task.subtasks.add(subtask);

    tasks[taskInx] = task;

    prefs.setString(taskKey, jsonEncode(tasks));

    _tasks = tasks;
    notifyListeners();
  }

  deleteSubtask(String taskId, String subtaskId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Task> tasks = [..._tasks];

    int taskInx = tasks.indexWhere((task) => task.id == taskId);
    int subTaskInx = tasks[taskInx]
        .subtasks
        .indexWhere((subtask) => subtask.id == subtaskId);

    tasks[taskInx].subtasks.removeAt(subTaskInx);

    prefs.setString(taskKey, jsonEncode(tasks));

    _tasks = tasks;
    notifyListeners();
  }

  checkSubtask(String taskId, String subtaskId, bool checked) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Task> tasks = [..._tasks];

    var taskInx = tasks.indexWhere((task) => task.id == taskId);

    var subtasks = tasks[taskInx].subtasks;

    var subtaskInx = subtasks.indexWhere((subtask) => subtask.id == subtaskId);

    Subtask newSubtask = Subtask(
      id: subtasks[subtaskInx].id,
      title: subtasks[subtaskInx].title,
      checked: checked,
    );

    tasks[taskInx].subtasks.removeAt(subtaskInx);
    tasks[taskInx].subtasks.insert(subtaskInx, newSubtask);

    prefs.setString(taskKey, jsonEncode(tasks));

    _tasks = tasks;

    notifyListeners();
  }

  checkAllSubtask(String taskId, bool checked) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Task> tasks = [..._tasks];

    int taskInx = tasks.indexWhere((task) => task.id == taskId);

    List<Subtask> subtasks = tasks[taskInx].subtasks;

    List<Subtask> newSubtasks = [];

    for (var i = 0; i < subtasks.length; i++) {
      var subtask = subtasks[i];

      Subtask newSubtask = Subtask(
        id: subtask.id,
        title: subtask.title,
        checked: checked,
      );
      newSubtasks.add(newSubtask);
    }

    tasks[taskInx].subtasks.clear();

    tasks[taskInx].subtasks.addAll(newSubtasks);

    prefs.setString(taskKey, jsonEncode(tasks));

    _tasks = tasks;

    notifyListeners();
  }

  initializeTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _themeMode = prefs.getString(modeKey) ?? "light";
    notifyListeners();
  }

  initializeTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storeTask = prefs.getString(taskKey);
    final List<dynamic> tasks = storeTask != null ? jsonDecode(storeTask) : [];


    _tasks = tasks
        .map(
          (e) => Task(
            id: e["id"].toString(),
            title: e["title"],
            description: e["description"],
            subtasks: (e["subtasks"] as List<dynamic>)
                .map(
                  (s) => Subtask(
                    id: s["id"],
                    title: s["title"],
                    checked: s["checked"],
                  ),
                )
                .toList(),
            date: e["date"],
            time: e["time"],
          ),
        )
        .toList();

    notifyListeners();
  }
}
