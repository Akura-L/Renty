import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/theme.dart';
import '../../core/responsive.dart';
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
          vertical: RentySpacing.lg,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(RentyRadius.lg),
              child: SizedBox(
                height: 240,
                width: double.infinity,
                child: Image.asset(
                  widget.car.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: RentyColors.surface,
                    child: const Icon(Icons.image_not_supported,
                        size: 50, color: RentyColors.textDisabled),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                if (widget.car.topRated)
                  const _Badge(text: 'TOP RATED', color: RentyColors.primary),
                if (widget.car.availableToday) const SizedBox(width: 12),
                if (widget.car.availableToday)
                  const _Badge(text: 'AVAILABLE', color: RentyColors.success),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("KSh ${widget.car.price.toStringAsFixed(0)} /day",
                  style: RentyTextStyles.displayLarge
                      .copyWith(color: RentyColors.primary)),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${widget.car.location} • ${widget.car.rating.toStringAsFixed(1)} (${widget.car.reviewCount})',
                style: RentyTextStyles.bodyM,
              ),
            ),
            const SizedBox(height: 20),
            const _SectionTitle('Specifications'),
            const SizedBox(height: 10),
            if (widget.car.specs.isEmpty)
              const Text(
                'Specifications will appear here.',
                style: RentyTextStyles.bodyM,
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
            const _SectionTitle('About This Car'),
            const SizedBox(height: 8),
            if (widget.car.about.isNotEmpty)
              Text(
                widget.car.about,
                style: RentyTextStyles.bodyM,
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
            const _SectionTitle('Select Rental Dates'),
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
              calendarStyle: const CalendarStyle(
                defaultTextStyle: RentyTextStyles.bodyM,
                weekendTextStyle: RentyTextStyles.bodyM,
                todayDecoration: BoxDecoration(
                  color: RentyColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: RentyColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Wrap(
              spacing: 16,
              alignment: WrapAlignment.spaceBetween,
              children: [
                _LegendItem(label: 'Selected', color: RentyColors.primary),
                _LegendItem(label: 'Booked', color: RentyColors.error),
                _LegendItem(
                    label: 'Unavailable', color: RentyColors.textDisabled),
              ],
            ),
            const SizedBox(height: 18),
            const _SectionTitle('Reviews'),
            const SizedBox(height: 10),
            if (widget.car.reviews.isEmpty)
              const Text(
                'No reviews yet.',
                style: RentyTextStyles.bodyM,
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
                          radius: 18,
                          backgroundColor: RentyColors.primaryLight,
                          child: Text(
                            r.initials,
                            style: RentyTextStyles.labelL
                                .copyWith(color: RentyColors.primary),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                r.text,
                                style: RentyTextStyles.bodyM,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${r.name} · ${r.monthYear}',
                                style: RentyTextStyles.caption,
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
                child: const Text('Book Now'),
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
        style: RentyTextStyles.headingM,
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
        color: RentyColors.surface,
        borderRadius: BorderRadius.circular(RentyRadius.sm),
      ),
      child: Text(
        text,
        style: RentyTextStyles.bodyS,
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: RentyTextStyles.caption),
      ],
    );
  }
}
