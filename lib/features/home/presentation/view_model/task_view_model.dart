import 'package:flutter/material.dart';
import 'package:todo/core/errors/failure.dart';
import 'package:todo/core/network/result_api.dart';
import 'package:todo/features/home/presentation/api/task_api.dart';
import 'package:todo/features/home/presentation/model/task_model.dart';

class TaskViewModel extends ChangeNotifier {
  TaskViewModel({required this.api});
  final TaskApi api;

  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  String _searchText = "";

  void search(String value) {
    _searchText = value.toLowerCase();
    notifyListeners();
  }

  Future<void> fetchTasks() async {
    _isLoading = true;
    notifyListeners();

    final result = await api.getTasks();

    if (result is SuccessAPI<List<TaskModel>>) {
      _tasks = result.data;
      _error = null;
    } else if (result is ErrorAPI<List<TaskModel>>) {
      _error = result.failure.userMessage;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTask(TaskModel task) async {
    _isLoading = true;
    notifyListeners();
    final result = await api.addTask(task);

    if (result is SuccessAPI<TaskModel>) {
      await fetchTasks();
      _error = null;
      print("Task added: ${result.data.title}");
      print("Total tasks: ${_tasks.length}");
    } else if (result is ErrorAPI<TaskModel>) {
      _error = result.failure.userMessage;
      print("Error adding task: $_error");
    }

    _isLoading = false;
    notifyListeners();
  }

  void toggleCompleted(TaskModel task) async {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      final updatedTask = TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        priority: task.priority,
        completed: !task.completed,
        deadline: task.deadline,
      );

      _tasks[index] = updatedTask;
      notifyListeners();

      await updateTask(updatedTask);
    }
  }

  Future<void> deleteTask(String id) async {
    _isLoading = true;
    notifyListeners();

    final result = await api.deleteTask(id);

    if (result is SuccessAPI<void>) {
      await fetchTasks();
      _tasks.removeWhere((task) => task.id == id);
      _error = null;
    } else if (result is ErrorAPI<void>) {
      _error = result.failure.userMessage;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateTask(TaskModel task) async {
    _isLoading = true;
    notifyListeners();

    final result = await api.updateTask(task);

    if (result is SuccessAPI<TaskModel>) {
      await fetchTasks();
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) _tasks[index] = task;
      _error = null;
    } else if (result is ErrorAPI<TaskModel>) {
      _error = result.failure.userMessage;
    }

    _isLoading = false;
    notifyListeners();
  }

  List<TaskModel> get filteredTasks {
    if (_searchText.isEmpty) return _tasks;

    return tasks.where((task) {
      return task.title.toLowerCase().contains(_searchText) ||
          task.description.toLowerCase().contains(_searchText);
    }).toList();
  }

  List<DateTime> get taskDates {
    final dates = _tasks
        .map((t) {
          return DateTime(t.deadline.year, t.deadline.month, t.deadline.day);
        })
        .toSet()
        .toList();
    dates.sort();
    return dates;
  }

  List<TaskModel> tasksForDate(DateTime date) {
    final priorityRanking = {"high": 1, "medium": 2, "low": 3};

    final tasks = _tasks
        .where(
          (t) =>
              t.deadline.year == date.year &&
              t.deadline.month == date.month &&
              t.deadline.day == date.day,
        )
        .toList();

    tasks.sort((a, b) =>
          priorityRanking[a.priority.toLowerCase()]!
          .compareTo(priorityRanking[b.priority.toLowerCase()]!));

    return tasks;
  }
}
