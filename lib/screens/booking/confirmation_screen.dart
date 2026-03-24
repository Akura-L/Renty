import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
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
      );
      context.read<BookingsProvider>().addBooking(newBooking);
    });

    final days = endDate.difference(startDate).inDays + 1;
    final locationText =
        car.id == '1' ? 'Westlands, Nairobi' : '${car.location}, Kenya';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.check_circle,
                  size: 110, color: Color(0xFF00BFA5)),
              const SizedBox(height: 16),
              Text(
                'Booking Confirmed!',
                style: GoogleFonts.inter(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.dark,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'BOOKING REFERENCE',
                style: TextStyle(
                    color: AppTheme.grey700, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
              Text(
                bookingId,
                style: GoogleFonts.inter(
                  fontSize: 42,
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Save this for check-in',
                style: TextStyle(
                    color: AppTheme.grey700, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 18),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: AppTheme.grey.withOpacity(0.18)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatLongDateRange(startDate, endDate),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '$days days · Pickup at 09:00 AM',
                        style: TextStyle(
                            color: AppTheme.grey700,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        locationText,
                        style: TextStyle(
                            color: AppTheme.grey700,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'KSh ${totalAmount.toStringAsFixed(0)} paid',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: AppTheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        paidViaMpesa
                            ? 'M-Pesa · +254 712 345 678 PAID'
                            : 'Credit / Debit Card PAID',
                        style: TextStyle(
                            color: AppTheme.grey700,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'DM 4.9 · 128 trips',
                        style: TextStyle(
                            color: AppTheme.grey700,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'What happens next?',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: AppTheme.dark,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _NextStep('Owner notified',
                      'David M. has been alerted and will confirm within 1 hour'),
                  const SizedBox(height: 10),
                  _NextStep('Confirmation SMS',
                      'You\'ll receive details to +254 712 345 678'),
                  const SizedBox(height: 10),
                  _NextStep('Pickup day',
                      'Head to Westlands, Nairobi at 09:00 AM on ${_formatPickupDay(startDate)}'),
                  const SizedBox(height: 10),
                ],
              ),
              const Spacer(),
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
                    // Best-effort: jump to MainScreen and let the user open Bookings tab.
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
          decoration: BoxDecoration(
            color: AppTheme.primary.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check, size: 18, color: AppTheme.primary),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w900, color: AppTheme.dark),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                    color: AppTheme.grey700, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
