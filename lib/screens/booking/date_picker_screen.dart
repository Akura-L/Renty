import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../../driver_screen.dart';

class DatePickerScreen extends StatefulWidget {
  const DatePickerScreen({super.key});

  @override
  State<DatePickerScreen> createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _startDay;
  DateTime? _endDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Dates"),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.dark,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.now().add(const Duration(days: 1)),
              lastDay: DateTime.now().add(const Duration(days: 365)),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) =>
                  isSameDay(_startDay, day) || isSameDay(_endDay, day),
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                    color: AppTheme.primary, shape: BoxShape.circle),
                selectedDecoration: BoxDecoration(
                    color: AppTheme.primary, shape: BoxShape.circle),
                rangeHighlightColor: AppTheme.primary,
                rangeStartDecoration: BoxDecoration(
                    color: AppTheme.primary, shape: BoxShape.circle),
                rangeEndDecoration: BoxDecoration(
                    color: AppTheme.primary, shape: BoxShape.circle),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onDaySelected: (selected, focused) {
                setState(() {
                  if (_startDay == null ||
                      (_startDay != null && _endDay != null)) {
                    _startDay = selected;
                    _endDay = null;
                  } else if (selected.isAfter(_startDay!)) {
                    _endDay = selected;
                  } else {
                    _endDay = null;
                  }
                  _focusedDay = focused;
                });
              },
              calendarBuilders: CalendarBuilders(
                rangeStartBuilder: (context, day, focusedDay) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        color: AppTheme.primary, shape: BoxShape.circle),
                    child: Center(
                        child: Text('${day.day}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                  );
                },
                rangeEndBuilder: (context, day, focusedDay) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        color: AppTheme.primary, shape: BoxShape.circle),
                    child: Center(
                        child: Text('${day.day}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _startDay == null
                  ? 'Select your rental period'
                  : _endDay == null
                      ? 'Selected start: ${_startDay!.day}/${_startDay!.month}/${_startDay!.year}\nTap another date for end date'
                      : 'Rental period: ${_startDay!.day}/${_startDay!.month} - ${_endDay!.day}/${_endDay!.month}',
              style:
                  GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _startDay != null && _endDay != null
                    ? () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DriverScreen(
                              startDate: _startDay,
                              endDate: _endDay,
                            ),
                          ),
                        )
                    : null,
                child: const Text("Continue",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
