import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imori_seikatsu/calendar/calendar_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import '../domain/event.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalendarModel>(
      create: (_) => CalendarModel()..fetchEvent(),
      child: Consumer<CalendarModel>(
        builder: (context, model, child) {
          List<Event>? events = model.events;
          DateTime focusedDay = model.focusedDay;
          DateTime? selectedDay = model.selectedDay;
          selectedDay = focusedDay;
          Map<DateTime, List<dynamic>> eventsList = {} ;

          if (events == null) {
            return const Center(child: CircularProgressIndicator());
          }

          for (int i = 0; i < events.length; i++) {
            eventsList.addAll({
              events[i].registrationDate.toDate() : events[i].event
            });
          }

          int getHashCode(DateTime key) {
            return key.day * 1000000 + key.month * 10000 + key.year;
          }

          final _events = LinkedHashMap<DateTime, List>(
            equals: isSameDay,
            hashCode: getHashCode,
          )..addAll(eventsList);

          List getEvent(DateTime day) {
            return _events[day] ?? [];
          }
          return Scaffold(
            body: Column(
              children: [
                TableCalendar(
                  focusedDay: focusedDay,
                  firstDay: DateTime.utc(2022, 4, 1),
                  lastDay: DateTime.utc(2025, 12, 31),
                  selectedDayPredicate: (day) {
                    return isSameDay(selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    model.setDate(focusedDay, selectedDay);
                  },
                  eventLoader: getEvent
                ),
                ListView(
                  shrinkWrap: true,
                  children: getEvent(selectedDay).map((event) => ListTile(
                      title: Text(event.toString()))
                  ).toList(),
                )
              ],
            ),
          );
        },
      ),
    );
  }

}