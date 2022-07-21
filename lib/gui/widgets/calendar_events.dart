import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:mr_fix_expert/core/theme/colors_theme.dart';

class CalendarEvents extends StatefulWidget {
  const CalendarEvents({
    Key? key,
    this.minDate,
    required this.focusedDay,
    required this.onDaySelected,
  }) : super(key: key);

  final DateTime? minDate;
  final DateTime focusedDay;
  final void Function(DateTime, DateTime)? onDaySelected;

  @override
  State<CalendarEvents> createState() => _CalendarEventsState();
}

class _CalendarEventsState extends State<CalendarEvents> {
  DateTime _selectedDay = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.week;

  @override
  void initState() {
    setState(() {
      _selectedDay = widget.focusedDay;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TableCalendar(
        focusedDay: _selectedDay,
        firstDay: widget.minDate ?? DateTime.now(),
        lastDay: Jiffy().add(months: 1).dateTime,
        calendarFormat: calendarFormat,
        onFormatChanged: (CalendarFormat format) {
          setState(() {
            calendarFormat = format;
          });
        },
        startingDayOfWeek: StartingDayOfWeek.monday,
        daysOfWeekVisible: true,
        onDaySelected: (DateTime selectDay, DateTime _) {
          setState(() {
            _selectedDay = selectDay;
          });
          widget.onDaySelected?.call(_selectedDay, _selectedDay);
        },
        calendarStyle: const CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: ColorsAppTheme.primaryColor,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(color: Colors.white),
          todayDecoration: BoxDecoration(
            color: Colors.transparent,
          ),
          todayTextStyle: TextStyle(
            color: Colors.black,
          ),
        ),
        selectedDayPredicate: (DateTime date) {
          return isSameDay(_selectedDay, date);
        },
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
        ),
      ),
    );
  }
}
