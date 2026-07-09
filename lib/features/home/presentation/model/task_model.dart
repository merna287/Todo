import 'package:hive/hive.dart';
import 'package:todo/features/home/presentation/model/sync_status.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String priority;

  @HiveField(4)
  final bool completed;

  @HiveField(5)
  final DateTime deadline;

  @HiveField(6)
  int syncStatusCode;

  SyncStatus get syncStatus => SyncStatus.values[syncStatusCode];
  set syncStatus(SyncStatus value) => syncStatusCode = value.index;

  bool get isPendingSync => syncStatus != SyncStatus.synced;
  bool get isDeleted => syncStatus == SyncStatus.pendingDelete;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    this.completed = false,
    required this.deadline,
    SyncStatus? syncStatus,
  }) : syncStatusCode = (syncStatus ?? SyncStatus.synced).index;

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      priority: json['priority'],
      completed: json['completed'],
      deadline: DateTime.parse(json['deadline']),
      syncStatus: SyncStatus.synced,
    );
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? priority,
    bool? completed,
    DateTime? deadline,
    SyncStatus? syncStatus,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      completed: completed ?? this.completed,
      deadline: deadline ?? this.deadline,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'priority': priority.toLowerCase(),
      'completed': completed,
      'deadline': deadline.toIso8601String(),
    };
  }

  String get formattedDate {
    final now = DateTime.now();

    if (deadline.year == now.year &&
        deadline.month == now.month &&
        deadline.day == now.day) {
      return 'Today';
    }

    final day = deadline.day.toString().padLeft(2, '0');
    final month = deadline.month.toString().padLeft(2, '0');
    final year = deadline.year;

    return '$day/$month/$year';
  }
}