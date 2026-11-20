import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({super.key});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  final DateTime _initStartDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16 * 5),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(16),
        child: DateRangePickerDialog(
          firstDate: _initStartDate,
          lastDate: DateTime(
            _initStartDate.year,
            _initStartDate.month + 6,
            _initStartDate.day,
          ),
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          saveText: 'Confirm',
          helpText: 'When\'s your trip?',
        ),
      ),
    );
  }
}
