import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/bookings_provider.dart';
import '../../core/theme.dart';
import '../../models/booking.dart';
import 'messages_screen.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        actions: const [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=68'),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Consumer<BookingsProvider>(
        builder: (context, provider, child) {
          if (provider.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today_outlined,
                      size: 80, color: RentyColors.textDisabled),
                  SizedBox(height: 16),
                  Text('No bookings yet', style: RentyTextStyles.headingM),
                  Text('Book your first car!',
                      style: RentyTextStyles.bodyM),
                ],
              ),
            );
          }
          return DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: 'Upcoming'),
                    Tab(text: 'Past'),
                    Tab(text: 'Cancelled'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildBookingsTab(
                        context: context,
                        provider: provider,
                        bookings: provider.upcomingBookings,
                      ),
                      _buildBookingsTab(
                        context: context,
                        provider: provider,
                        bookings: provider.pastBookings,
                      ),
                      _buildBookingsTab(
                        context: context,
                        provider: provider,
                        bookings: provider.cancelledBookings,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBookingCard(
      BuildContext context, Booking booking, BookingsProvider provider) {
    final totalDays = booking.endDate.difference(booking.startDate).inDays + 1;

    return Card(
      margin: const EdgeInsets.only(bottom: RentySpacing.md),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(RentyRadius.md),
                  child: Image.asset(
                    booking.car.imageUrl,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 80,
                      width: 80,
                      color: RentyColors.surface,
                      child: const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(booking.car.name,
                          style: RentyTextStyles.headingS),
                      Text(booking.reference,
                          style: RentyTextStyles.caption),
                      Text('${booking.car.location} • ${booking.car.year}',
                          style: RentyTextStyles.bodyS),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 14, color: RentyColors.textSecondary),
                          const SizedBox(width: 4),
                          Text(
                            '${booking.startDate.day}/${booking.startDate.month} - ${booking.endDate.day}/${booking.endDate.month}',
                            style: RentyTextStyles.bodyS,
                          ),
                        ],
                      ),
                      Text('KSh ${booking.totalPaid.toStringAsFixed(0)} paid',
                          style: RentyTextStyles.labelM.copyWith(
                            color: RentyColors.primary,
                          )),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: RentyColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(RentyRadius.pill),
                  ),
                  child: Text(
                    booking.status.toUpperCase(),
                    style: const TextStyle(
                      color: RentyColors.success,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.phone, size: 16),
                    label: const Text('Call Owner'),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Calling ${booking.ownerName}...')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.message, size: 16),
                    label: const Text('Message'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MessagesScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingsTab({
    required BuildContext context,
    required BookingsProvider provider,
    required List<Booking> bookings,
  }) {
    if (bookings.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today_outlined, size: 60, color: RentyColors.textDisabled),
            SizedBox(height: 16),
            Text('No bookings found', style: RentyTextStyles.bodyM),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      itemBuilder: (context, i) =>
          _buildBookingCard(context, bookings[i], provider),
    );
  }
}
