import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/core/network/connectivity_state.dart';

class ConnectivityService extends ChangeNotifier {
  ConnectivityService() {
    initialize();
  }

  final Connectivity _connectivity = Connectivity();
  final StreamController<ConnectivityState> _stateController =
      StreamController<ConnectivityState>.broadcast();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  ConnectivityState _state = const ConnectivityState(
    status: ConnectivityStatus.initial,
  );

  ConnectivityState get state => _state;
  bool get isConnected => _state.isConnected;
  Stream<ConnectivityState> get onConnectivityChanged => _stateController.stream;

  Future<void> initialize() async {
    _subscription?.cancel();
    final result = await _connectivity.checkConnectivity();
    _updateState(result);
    _subscription = _connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<bool> get hasConnection async {
    final result = await _connectivity.checkConnectivity();
    return result.any((item) => item != ConnectivityResult.none);
  }

  void _updateState(List<ConnectivityResult> results) {
    final connected = results.any((result) => result != ConnectivityResult.none);
    final nextStatus = connected
        ? ConnectivityStatus.connected
        : ConnectivityStatus.disconnected;

    final nextState = _state.copyWith(status: nextStatus);
    if (nextState.status == _state.status) {
      return;
    }

    _state = nextState;
    _stateController.add(_state);
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _stateController.close();
    super.dispose();
  }
}
