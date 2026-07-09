import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class FocusStat {
  FocusStat({
    required this.day,
    required this.hours,
    required this.isHighlighted,
  });

  final String day;
  final double hours;
  final bool isHighlighted;
}

class FocusViewModel extends ChangeNotifier {
  FocusViewModel() {
    _weeklyStats = [
      FocusStat(day: 'Sun', hours: 2.5, isHighlighted: false),
      FocusStat(day: 'Mon', hours: 3.0, isHighlighted: false),
      FocusStat(day: 'Tue', hours: 2.0, isHighlighted: false),
      FocusStat(day: 'Wed', hours: 4.5, isHighlighted: false),
      FocusStat(day: 'Thu', hours: 1.5, isHighlighted: false),
      FocusStat(day: 'Fri', hours: 5.0, isHighlighted: true),
      FocusStat(day: 'Sat', hours: 3.5, isHighlighted: false),
    ];
  }

  late final List<FocusStat> _weeklyStats;
  List<FocusStat> get weeklyStats => List.unmodifiable(_weeklyStats);

  bool _isRunning = false;
  bool get isRunning => _isRunning;

  int _elapsedSeconds = 0;
  int get elapsedSeconds => _elapsedSeconds;

  Timer? _timer;

  double get progress => min(_elapsedSeconds / 3600, 1.0);

  String get formattedTime {
    final minutes = _elapsedSeconds ~/ 60;
    final seconds = _elapsedSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void toggleTimer() {
    if (_isRunning) {
      stopTimer();
    } else {
      startTimer();
    }
  }

  void startTimer() {
    if (_isRunning) return;

    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _elapsedSeconds++;
      notifyListeners();
    });
    notifyListeners();
  }

  void stopTimer() {
    _timer?.cancel();
    _isRunning = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
