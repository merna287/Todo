enum ConnectivityStatus { connected, disconnected, initial }

class ConnectivityState {
  final ConnectivityStatus status;
  final ConnectivityStatus previousStatus;

  const ConnectivityState({
    required this.status,
    this.previousStatus = ConnectivityStatus.initial,
  });

  bool get isConnected => status == ConnectivityStatus.connected;
  bool get isDisconnected => status == ConnectivityStatus.disconnected;
  bool get justReconnected =>
      status == ConnectivityStatus.connected &&
      previousStatus == ConnectivityStatus.disconnected;

  ConnectivityState copyWith({ConnectivityStatus? status}) {
    return ConnectivityState(
      status: status ?? this.status,
      previousStatus: this.status,
    );
  }
}