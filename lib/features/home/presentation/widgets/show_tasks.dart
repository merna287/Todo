import 'package:flutter/material.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:todo/features/home/presentation/view_model/task_view_model.dart';
import 'package:todo/features/home/presentation/widgets/empty_home.dart';
import 'package:todo/features/home/presentation/widgets/task_item_widget.dart';

class ShowTasks extends StatefulWidget {
  const ShowTasks({super.key});

  @override
  State<ShowTasks> createState() => _ShowTasksState();
}

class _ShowTasksState extends State<ShowTasks> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TaskViewModel>();

    DateTime displayDate;
    if (selectedDate != null) {
      displayDate = selectedDate!;
    } else if (vm.taskDates.isNotEmpty) {
      displayDate = vm.taskDates.first;
    } else {
      displayDate = DateTime.now();
    }

    DateTime today = DateTime.now();
    bool isToday =
        displayDate.year == today.year &&
        displayDate.month == today.month &&
        displayDate.day == today.day;

    String textDate = isToday
        ? AppStrings.today
        : "${displayDate.day}/${displayDate.month}/${displayDate.year}";

    final tasksForSelectedDate = vm.tasksForDate(displayDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: PopupMenuButton<DateTime>(
            onSelected: (date) {
              setState(() {
                selectedDate = date;
              });
            },
            color: AppColors.mediumGrey,
            itemBuilder: (context) {
              return vm.taskDates.map((date) {
                final isTodayDate =
                    date.year == today.year &&
                    date.month == today.month &&
                    date.day == today.day;
                return PopupMenuItem(
                  value: date,
                  child: Text(
                    isTodayDate
                        ? AppStrings.today
                        : "${date.day}/${date.month}/${date.year}",
                    style: AppTextStyles.regular16.copyWith(
                      color: AppColors.lightGrey2,
                    ),
                  ),
                );
              }).toList();
            },
            child: Container(
              height: 31,
              width: 110,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.mediumGrey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    textDate,
                    style: AppTextStyles.regular16.copyWith(
                      color: AppColors.lightGrey2,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.lightGrey2,
                  ),
                ],
              ),
            ),
          ),
        ),

        Expanded(
          child: tasksForSelectedDate.isEmpty
              ? EmptyHome()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: tasksForSelectedDate.length,
                  itemBuilder: (context, index) {
                    final task = tasksForSelectedDate[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: TaskItemWidget(task: task),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
