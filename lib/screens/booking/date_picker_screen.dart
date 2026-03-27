import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../core/theme.dart';
import '../../models/car.dart';
import '../../driver_screen.dart';
import 'widgets/booking_flow_stepper.dart';

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
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: const Icon(Icons.chevron_left, color: Colors.black, size: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Confirm Dates',
          style: TextStyle(color: Color(0xFF2D3E50), fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const BookingFlowStepper(currentStep: 1),
              const SizedBox(height: 32),

              // Car Summary Card
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        widget.car.imageUrl,
                        width: 80,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.car.name,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF2D3E50)),
                          ),
                          Text(
                            '${widget.car.exactLocation}',
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'KSh ${widget.car.price.toInt()}',
                          style: const TextStyle(color: RentyColors.primary, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const Text('/day', style: TextStyle(color: Colors.grey, fontSize: 11)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              Text(
                'June 2025',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2D3E50)),
              ),
              const SizedBox(height: 16),
              _buildCalendar(),
              const SizedBox(height: 32),

              // Date Selection Row
              Row(
                children: [
                  Expanded(
                    child: _buildDateBox(
                      label: 'PICK-UP',
                      date: 'Fri, Jun 20',
                      time: '09:00 AM',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: Color(0xFFE8F6F6), shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_forward, color: RentyColors.primary, size: 16),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDateBox(
                      label: 'RETURN',
                      date: 'Wed, Jun 25',
                      time: '09:00 AM',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Time Selection Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade100),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time, color: RentyColors.primary, size: 20),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Pickup and Return Time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Text('Same time on both dates', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(color: const Color(0xFFE8F6F6), borderRadius: BorderRadius.circular(12)),
                      child: const Row(
                        children: [
                          Text('09:00 AM', style: TextStyle(color: RentyColors.primary, fontWeight: FontWeight.bold, fontSize: 13)),
                          SizedBox(width: 4),
                          Icon(Icons.chevron_right, color: RentyColors.primary, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Price Breakdown
              _buildPriceRow('KSh 8,500 × 5 days', 'KSh 42,500'),
              const SizedBox(height: 12),
              _buildPriceRow('Service fee', 'KSh 3,500'),
              const SizedBox(height: 12),
              const Divider(color: Color(0xFFF1F3F4)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('KSh 46,000', style: const TextStyle(color: RentyColors.primary, fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DriverScreen(car: widget.car),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RentyColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Confirm Dates', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.now(),
          lastDay: DateTime.now().add(const Duration(days: 365)),
          focusedDay: _focusedDay,
          rangeStartDay: _rangeStart,
          rangeEndDay: _rangeEnd,
          rangeSelectionMode: RangeSelectionMode.toggledOn,
          onRangeSelected: (start, end, focusedDay) {
            setState(() {
              _rangeStart = start;
              _rangeEnd = end;
              _focusedDay = focusedDay;
            });
          },
          headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
          calendarStyle: const CalendarStyle(
            defaultTextStyle: TextStyle(color: Color(0xFF2D3E50)),
            rangeStartDecoration: BoxDecoration(color: RentyColors.primary, shape: BoxShape.circle),
            rangeEndDecoration: BoxDecoration(color: RentyColors.primary, shape: BoxShape.circle),
            rangeHighlightColor: Color(0xFFE8F6F6),
            todayDecoration: BoxDecoration(color: Color(0xFFF8F9FA), shape: BoxShape.circle),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem('Selected', RentyColors.primary),
            const SizedBox(width: 16),
            _buildLegendItem('Booked', const Color(0xFFFEE2E2)),
            const SizedBox(width: 16),
            _buildLegendItem('Unavailable', const Color(0xFFF3F4F6)),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildDateBox({required String label, required String date, required String time}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(date, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF2D3E50))),
          Text(time, style: const TextStyle(color: RentyColors.primary, fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF2D3E50))),
      ],
    );
  }
}
