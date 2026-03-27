import 'package:flutter/material.dart';
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
      appBar: AppBar(title: const Text('Payment')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(RentySpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose payment method',
                style: RentyTextStyles.headingL,
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
              const Text(
                'BOOKING SUMMARY',
                style: RentyTextStyles.labelL,
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.car.name,
                        style: RentyTextStyles.headingS,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _formatDateRange(widget.startDate, widget.endDate),
                        style: RentyTextStyles.bodyM,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_rentalDays(widget.startDate, widget.endDate)} days',
                        style: RentyTextStyles.bodyM,
                      ),
                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 12),
                      _SummaryLine(
                          'KSh ${widget.car.price.toStringAsFixed(0)} × ${_rentalDays(widget.startDate, widget.endDate)} days',
                          'KSh ${baseRental.toStringAsFixed(0)}'),
                      const SizedBox(height: 8),
                      const _SummaryLine('Service fee', 'KSh 3,500'),
                      const SizedBox(height: 8),
                      const _SummaryLine('Insurance and protection', 'Free'),
                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 12),
                      const Text(
                        'Total to pay',
                        style: RentyTextStyles.labelL,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'KSh ${totalToPay.toStringAsFixed(0)}',
                        style: RentyTextStyles.displayLarge
                            .copyWith(color: RentyColors.primary),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              if (_useMpesa) ...[
                const Text(
                  'M-Pesa Phone Number',
                  style: RentyTextStyles.labelL,
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: RentyColors.border),
                    borderRadius: BorderRadius.circular(RentyRadius.lg),
                  ),
                  child: const Row(
                    children: [
                      Text('🇰🇪 +254 712 ···', style: RentyTextStyles.labelL),
                      Spacer(),
                      Text('Verified',
                          style: TextStyle(
                              color: RentyColors.primary,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'You will receive an M-Pesa STK push prompt on this number to authorize payment.',
                  style: RentyTextStyles.bodyS,
                ),
              ],
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
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
                  ),
                ),
              ),
            ],
          ),
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
      borderRadius: BorderRadius.circular(RentyRadius.lg),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? RentyColors.primary : RentyColors.border,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(RentyRadius.lg),
          color: selected ? RentyColors.primaryLight : RentyColors.background,
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      selected ? RentyColors.primary : RentyColors.textDisabled,
                ),
              ),
              child: selected
                  ? const Center(
                      child: CircleAvatar(
                        radius: 6,
                        backgroundColor: RentyColors.primary,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: RentyTextStyles.labelL),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: RentyTextStyles.bodyS,
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

class _SummaryLine extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryLine(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: RentyTextStyles.bodyM),
        Text(value, style: RentyTextStyles.labelL),
      ],
    );
  }
}

class _BookingStepIndicator extends StatelessWidget {
  final int activeStep;
  const _BookingStepIndicator({required this.activeStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _step(1, 'Dates', activeStep >= 1),
        _line(activeStep >= 2),
        _step(2, 'Protection', activeStep >= 2),
        _line(activeStep >= 3),
        _step(3, 'Payment', activeStep >= 3),
      ],
    );
  }

  Widget _step(int n, String label, bool active) {
    return Column(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: active ? RentyColors.primary : RentyColors.surface,
          child: Text(
            n.toString(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: active ? Colors.white : RentyColors.textDisabled,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
            color: active ? RentyColors.primary : RentyColors.textDisabled,
          ),
        ),
      ],
    );
  }

  Widget _line(bool active) {
    return Expanded(
      child: Container(
        height: 2,
        color: active ? RentyColors.primary : RentyColors.surface,
        margin: const EdgeInsets.only(bottom: 14),
      ),
    );
  }
}

