import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../models/car.dart';
import '../../driver_screen.dart';

class DatePickerScreen extends StatefulWidget {
  final Car car;

  const DatePickerScreen({
    super.key,
    required this.car,
  });

  @override
  State<DatePickerScreen> createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  DateTime _focusedDay = DateTime(2025, 6, 10);
  DateTime? _startDay;
  DateTime? _endDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            _BookingStepIndicator(activeStep: 1),
            const SizedBox(height: 16),
            Text(
              'Confirm Dates',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppTheme.dark,
              ),
            ),
            const SizedBox(height: 6),
            TableCalendar(
              firstDay: DateTime(2025, 6, 1),
              lastDay: DateTime(2025, 6, 30),
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
            const SizedBox(height: 14),
            if (_startDay != null && _endDay != null) ...[
              const Text(
                'Pickup and Return Time',
                style: TextStyle(fontWeight: FontWeight.w800, color: AppTheme.dark),
              ),
              const SizedBox(height: 6),
              Text(
                'Same time on both dates 09:00 AM',
                style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 14),
              _DateSummaryRow(
                pickup: _startDay!,
                returnDate: _endDay!,
                days: _endDay!.difference(_startDay!).inDays + 1,
                pricePerDay: widget.car.price,
              ),
              const SizedBox(height: 8),
            ],
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
                              car: widget.car,
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

class _BookingStepIndicator extends StatelessWidget {
  final int activeStep; // 1..4
  const _BookingStepIndicator({required this.activeStep});

  @override
  Widget build(BuildContext context) {
    Widget step(String label, int idx) {
      final isActive = idx == activeStep;
      return Expanded(
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isActive ? AppTheme.primary : Colors.grey.shade600,
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              height: 3,
              width: 26,
              decoration: BoxDecoration(
                color: isActive ? AppTheme.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      );
    }

    return Row(
      children: [
        step('Dates', 1),
        step('Driver', 2),
        step('Payment', 3),
        step('Done', 4),
      ],
    );
  }
}

class _DateSummaryRow extends StatelessWidget {
  final DateTime pickup;
  final DateTime returnDate;
  final int days;
  final double pricePerDay;

  const _DateSummaryRow({
    required this.pickup,
    required this.returnDate,
    required this.days,
    required this.pricePerDay,
  });

  String _dayName(DateTime d) {
    const names = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return names[d.weekday % 7];
  }

  String _monthName(int m) {
    const names = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return names[(m - 1).clamp(0, 11)];
  }

  @override
  Widget build(BuildContext context) {
    final pickupText = '${_dayName(pickup)}, ${_monthName(pickup.month)} ${pickup.day}';
    final returnText = '${_dayName(returnDate)}, ${_monthName(returnDate.month)} ${returnDate.day}';
    final total = pricePerDay * days;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('PICK-UP', style: TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              Text(pickupText, style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('RETURN', style: TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              Text(returnText, style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${days} days · KSh ${total.toStringAsFixed(0)} total', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w800)),
            ],
          ),
        ),
      ],
    );
  }
}
