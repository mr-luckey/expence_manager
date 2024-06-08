import 'package:calendar_timeline_sbk/calendar_timeline.dart';
import 'package:flutter/material.dart';

class TimelineCalender extends StatefulWidget {
  const TimelineCalender({Key? key}) : super(key: key);

  @override
  State<TimelineCalender> createState() => _TimelineCalenderState();
}

class _TimelineCalenderState extends State<TimelineCalender> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now(); // Initialize selectedDate with the current date
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CalendarTimeline(
          showYears: true,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
          onDateSelected: (date) => setState(() => selectedDate = date),
          leftMargin: 20,
          monthColor: Colors.white70,
          dayColor: Colors.teal[200],
          dayNameColor: Color.fromARGB(255, 50, 59, 77),
          activeDayColor: Colors.white, // Set the active day text color to white
          inactiveDayNameColor: Colors.redAccent[100],
          activeBackgroundDayColor: Colors.blue, // Set the active day background color to blue
          dotsColor: const Color(0xFF333A47),
          selectableDayPredicate: (date) => date.day != 23,
          locale: 'en',
        ),
      ),
    );
  }
}
