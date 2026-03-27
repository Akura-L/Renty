import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';

import '../../core/theme.dart';
import '../../core/responsive.dart';
import '../../models/car.dart';
import '../../providers/favourites_provider.dart';
import 'date_picker_screen.dart';

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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Header
                Stack(
                  children: [
                    Image.asset(
                      widget.car.imageUrl,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 10,
                      left: 20,
                      child: _buildCircleButton(
                        icon: Icons.chevron_left,
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 10,
                      right: 20,
                      child: Row(
                        children: [
                          _buildCircleButton(
                            icon: Icons.share_outlined,
                            onTap: () {},
                          ),
                          const SizedBox(width: 12),
                          Consumer<FavouritesProvider>(
                            builder: (context, provider, _) {
                              final isFav = provider.isFavourite(widget.car.id);
                              return _buildCircleButton(
                                icon: isFav ? Icons.favorite : Icons.favorite_border,
                                iconColor: isFav ? Colors.red : Colors.black,
                                onTap: () => provider.toggleFavourite(widget.car.id),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Details Section
                Transform.translate(
                  offset: const Offset(0, -24),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (widget.car.topRated)
                              _buildStatusBadge('TOP RATED', const Color(0xFFE8F6F6), RentyColors.primary),
                            if (widget.car.topRated) const SizedBox(width: 8),
                            if (widget.car.availableToday)
                              _buildStatusBadge('AVAILABLE', const Color(0xFFE8F6E8), const Color(0xFF4CAF50)),
                            const Spacer(),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'KSh ${widget.car.price.toInt().toString()}',
                                    style: const TextStyle(
                                      color: RentyColors.primary,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' /day',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${widget.car.name}\n${widget.car.subName}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3E50),
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: RentyColors.primary, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              widget.car.exactLocation,
                              style: const TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            const SizedBox(width: 16),
                            const Icon(Icons.star, color: Color(0xFFFFC107), size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.car.rating} (${widget.car.reviewCount})',
                              style: const TextStyle(
                                color: Color(0xFF2D3E50),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        const Text(
                          'Specifications',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3E50),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildSpecsGrid(),
                        const SizedBox(height: 32),

                        // Host Section
                        _buildHostSection(),
                        const SizedBox(height: 32),

                        const Text(
                          'About This Car',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3E50),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.car.about,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Read more >',
                            style: TextStyle(
                              color: RentyColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Availability
                        Text(
                          'Availability – June 2025',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3E50),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildCalendar(),
                        const SizedBox(height: 32),

                        // Reviews
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Reviews',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D3E50),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Color(0xFFFFC107), size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  '${widget.car.rating} (${widget.car.reviewCount})',
                                  style: const TextStyle(
                                    color: Color(0xFF2D3E50),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildReviewsList(),
                        const SizedBox(height: 100), // Bottom bar padding
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFCCE8E8)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.chat_bubble_outline, color: RentyColors.primary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DatePickerScreen(car: widget.car),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: RentyColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Book Now',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = Colors.black,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 24),
      ),
    );
  }

  Widget _buildStatusBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSpecsGrid() {
    final specs = [
      {'icon': Icons.people_outline, 'label': '7 Seats'},
      {'icon': Icons.settings_outlined, 'label': 'Automatic'},
      {'icon': Icons.local_gas_station_outlined, 'label': 'Diesel'},
      {'icon': Icons.ac_unit, 'label': 'Full A/C'},
      {'icon': Icons.speed, 'label': '300km/day'},
      {'icon': Icons.settings_input_component, 'label': '4WD'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.2,
      ),
      itemCount: specs.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(specs[index]['icon'] as IconData, color: RentyColors.primary, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  specs[index]['label'] as String,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF2D3E50), fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHostSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: RentyColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'DM',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'David M.',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF2D3E50)),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 16),
                    const SizedBox(width: 4),
                    const Text('Verified', style: TextStyle(color: Color(0xFF4CAF50), fontSize: 12)),
                  ],
                ),
                const Text(
                  '18 months · 98% response rate',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
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
            defaultTextStyle: TextStyle(color: Color(0xFF2D3E50)),
            weekendTextStyle: TextStyle(color: Color(0xFFE53935)),
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
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildReviewsList() {
    final reviews = [
      {
        'initials': 'SK',
        'name': 'Sarah K.',
        'date': 'May 2025',
        'text': 'Absolutely loved this car! Clean, drives smoothly. David was super helpful at pickup. Will rent again!',
        'rating': 5,
      },
      {
        'initials': 'MO',
        'name': 'Michael O.',
        'date': 'Apr 2025',
        'text': 'Great for our Maasai Mara trip. Handles city and rough roads perfectly. Highly recommend!',
        'rating': 5,
      },
    ];

    return Column(
      children: [
        ...reviews.map((r) => Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: RentyColors.primary,
                    child: Text(r['initials'] as String, style: const TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(r['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Text(r['date'] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                  Row(
                    children: List.generate(5, (i) => Icon(Icons.star, color: i < (r['rating'] as int) ? const Color(0xFFFFC107) : Colors.grey.shade200, size: 14)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                r['text'] as String,
                style: const TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
              ),
            ],
          ),
        )),
        GestureDetector(
          onTap: () {},
          child: const Text(
            'See all 128 reviews >',
            style: TextStyle(color: RentyColors.primary, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
