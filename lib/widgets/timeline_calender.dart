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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity, // Set the width of the calendar
          height: 150, // Set the height of the calendar
          child: CalendarTimeline(
            showYears: true,
            initialDate: selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365 * 4)),
            onDateSelected: (date) {
              setState(() => selectedDate = date);
                        },
            leftMargin: 20,
            selectableDayPredicate: (date) => date.day != 23,
            locale: 'en',
          ),
        ),
      ),
    );
  }
}
