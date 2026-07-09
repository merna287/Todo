import 'dart:async';

import 'package:todo/core/network/connectivity_state.dart';
import 'package:todo/core/services/connectivity_service.dart';
import 'package:todo/features/home/presentation/repository/task_repository.dart';

class SyncService {
  SyncService({
    required this.repository,
    required this.connectivityService,
  });

  final TaskRepository repository;
  final ConnectivityService connectivityService;

  StreamSubscription<ConnectivityState>? _subscription;
  bool _isSyncing = false;

  Future<void> initialize() async {
    _subscription = connectivityService.onConnectivityChanged.listen((state) {
      if (state.justReconnected) {
        syncPendingTasks();
      }
    });

    if (connectivityService.isConnected) {
      await syncPendingTasks();
    }
  }

  Future<void> syncPendingTasks() async {
    if (_isSyncing || !connectivityService.isConnected) {
      return;
    }

    _isSyncing = true;
    try {
      await repository.syncPendingTasks();
    } finally {
      _isSyncing = false;
    }
  }

  void dispose() {
    _subscription?.cancel();
  }
}
