import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../models/car.dart';
import 'confirmation_screen.dart';

class PaymentScreen extends StatefulWidget {
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
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _useMpesa = true;

  @override
  Widget build(BuildContext context) {
    final baseRental = widget.totalAmount;
    const serviceFee = 3500.0;
    final totalToPay = baseRental + serviceFee;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose payment method',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: AppTheme.dark,
              ),
            ),
            const SizedBox(height: 6),
            const _BookingStepIndicator(activeStep: 3),
            const SizedBox(height: 18),
            _PaymentOption(
              title: 'M-Pesa',
              subtitle: 'Safaricom · Most popular in Kenya',
              selected: _useMpesa,
              onTap: () => setState(() => _useMpesa = true),
            ),
            const SizedBox(height: 12),
            _PaymentOption(
              title: 'Credit / Debit Card',
              subtitle: 'Visa, Mastercard, Amex',
              selected: !_useMpesa,
              onTap: () => setState(() => _useMpesa = false),
            ),
            const SizedBox(height: 18),
            Text(
              'BOOKING SUMMARY',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w900,
                fontSize: 14,
                color: AppTheme.dark,
              ),
            ),
            const SizedBox(height: 12),
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
                      widget.car.name,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_formatDateRange(widget.startDate, widget.endDate)}',
                      style: TextStyle(
                          color: AppTheme.grey700, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_rentalDays(widget.startDate, widget.endDate)} days',
                      style: TextStyle(
                          color: AppTheme.grey700, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Divider(color: AppTheme.grey.withOpacity(0.22)),
                    const SizedBox(height: 8),
                    _SummaryLine(
                        'KSh ${widget.car.price.toStringAsFixed(0)} × ${_rentalDays(widget.startDate, widget.endDate)} days',
                        'KSh ${baseRental.toStringAsFixed(0)}'),
                    const SizedBox(height: 6),
                    const _SummaryLine('Service fee', 'KSh 3,500'),
                    const SizedBox(height: 6),
                    const _SummaryLine('Insurance and protection', 'Free'),
                    const SizedBox(height: 10),
                    Divider(color: AppTheme.grey.withOpacity(0.22)),
                    const SizedBox(height: 10),
                    Text(
                      'Total to pay',
                      style: TextStyle(
                          color: AppTheme.grey700, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'KSh ${totalToPay.toStringAsFixed(0)}',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            if (_useMpesa) ...[
              Text(
                'M-Pesa Phone Number',
                style: TextStyle(
                    color: AppTheme.grey700,
                    fontWeight: FontWeight.w900,
                    fontSize: 13),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.grey.withOpacity(0.25)),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: const [
                    Text('🇰🇪 +254 712 ···',
                        style: TextStyle(fontWeight: FontWeight.w800)),
                    Spacer(),
                    Text('Verified',
                        style: TextStyle(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.w900)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'You will receive an M-Pesa STK push prompt on this number to authorize payment of KSh ${totalToPay.toStringAsFixed(0)}.',
                style: TextStyle(
                    color: AppTheme.grey700, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
            ],
            const Spacer(),
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
                      car: widget.car,
                      startDate: widget.startDate,
                      endDate: widget.endDate,
                      totalAmount: totalToPay,
                      paidViaMpesa: _useMpesa,
                    ),
                  ),
                ),
                child: Text(
                  _useMpesa
                      ? 'Pay KSh ${totalToPay.toStringAsFixed(0)} via M-Pesa'
                      : 'Pay KSh ${totalToPay.toStringAsFixed(0)} with card',
                  textAlign: TextAlign.center,
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

  int _rentalDays(DateTime start, DateTime end) {
    return end.difference(start).inDays + 1;
  }

  String _formatDateRange(DateTime start, DateTime end) {
    const month = [
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
    final s = '${start.day} ${month[start.month - 1]}';
    final e = '${end.day} ${month[end.month - 1]}';
    return '$s – $e, ${end.year}';
  }
}

class _PaymentOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _PaymentOption({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color:
                selected ? AppTheme.primary : AppTheme.grey.withOpacity(0.22),
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? AppTheme.primary
                      : AppTheme.grey.withOpacity(0.55),
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.primary,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.w900)),
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
        ),
      ),
    );
  }
}

class _BookingStepIndicator extends StatelessWidget {
  final int activeStep; // 1..4
  const _BookingStepIndicator({required this.activeStep});

  @override
  Widget build(BuildContext context) {
    Widget step(String label, int idx) {
      final isActive = idx == activeStep;
      return Expanded(
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isActive ? AppTheme.primary : AppTheme.grey600,
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              height: 3,
              width: 26,
              decoration: BoxDecoration(
                color: isActive ? AppTheme.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      );
    }

    return Row(
      children: [
        step('Dates', 1),
        step('Driver', 2),
        step('Payment', 3),
        step('Done', 4),
      ],
    );
  }
}

class _SummaryLine extends StatelessWidget {
  final String left;
  final String right;
  const _SummaryLine(this.left, this.right);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(left,
              style: TextStyle(
                  color: AppTheme.grey700, fontWeight: FontWeight.w600)),
        ),
        Text(right, style: GoogleFonts.inter(fontWeight: FontWeight.w900)),
      ],
    );
  }
}
