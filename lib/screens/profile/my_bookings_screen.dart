import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../providers/bookings_provider.dart';
import '../../core/theme.dart';
import '../../models/booking.dart';
import '../booking/car_detail_screen.dart';
import '../booking/payment_screen.dart';

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
            return RefreshIndicator(
              onRefresh: () => Future.value(),
              child: ListView.builder(
                padding: EdgeInsets.all(AppTheme.kPaddingLarge),
                itemCount: provider.bookings.length,
                itemBuilder: (context, i) =>
                    _buildBookingCard(context, provider.bookings[i], provider),
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
    final totalPrice = booking.car.price * totalDays;
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
                      Text('${booking.car.location} • ${booking.car.year}'),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.date_range,
                              size: 16, color: AppTheme.grey),
                          const SizedBox(width: 4),
                          Text(
                            '${booking.startDate.day}/${booking.startDate.month} - ${booking.endDate.day}/${booking.endDate.month}',
                            style: const TextStyle(color: AppTheme.grey),
                          ),
                        ],
                      ),
                      Text('KSh ${totalPrice.toStringAsFixed(0)} total',
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
                    color: _getStatusColor(booking.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    booking.status,
                    style: TextStyle(
                      color: _getStatusColor(booking.status),
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
                    icon: const Icon(Icons.payment, size: 16),
                    label: const Text('Pay Now'),
                    onPressed: booking.status == 'Pending'
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PaymentScreen(
                                    car: booking.car,
                                    startDate: booking.startDate,
                                    endDate: booking.endDate,
                                    totalAmount: totalPrice),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.visibility, size: 16),
                    label: const Text('View Details'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CarDetailScreen(car: booking.car),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => provider.removeBooking(booking.id),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    return switch (status) {
      'Confirmed' => Colors.green,
      'Pending' => Colors.orange,
      'Completed' => Colors.blue,
      _ => AppTheme.grey,
    };
  }
}
