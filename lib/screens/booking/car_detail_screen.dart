import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/theme.dart';
import '../../models/car.dart';
import 'date_picker_screen.dart';

class CarDetailScreen extends StatelessWidget {
  final Car car;

  const CarDetailScreen({
    super.key,
    required this.car,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(car.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.network(car.imageUrl, fit: BoxFit.cover),
            const SizedBox(height: 20),
            Row(
              children: [
                if (car.topRated)
                  _Badge(text: 'TOP RATED', color: AppTheme.primary),
                if (car.availableToday) const SizedBox(width: 10),
                if (car.availableToday)
                  _Badge(text: 'AVAILABLE', color: const Color(0xFF2E7D32)),
              ],
            ),
            const SizedBox(height: 10),
            Text("KSh ${car.price.toStringAsFixed(0)} / day",
                style: GoogleFonts.inter(
                    fontSize: 28,
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(
              '${car.location} • ${car.rating.toStringAsFixed(1)} (${car.reviewCount})',
              style: const TextStyle(
                  color: AppTheme.grey, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _SectionTitle('Specifications'),
            const SizedBox(height: 10),
            if (car.specs.isEmpty)
              Text(
                'Specifications will appear here.',
                style: TextStyle(
                    color: AppTheme.grey700, fontWeight: FontWeight.w600),
              )
            else
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: car.specs
                    .map(
                      (s) => _SpecChip(text: s),
                    )
                    .toList(),
              ),
            const SizedBox(height: 18),
            _SectionTitle('About This Car'),
            const SizedBox(height: 8),
            if (car.about.isNotEmpty)
              Text(
                car.about,
                style: TextStyle(
                    color: AppTheme.grey700, fontWeight: FontWeight.w600),
              ),
            if (car.about.isNotEmpty)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Read more'),
                ),
              ),
            const SizedBox(height: 10),
            _SectionTitle('Availability – June 2025'),
            const SizedBox(height: 10),
            TableCalendar(
              focusedDay: DateTime(2025, 6, 1),
              firstDay: DateTime(2025, 6, 1),
              lastDay: DateTime(2025, 6, 30),
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
              ),
              onDaySelected: (_, __) {},
              selectedDayPredicate: (_) => false,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _LegendItem(label: 'Selected', color: AppTheme.primary),
                _LegendItem(label: 'Booked', color: Color(0xFFB71C1C)),
                _LegendItem(label: 'Unavailable', color: Color(0xFF9E9E9E)),
              ],
            ),
            const SizedBox(height: 18),
            _SectionTitle('Reviews'),
            const SizedBox(height: 10),
            if (car.reviews.isEmpty)
              Text(
                'No reviews yet.',
                style: TextStyle(
                    color: AppTheme.grey700, fontWeight: FontWeight.w600),
              )
            else
              Column(
                children: car.reviews.take(2).map((r) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: AppTheme.primary.withOpacity(0.14),
                          child: Text(
                            r.initials,
                            style: TextStyle(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
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
            if (car.reviewCount > 2)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: Text('See all ${car.reviewCount} reviews'),
                ),
              ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DatePickerScreen(car: car)),
                ),
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
