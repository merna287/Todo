import 'package:flutter_test/flutter_test.dart';
import 'package:todo/features/home/presentation/model/task_model.dart';
import 'package:todo/features/home/presentation/model/sync_status.dart';
import 'package:todo/features/home/presentation/repository/task_repository.dart';

void main() {
  group('TaskRepository mergeTasks', () {
    test('prefers local pending updates over remote tasks', () {
      final remoteTask = TaskModel(
        id: 'task-1',
        title: 'Server title',
        description: 'Server description',
        priority: 'high',
        deadline: DateTime(2026, 7, 10),
        syncStatus: SyncStatus.synced,
      );

      final localTask = TaskModel(
        id: 'task-1',
        title: 'Offline update',
        description: 'Offline description',
        priority: 'medium',
        deadline: DateTime(2026, 7, 10),
        syncStatus: SyncStatus.pendingUpdate,
      );

      final merged = TaskRepository.mergeTasks([localTask], [remoteTask]);

      expect(merged.single.title, 'Offline update');
      expect(merged.single.syncStatus, SyncStatus.pendingUpdate);
    });

    test('removes tasks marked for pending delete', () {
      final remoteTask = TaskModel(
        id: 'task-1',
        title: 'Keep me',
        description: 'Keep me',
        priority: 'low',
        deadline: DateTime(2026, 7, 11),
        syncStatus: SyncStatus.synced,
      );

      final pendingDeleteTask = TaskModel(
        id: 'task-2',
        title: 'Delete me',
        description: 'Delete me',
        priority: 'low',
        deadline: DateTime(2026, 7, 12),
        syncStatus: SyncStatus.pendingDelete,
      );

      final merged = TaskRepository.mergeTasks(
        [pendingDeleteTask],
        [remoteTask, pendingDeleteTask],
      );

      expect(merged.map((task) => task.id), ['task-1']);
    });
  });
}
