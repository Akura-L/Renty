import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../models/car.dart';
import 'confirmation_screen.dart';

class PaymentScreen extends StatelessWidget {
  final Car car;
  final DateTime startDate;
  final DateTime endDate;
  final double totalAmount;

  const PaymentScreen({
    super.key,
    required this.car,
    required this.startDate,
    required this.endDate,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment',
            style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Total: KSh ${totalAmount.toStringAsFixed(0)}',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.dark,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ConfirmationScreen(
                      car: car,
                      startDate: startDate,
                      endDate: endDate,
                      totalAmount: totalAmount,
                    ),
                  ),
                ),
                child: Text(
                  "Pay KSh ${totalAmount.toStringAsFixed(0)}",
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
    );
  }
}
