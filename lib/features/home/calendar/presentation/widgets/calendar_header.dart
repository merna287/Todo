import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/core/theme/app_colors.dart';

class CalendarHeader extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;
  const CalendarHeader({super.key, required this.selectedDate, required this.onDateChanged});

  @override
  State<CalendarHeader> createState() => _CalendarHeaderState();
}

class _CalendarHeaderState extends State<CalendarHeader> {
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(12),
        child: TableCalendar(
          firstDay: DateTime(2020),
          lastDay: DateTime(2035),
          focusedDay: _focusedDay,

          calendarFormat: CalendarFormat.week,
          startingDayOfWeek: StartingDayOfWeek.sunday,

          selectedDayPredicate: (day) => isSameDay(widget.selectedDate, day),

          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
            });

            widget.onDateChanged(selectedDay);
          },

          headerStyle: const HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            leftChevronVisible: true,
            rightChevronVisible: true,
            leftChevronIcon: Icon(
              Icons.chevron_left, 
              color: Colors.white
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right, 
              color: Colors.white
            ),
            titleTextStyle: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,

            defaultDecoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),

            todayDecoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
            ),

            selectedDecoration: BoxDecoration(
              color: AppColors.secondColor,
              borderRadius: BorderRadius.circular(12),
            ),

            defaultTextStyle: const TextStyle(color: Colors.white),

            weekendTextStyle: const TextStyle(color: Colors.white),

            todayTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),

            selectedTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold,
            ),
            weekendStyle: TextStyle(
              color: AppColors.redColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
