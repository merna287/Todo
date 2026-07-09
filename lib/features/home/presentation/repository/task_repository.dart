import 'package:hive/hive.dart';
import 'package:todo/core/network/result_api.dart';
import 'package:todo/core/services/connectivity_service.dart';
import 'package:todo/features/home/presentation/api/task_api.dart';
import 'package:todo/features/home/presentation/model/sync_status.dart';
import 'package:todo/features/home/presentation/model/task_model.dart';
/*
Hive Local Database
Offline First Architecture
Repository Pattern
Sync System
Connectivity Listener
Pending Operations Queue
Merge بين Local و Remote Data
*/ 
class TaskRepository {
  TaskRepository({
    required this.api,
    required this.box,
    required this.connectivityService,
  });

  final TaskApi api;
  final Box<TaskModel> box;
  final ConnectivityService connectivityService;

  Future<List<TaskModel>> loadLocalTasks() async {
    final tasks = box.values.toList();
    tasks.sort((a, b) => a.deadline.compareTo(b.deadline));
    return tasks;
  }

  Future<List<TaskModel>> refreshFromRemote({bool forceRefresh = false}) async {
    if (!await connectivityService.hasConnection) {
      return loadLocalTasks();
    }

    final result = await api.getTasks();
    if (result is SuccessAPI<List<TaskModel>>) {
      final remoteTasks = result.data;
      final localTasks = await loadLocalTasks();
      final mergedTasks = mergeTasks(localTasks, remoteTasks);

      await box.clear();
      for (final task in mergedTasks) {
        await box.put(task.id, task);
      }

      return mergedTasks;
    }

    return loadLocalTasks();
  }

  Future<TaskModel> createTask(TaskModel task) async {
    final localTask = task.copyWith(syncStatus: SyncStatus.pendingCreate);
    await _saveTask(localTask);

    if (!await connectivityService.hasConnection) {
      return localTask;
    }

    final result = await api.addTask(localTask);
    if (result is SuccessAPI<TaskModel>) {
      final syncedTask = result.data.copyWith(syncStatus: SyncStatus.synced);
      await box.delete(localTask.id);
      await box.put(syncedTask.id, syncedTask);
      return syncedTask;
    }

    return localTask;
  }

  Future<TaskModel> updateTask(TaskModel task) async {
    final localTask = task.copyWith(syncStatus: SyncStatus.pendingUpdate);
    await _saveTask(localTask);

    if (!await connectivityService.hasConnection) {
      return localTask;
    }

    final result = await api.updateTask(localTask);
    if (result is SuccessAPI<TaskModel>) {
      final syncedTask = result.data.copyWith(syncStatus: SyncStatus.synced);
      await box.put(syncedTask.id, syncedTask);
      return syncedTask;
    }

    return localTask;
  }

  Future<void> deleteTask(String id) async {
    final existingTask = box.get(id);
    if (existingTask != null) {
      await _saveTask(existingTask.copyWith(syncStatus: SyncStatus.pendingDelete));
    }

    if (!await connectivityService.hasConnection) {
      return;
    }

    final result = await api.deleteTask(id);
    if (result is SuccessAPI<void>) {
      await box.delete(id);
    }
  }

  Future<void> syncPendingTasks() async {
    if (!await connectivityService.hasConnection) {
      return;
    }

    final pendingTasks = (await loadLocalTasks())
        .where((task) => task.isPendingSync)
        .toList();

    for (final task in pendingTasks) {
      if (task.syncStatus == SyncStatus.pendingCreate) {
        final result = await api.addTask(task.copyWith(syncStatus: SyncStatus.synced));
        if (result is SuccessAPI<TaskModel>) {
          final syncedTask = result.data.copyWith(syncStatus: SyncStatus.synced);
          await box.delete(task.id);
          await box.put(syncedTask.id, syncedTask);
        }
      } else if (task.syncStatus == SyncStatus.pendingUpdate) {
        final result = await api.updateTask(task.copyWith(syncStatus: SyncStatus.synced));
        if (result is SuccessAPI<TaskModel>) {
          final syncedTask = result.data.copyWith(syncStatus: SyncStatus.synced);
          await box.put(syncedTask.id, syncedTask);
        }
      } else if (task.syncStatus == SyncStatus.pendingDelete) {
        final result = await api.deleteTask(task.id);
        if (result is SuccessAPI<void>) {
          await box.delete(task.id);
        }
      }
    }

    await refreshFromRemote(forceRefresh: true);
  }

  Future<void> _saveTask(TaskModel task) async {
    await box.put(task.id, task);
  }

  static List<TaskModel> mergeTasks(
    List<TaskModel> localTasks,
    List<TaskModel> remoteTasks,
  ) {
    final mergedTasks = <String, TaskModel>{
      for (final task in remoteTasks) task.id: task,
    };

    for (final task in localTasks) {
      if (task.syncStatus == SyncStatus.pendingDelete) {
        mergedTasks.remove(task.id);
        continue;
      }

      if (task.syncStatus != SyncStatus.synced || !mergedTasks.containsKey(task.id)) {
        mergedTasks[task.id] = task;
      }
    }

    final sortedTasks = mergedTasks.values.toList()
      ..sort((a, b) => a.deadline.compareTo(b.deadline));
    return sortedTasks;
  }
}
