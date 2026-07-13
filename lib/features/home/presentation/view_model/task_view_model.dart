import 'package:flutter/material.dart';
import 'package:todo/features/home/presentation/model/sync_status.dart';
import 'package:todo/features/home/presentation/model/task_model.dart';
import 'package:todo/features/home/presentation/repository/task_repository.dart';

class TaskViewModel extends ChangeNotifier {
  TaskViewModel({required this.repository});
  final TaskRepository repository;

  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasLoadedInitialTasks = false;

  String? _error;
  String? get error => _error;

  String _searchText = '';

  void search(String value) {
    _searchText = value.toLowerCase();
    notifyListeners();
  }

    void reset() {
    _tasks = [];
    _error = null;
    _hasLoadedInitialTasks = false;
    notifyListeners();
  }

  Future<void> initialize() async {
    _tasks = await repository.loadLocalTasks();
    _hasLoadedInitialTasks = true;
    notifyListeners();
    await fetchTasks(forceRefresh: true);
  }

  Future<void> fetchTasks({bool forceRefresh = false}) async {
    if (!forceRefresh && _hasLoadedInitialTasks && _tasks.isNotEmpty) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    final cachedTasks = await repository.loadLocalTasks();
    _tasks = cachedTasks;
    _hasLoadedInitialTasks = true;
    notifyListeners();

    final refreshedTasks = await repository.refreshFromRemote(
      forceRefresh: forceRefresh,
    );
    _tasks = refreshedTasks;
    _error = null;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTask(TaskModel task) async {
    _isLoading = true;
    notifyListeners();

    final createdTask = await repository.createTask(task);
    _tasks = await repository.loadLocalTasks();
    _error = null;

    if (createdTask.syncStatus == SyncStatus.synced) {
      await fetchTasks(forceRefresh: true);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleCompleted(TaskModel task) async {
    final index = _tasks.indexWhere((item) => item.id == task.id);
    if (index == -1) {
      return;
    }

    final updatedTask = task.copyWith(
      completed: !task.completed,
      syncStatus: SyncStatus.pendingUpdate,
    );

    _tasks[index] = updatedTask;
    notifyListeners();

    await updateTask(updatedTask);
  }

  Future<void> deleteTask(String id) async {
    _isLoading = true;
    notifyListeners();

    await repository.deleteTask(id);
    _tasks.removeWhere((task) => task.id == id);
    _error = null;

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateTask(TaskModel task) async {
    _isLoading = true;
    notifyListeners();

    final syncedTask = await repository.updateTask(task);
    _tasks = await repository.loadLocalTasks();
    final index = _tasks.indexWhere((item) => item.id == syncedTask.id);
    if (index != -1) {
      _tasks[index] = syncedTask;
    }
    _error = null;

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
        .map((task) {
          return DateTime(task.deadline.year, task.deadline.month, task.deadline.day);
        })
        .toSet()
        .toList();
    dates.sort();
    return dates;
  }

  List<TaskModel> tasksForDate(DateTime date) {
    final priorityRanking = {'high': 1, 'medium': 2, 'low': 3};

    final tasks = _tasks
        .where(
          (task) =>
              task.deadline.year == date.year &&
              task.deadline.month == date.month &&
              task.deadline.day == date.day,
        )
        .toList();

    tasks.sort(
      (a, b) => priorityRanking[a.priority.toLowerCase()]!
          .compareTo(priorityRanking[b.priority.toLowerCase()]!),
    );

    return tasks;
  }

  Future<void> syncPendingTasks() async {
    _isLoading = true;
    notifyListeners();

    await repository.syncPendingTasks();
    _tasks = await repository.loadLocalTasks();
    _error = null;

    _isLoading = false;
    notifyListeners();
  }
}
