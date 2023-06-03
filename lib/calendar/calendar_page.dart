import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime _focusedDay = DateTime.now();
    return Scaffold(
      body: Center(
        child: TableCalendar(
          focusedDay: _focusedDay,
          firstDay: DateTime.utc(2022, 4, 1),
          lastDay: DateTime.utc(2025, 12, 31),
        ),
      ),
    );
  }

}