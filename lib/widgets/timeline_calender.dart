import 'package:calendar_timeline_sbk/calendar_timeline.dart';
import 'package:flutter/material.dart';

class TimelineCalender extends StatefulWidget {
  const TimelineCalender({super.key});

  @override
  State<TimelineCalender> createState() => _TimelineCalenderState();
}

class _TimelineCalenderState extends State<TimelineCalender> {
  late DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return CalendarTimeline(
      showYears: true,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
      onDateSelected: (date) => setState(() => selectedDate = date),
      leftMargin: 20,
      monthColor: Colors.white70,
      dayColor: Colors.teal[200],
      dayNameColor: Color.fromARGB(255, 50, 59, 77),
      activeDayColor: Colors.white,
      inactiveDayNameColor: Colors.redAccent[100],
      activeBackgroundDayColor: Colors.redAccent[100],
      dotsColor: const Color(0xFF333A47),
      selectableDayPredicate: (date) => date.day != 23,
      locale: 'en',
    );
  }
}
