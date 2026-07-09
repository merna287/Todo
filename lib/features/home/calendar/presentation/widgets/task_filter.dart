import 'package:flutter/material.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';

enum CalendarTab { today, completed }

class TaskFilter extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<CalendarTab> onTabChanged;

  const TaskFilter({
    super.key,
    required this.selectedDate,
    required this.onTabChanged,
  });

  @override
  State<TaskFilter> createState() => _TaskFilterState();
}

class _TaskFilterState extends State<TaskFilter> {
  CalendarTab selectedTab = CalendarTab.today;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    final isToday =
        widget.selectedDate.year == today.year &&
        widget.selectedDate.month == today.month &&
        widget.selectedDate.day == today.day;

    final textDate = isToday
        ? AppStrings.today
        : "${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}";

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(5),
        height: 90,
        decoration: BoxDecoration(
          color: AppColors.mediumGrey,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.darkGrey),
        ),
        child: Row(
          children: [
            Expanded(
              child: _FilterTab(
                title: textDate,
                isSelected: selectedTab == CalendarTab.today,
                onTap: () {
                  setState(() {
                    selectedTab = CalendarTab.today;
                  });
                  widget.onTabChanged(CalendarTab.today);
                },
              ),
            ),
            Expanded(
              child: _FilterTab(
                title: AppStrings.completed,
                isSelected: selectedTab == CalendarTab.completed,
                onTap: () {
                  setState(() {
                    selectedTab = CalendarTab.completed;
                  });
                  widget.onTabChanged(CalendarTab.completed);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterTab({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? null
              : Border.all(color: AppColors.lightGrey2),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: AppTextStyles.regular16.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}