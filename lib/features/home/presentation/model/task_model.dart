class TaskModel {

  final String id;
  final String title;
  final String description;
  final String priority;
  final bool completed;
  final DateTime deadline;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    this.completed = false,
    required this.deadline,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      priority: json['priority'],
      completed: json['completed'],
      deadline: DateTime.parse(json['deadline']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "priority": priority,
      "completed": completed,
      "deadline": deadline.toIso8601String(),
    };
  }

  String get formattedDate {
    final now = DateTime.now();

    if (deadline.year == now.year &&
        deadline.month == now.month &&
        deadline.day == now.day) {
      return "Today";
    }

    final day = deadline.day.toString().padLeft(2, '0');
    final month = deadline.month.toString().padLeft(2, '0');
    final year = deadline.year;

    return "$day/$month/$year";
  }
}