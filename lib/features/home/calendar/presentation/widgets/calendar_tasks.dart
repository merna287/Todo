import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/features/home/Calendar/presentation/widgets/task_filter.dart';
import 'package:todo/features/home/presentation/view_model/task_view_model.dart';
import 'package:todo/features/home/presentation/widgets/empty_home.dart';
import 'package:todo/features/home/presentation/widgets/task_item_widget.dart';

class CalendarTasks extends StatelessWidget {
  final DateTime selectedDate;
  final CalendarTab selectedTab;

  const CalendarTasks({
    super.key,
    required this.selectedDate,
    required this.selectedTab,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TaskViewModel>();

    final tasks = vm.tasksForDate(selectedDate);

    final filteredTasks = selectedTab == CalendarTab.today
        ? tasks.where((task) => !task.completed).toList()
        : tasks.where((task) => task.completed).toList();

    if (filteredTasks.isEmpty) {
      return const EmptyHome(pageIndex: 1);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: TaskItemWidget(
            task: filteredTasks[index],
          ),
        );
      },
    );
  }
}