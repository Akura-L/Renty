import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../providers/bookings_provider.dart';
import '../../core/theme.dart';
import '../../models/booking.dart';
import '../booking/car_detail_screen.dart';
import '../booking/payment_screen.dart';
import 'messages_screen.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: context.watch<BookingsProvider>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Bookings',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
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
                        size: 80, color: AppTheme.grey),
                    SizedBox(height: 16),
                    Text('No bookings yet', style: TextStyle(fontSize: 18)),
                    Text('Book your first car!',
                        style: TextStyle(color: AppTheme.grey)),
                  ],
                ),
              );
            }
            return DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    labelColor: AppTheme.primary,
                    unselectedLabelColor: AppTheme.grey,
                    indicatorColor: AppTheme.primary,
                    tabs: [
                      Tab(text: 'Upcoming (${provider.upcomingBookings.length})'),
                      Tab(text: 'Past (${provider.pastBookings.length})'),
                      Tab(text: 'Cancelled (${provider.cancelledBookings.length})'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildBookingsTab(
                          context: context,
                          provider: provider,
                          title: 'Upcoming',
                          bookings: provider.upcomingBookings,
                        ),
                        _buildBookingsTab(
                          context: context,
                          provider: provider,
                          title: 'Past',
                          bookings: provider.pastBookings,
                        ),
                        _buildBookingsTab(
                          context: context,
                          provider: provider,
                          title: 'Cancelled',
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
      ),
    );
  }

  Widget _buildBookingCard(
      BuildContext context, Booking booking, BookingsProvider provider) {
    final totalDays = booking.endDate.difference(booking.startDate).inDays + 1;

    return Card(
      margin: EdgeInsets.only(bottom: AppTheme.kPaddingMedium),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(AppTheme.kPaddingMedium),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    booking.car.imageUrl,
                    height: AppTheme.kThumbnailHeight,
                    width: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: AppTheme.kThumbnailHeight,
                      width: AppTheme.kThumbnailWidth,
                      color: Colors.grey[300],
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
                          style:
                              GoogleFonts.inter(fontWeight: FontWeight.bold)),
                      Text(booking.reference,
                          style: TextStyle(
                              fontSize: AppTheme.kFontSizeSmall,
                              color: AppTheme.grey)),
                      Text('${booking.car.location} • ${booking.car.year}'),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 16, color: AppTheme.grey),
                          const SizedBox(width: 4),
                          Text(
                            'Pickup: ${booking.startDate.day}/${booking.startDate.month} | Return: ${booking.endDate.day}/${booking.endDate.month}',
                            style: const TextStyle(color: AppTheme.grey),
                          ),
                        ],
                      ),
                      Text('$totalDays days',
                          style: TextStyle(
                              fontSize: AppTheme.kFontSizeSmall,
                              color: AppTheme.grey)),
                      Text('Owner: ${booking.ownerName}',
                          style: TextStyle(
                              fontSize: AppTheme.kFontSizeSmall,
                              fontWeight: FontWeight.w600)),
                      Text(booking.pickupLocation,
                          style: TextStyle(
                              fontSize: AppTheme.kFontSizeSmall,
                              color: AppTheme.grey)),
                      Text('KSh ${booking.totalPaid.toStringAsFixed(0)} paid',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primary,
                          )),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    booking.status.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
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
    required String title,
    required List<Booking> bookings,
  }) {
    if (bookings.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today_outlined, size: 80, color: AppTheme.grey),
            SizedBox(height: 16),
            Text('No bookings yet', style: TextStyle(fontSize: 18)),
            Text('Book your first car!',
                style: TextStyle(color: AppTheme.grey)),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () => Future.value(),
      child: ListView.separated(
        padding: EdgeInsets.all(AppTheme.kPaddingLarge),
        itemCount: bookings.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, i) =>
            _buildBookingCard(context, bookings[i], provider),
      ),
    );
  }
}
