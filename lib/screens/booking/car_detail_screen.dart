import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/theme.dart';
import '../../models/car.dart';

// import 'date_picker_screen.dart';

class CarDetailScreen extends StatefulWidget {
  final Car car;

  const CarDetailScreen({
    super.key,
    required this.car,
  });

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool _isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.car.name)),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.screenPadding(context),
          vertical: Responsive.screenPadding(context),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: Responsive.adaptiveHeight(
                    context, AppTheme.kDetailImageHeight),
                width: double.infinity,
                child: Image.asset(
                  widget.car.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported,
                        size: 50, color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                if (widget.car.topRated)
                  _Badge(text: 'TOP RATED', color: AppTheme.primary),
                if (widget.car.availableToday)
                  SizedBox(width: Responsive.horizontalGap(context)),
                if (widget.car.availableToday)
                  _Badge(text: 'AVAILABLE', color: const Color(0xFF2E7D32)),
              ],
            ),
            const SizedBox(height: 10),
            Text("KSh ${widget.car.price.toStringAsFixed(0)} /day",
                style: GoogleFonts.inter(
                    fontSize: 28,
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(
              '${widget.car.location} • ${widget.car.rating.toStringAsFixed(1)} (${widget.car.reviewCount})',
              style: const TextStyle(
                  color: AppTheme.grey, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _SectionTitle('Specifications'),
            const SizedBox(height: 10),
            if (widget.car.specs.isEmpty)
              Text(
                'Specifications will appear here.',
                style: TextStyle(
                    color: AppTheme.grey700, fontWeight: FontWeight.w600),
              )
            else
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: widget.car.specs
                    .map(
                      (s) => _SpecChip(text: s),
                    )
                    .toList(),
              ),
            const SizedBox(height: 18),
            _SectionTitle('About This Car'),
            const SizedBox(height: 8),
            if (widget.car.about.isNotEmpty)
              Text(
                widget.car.about,
                style: TextStyle(
                    color: AppTheme.grey700, fontWeight: FontWeight.w600),
              ),
            if (widget.car.about.isNotEmpty)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Read more'),
                ),
              ),
            const SizedBox(height: 10),
            _SectionTitle('Select Rental Dates'),
            const SizedBox(height: 10),
            TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(const Duration(days: 365)),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => _isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: CalendarStyle(
                defaultTextStyle: const TextStyle(
                    color: AppTheme.dark, fontWeight: FontWeight.w700),
                weekendTextStyle: const TextStyle(
                    color: AppTheme.dark, fontWeight: FontWeight.w700),
                todayDecoration: const BoxDecoration(
                  color: AppTheme.primary,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: AppTheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: Responsive.horizontalGap(context),
              alignment: WrapAlignment.spaceBetween,
              children: [
                _LegendItem(label: 'Selected', color: AppTheme.primary),
                _LegendItem(label: 'Booked', color: const Color(0xFFB71C1C)),
                _LegendItem(
                    label: 'Unavailable', color: const Color(0xFF9E9E9E)),
              ],
            ),
            const SizedBox(height: 18),
            _SectionTitle('Reviews'),
            const SizedBox(height: 10),
            if (widget.car.reviews.isEmpty)
              Text(
                'No reviews yet.',
                style: TextStyle(
                    color: AppTheme.grey700, fontWeight: FontWeight.w600),
              )
            else
              Column(
                children: widget.car.reviews.take(2).map((r) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: Responsive.adaptiveRadius(context, 18),
                          backgroundColor: AppTheme.primary.withOpacity(0.14),
                          child: Text(
                            r.initials,
                            style: TextStyle(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(width: Responsive.horizontalGap(context)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                r.text,
                                style: TextStyle(
                                    color: AppTheme.dark,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${r.name} · ${r.monthYear}',
                                style: TextStyle(
                                    color: AppTheme.grey700,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            if (widget.car.reviewCount > 2)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: Text('See all ${widget.car.reviewCount} reviews'),
                ),
              ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Date selected: ${_selectedDay?.toString().split(' ')[0]} - Navigate to payment')),
                  );
                },
                child: Text('Book Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;
  const _Badge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w800,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: AppTheme.dark,
        ),
      ),
    );
  }
}

class _SpecChip extends StatelessWidget {
  final String text;
  const _SpecChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.primary.withOpacity(0.18)),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w700,
          color: AppTheme.dark,
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String label;
  final Color color;
  const _LegendItem({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
              color: AppTheme.grey700,
              fontWeight: FontWeight.w700,
              fontSize: 12),
        ),
      ],
    );
  }
}
