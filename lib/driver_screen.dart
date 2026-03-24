import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme.dart';
import 'models/car.dart';
import 'screens/booking/payment_screen.dart';

class DriverScreen extends StatefulWidget {
  final Car car;
  final DateTime? startDate;
  final DateTime? endDate;

  const DriverScreen({
    super.key,
    required this.car,
    this.startDate,
    this.endDate,
  });

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  final _specialRequestsController = TextEditingController(
    text: 'Please ensure the car is at Jomo Kenyatta airport terminal 1B',
  );

  @override
  void dispose() {
    _specialRequestsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final start = widget.startDate ?? DateTime.now();
    final end = widget.endDate ?? DateTime.now();
    final totalDays = end.difference(start).inDays + 1;
    final tripTotal = widget.car.price * (totalDays <= 0 ? 1 : totalDays);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _BookingStepIndicator(activeStep: 2),
            const SizedBox(height: 12),
            Text(
              'Driver Information',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppTheme.dark,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Who's driving?",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
            const SizedBox(height: 6),
            Text(
              'We\'ve pre-filled your details from your account.\nDetails loaded from your verified Renty profile',
              style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w600),
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
                    Row(
                      children: [
                        const Text('Primary Driver',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Edit'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _InfoRow(label: 'First Name', value: 'James'),
                    const SizedBox(height: 10),
                    _InfoRow(label: 'Last Name', value: 'Mwangi'),
                    const SizedBox(height: 10),
                    _InfoRow(label: 'Phone Number', value: '+254 712 345 678'),
                    const SizedBox(height: 10),
                    _InfoRow(label: 'Email Address', value: 'james@example.com'),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Driver’s Licence No.',
                                  style: TextStyle(
                                    color: AppTheme.grey,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12,
                                  )),
                              SizedBox(height: 6),
                              Text('KE-DL-2019-847231',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Text(
                            'Verified',
                            style: TextStyle(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Add a second driver'),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Free · Both drivers must be 23+',
                      style: TextStyle(color: AppTheme.grey, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Special Requests (optional)',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _specialRequestsController,
                      minLines: 2,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Please ensure the car is at the pickup location',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'YOUR TRIP',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(
              '${start.month <= 0 ? '' : start.day}/${start.month}/${start.year} - ${end.day}/${end.month}/${end.year}',
              style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              '${totalDays} days · KSh ${tripTotal.toStringAsFixed(0)} total',
              style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w900),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PaymentScreen(
                      car: widget.car,
                      startDate: start,
                      endDate: end,
                      totalAmount: tripTotal,
                    ),
                  ),
                ),
                style:
                    ElevatedButton.styleFrom(backgroundColor: AppTheme.primary),
                child: const Text('Continue to Payment',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppTheme.grey, fontWeight: FontWeight.w800, fontSize: 12),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
      ],
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
                color: isActive ? AppTheme.primary : Colors.grey.shade600,
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
