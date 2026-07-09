import 'package:flutter/material.dart';
import 'package:todo/features/home/Calendar/presentation/widgets/calendar_header.dart';
import 'package:todo/features/home/Calendar/presentation/widgets/calendar_tasks.dart';
import 'package:todo/features/home/Calendar/presentation/widgets/task_filter.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDate = DateTime.now();
  CalendarTab selectedTab = CalendarTab.today;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarHeader(
          selectedDate: selectedDate,
          onDateChanged: (date) {
            setState(() {
              selectedDate = date;
            });
          },
        ),
        TaskFilter(
          selectedDate: selectedDate,
          onTabChanged: (CalendarTab value) {
            setState(() {
              selectedTab = value;
            });
          },
        ),
        Expanded(
          child: CalendarTasks(
            selectedDate: selectedDate,
            selectedTab: selectedTab,
          ),
        ),
      ],
    );
  }
}
