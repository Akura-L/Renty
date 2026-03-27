import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../providers/bookings_provider.dart';
import '../../models/car.dart';
import '../../models/booking.dart';
import '../main_screen.dart';

class ConfirmationScreen extends StatelessWidget {
  final Car car;
  final DateTime startDate;
  final DateTime endDate;
  final double totalAmount;
  final bool paidViaMpesa;

  const ConfirmationScreen({
    super.key,
    required this.car,
    required this.startDate,
    required this.endDate,
    required this.totalAmount,
    this.paidViaMpesa = true,
  });

  String get bookingId => 'RNT-4821';

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newBooking = Booking(
        id: bookingId,
        car: car,
        startDate: startDate,
        endDate: endDate,
        status: 'Confirmed',
        reference: bookingId,
        ownerName: 'David M.',
        pickupLocation: car.location,
        totalPaid: totalAmount,
        ownerPhone: '+254 712 345 678',
      );
      context.read<BookingsProvider>().addBooking(newBooking);
    });

    final days = endDate.difference(startDate).inDays + 1;
    final locationText =
        car.id == '1' ? 'Westlands, Nairobi' : '${car.location}, Kenya';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(RentySpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Icon(Icons.check_circle,
                      size: 110, color: RentyColors.primary),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    'Booking Confirmed!',
                    style: RentyTextStyles.headingXL,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'BOOKING REFERENCE',
                  style: RentyTextStyles.labelL,
                ),
                const SizedBox(height: 8),
                Text(
                  bookingId,
                  style: RentyTextStyles.displayLarge.copyWith(
                    fontSize: 42,
                    color: RentyColors.primary,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Save this for check-in',
                  style: RentyTextStyles.bodyM,
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _formatLongDateRange(startDate, endDate),
                          style: RentyTextStyles.headingS,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$days days · Pickup at 09:00 AM',
                          style: RentyTextStyles.bodyM,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          locationText,
                          style: RentyTextStyles.labelL,
                        ),
                        const SizedBox(height: 12),
                        const Divider(),
                        const SizedBox(height: 12),
                        Text(
                          'KSh ${totalAmount.toStringAsFixed(0)} paid',
                          style: RentyTextStyles.headingM.copyWith(color: RentyColors.primary),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          paidViaMpesa
                              ? 'M-Pesa · +254 712 345 678 PAID'
                              : 'Credit / Debit Card PAID',
                          style: RentyTextStyles.labelM,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'What happens next?',
                  style: RentyTextStyles.headingM,
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _NextStep('Owner notified',
                        'David M. has been alerted and will confirm within 1 hour'),
                    const SizedBox(height: 12),
                    const _NextStep('Confirmation SMS',
                        'You\'ll receive details to +254 712 345 678'),
                    const SizedBox(height: 12),
                    _NextStep('Pickup day',
                        'Head to Westlands, Nairobi at 09:00 AM on ${_formatPickupDay(startDate)}'),
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const MainScreen()),
                    ),
                    child: const Text('Back to Explore'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const MainScreen()),
                      );
                    },
                    child: const Text('View My Booking'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatLongDateRange(DateTime start, DateTime end) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final s = '${months[start.month - 1]} ${start.day}, ${start.year}';
    final e = '${months[end.month - 1]} ${end.day}, ${end.year}';
    if (start.year == end.year) {
      return '${months[start.month - 1]} ${start.day} – ${months[end.month - 1]} ${end.day}, ${end.year}';
    }
    return '$s – $e';
  }

  String _formatPickupDay(DateTime start) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[start.month - 1]} ${start.day}';
  }
}

class _NextStep extends StatelessWidget {
  final String title;
  final String subtitle;
  const _NextStep(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: RentyColors.primaryLight,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, size: 18, color: RentyColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: RentyTextStyles.labelL,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: RentyTextStyles.bodyS,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
