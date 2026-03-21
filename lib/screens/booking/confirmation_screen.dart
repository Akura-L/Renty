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

  const ConfirmationScreen({
    super.key,
    required this.car,
    required this.startDate,
    required this.endDate,
    required this.totalAmount,
  });

  String get bookingId =>
      'RNT-${DateTime.now().millisecondsSinceEpoch ~/ 1000}';

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

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle,
                  size: 120, color: const Color(0xFF00BFA5)),
              const SizedBox(height: 20),
              Text("Booking Confirmed!",
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.dark,
                  )),
              Text(bookingId,
                  style: GoogleFonts.inter(
                    fontSize: 40,
                    color: AppTheme.primary,
                  )),
              const SizedBox(height: 20),
              Text(
                '${car.name}\n${_formatDateRange(startDate, endDate)}',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  color: AppTheme.dark,
                ),
                textAlign: TextAlign.center,
              ),
              Text('KSh ${totalAmount.toStringAsFixed(0)}',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  )),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MainScreen(),
                    ),
                    (route) => false,
                  ),
                  child: Text(
                    "Back to Home",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateRange(DateTime start, DateTime end) {
    return '${start.day}/${start.month} - ${end.day}/${end.month}';
  }
}
