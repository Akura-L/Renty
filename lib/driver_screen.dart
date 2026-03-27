import 'package:flutter/material.dart';
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
      appBar: AppBar(title: const Text('Driver Information')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(RentySpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _BookingStepIndicator(activeStep: 2),
            const SizedBox(height: 18),
            const Text(
              "Who's driving?",
              style: RentyTextStyles.headingL,
            ),
            const SizedBox(height: 8),
            const Text(
              'We\'ve pre-filled your details from your account. Details loaded from your verified Renty profile',
              style: RentyTextStyles.bodyM,
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('Primary Driver',
                            style: RentyTextStyles.labelL),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Edit'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const _InfoRow(label: 'First Name', value: 'James'),
                    const SizedBox(height: 12),
                    const _InfoRow(label: 'Last Name', value: 'Mwangi'),
                    const SizedBox(height: 12),
                    const _InfoRow(label: 'Phone Number', value: '+254 712 345 678'),
                    const SizedBox(height: 12),
                    const _InfoRow(label: 'Email Address', value: 'james@example.com'),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Driver’s Licence No.',
                                  style: RentyTextStyles.caption),
                              SizedBox(height: 4),
                              Text('KE-DL-2019-847231',
                                  style: RentyTextStyles.labelL),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: RentyColors.primaryLight,
                            borderRadius: BorderRadius.circular(RentyRadius.pill),
                          ),
                          child: const Text(
                            'Verified',
                            style: TextStyle(
                              color: RentyColors.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Add a second driver'),
                    ),
                    const Text(
                      'Free · Both drivers must be 23+',
                      style: RentyTextStyles.caption,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Special Requests (optional)',
                      style: RentyTextStyles.labelL,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _specialRequestsController,
                      minLines: 2,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'e.g. Please ensure the car is at terminal 1B',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'YOUR TRIP',
              style: RentyTextStyles.labelL,
            ),
            const SizedBox(height: 8),
            Text(
              '${start.day}/${start.month}/${start.year} - ${end.day}/${end.month}/${end.year}',
              style: RentyTextStyles.bodyM,
            ),
            const SizedBox(height: 4),
            Text(
              '$totalDays days · KSh ${tripTotal.toStringAsFixed(0)} total',
              style: RentyTextStyles.headingM.copyWith(color: RentyColors.primary),
            ),
            const SizedBox(height: 32),
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
                child: const Text('Continue to Payment'),
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
          style: RentyTextStyles.caption,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: RentyTextStyles.labelL,
        ),
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
        _step(2, 'Driver', activeStep >= 2),
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
