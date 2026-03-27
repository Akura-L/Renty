import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'core/theme.dart';
import 'models/car.dart';
import 'screens/booking/widgets/booking_flow_stepper.dart';
import 'terms_screen.dart';

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
  bool _isChauffeur = false;

  @override
  void dispose() {
    _specialRequestsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child:
                const Icon(Icons.chevron_left, color: Colors.black, size: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Driver Information',
          style: TextStyle(
              color: Color(0xFF2D3E50),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const BookingFlowStepper(currentStep: 2),
              const SizedBox(height: 32),

              const Text(
                "Who's driving?",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3E50)),
              ),
              const SizedBox(height: 8),
              const Text(
                "We've pre-filled your details from your account.",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 24),

              // Mode Toggle
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F3F5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _modeTab(
                        label: 'Drive Yourself',
                        active: !_isChauffeur,
                        onTap: () => setState(() => _isChauffeur = false),
                      ),
                    ),
                    Expanded(
                      child: _modeTab(
                        label: 'With Chauffeur',
                        active: _isChauffeur,
                        onTap: () => setState(() => _isChauffeur = true),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Success Banner
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F6E8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.check_circle,
                        color: Color(0xFF4CAF50), size: 18),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Details loaded from your verified Renty profile',
                        style: TextStyle(
                            color: Color(0xFF4CAF50),
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Form
              Row(
                children: [
                  Expanded(
                      child: _buildInputField(
                          label: 'First Name', value: 'James')),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _buildInputField(
                          label: 'Last Name', value: 'Mwangi')),
                ],
              ),
              const SizedBox(height: 16),
              _buildInputField(
                  label: 'Phone Number', value: '+254 712 345 678'),
              const SizedBox(height: 16),
              _buildInputField(
                  label: 'Email Address', value: 'james@example.com'),
              const SizedBox(height: 16),
              _buildLicenceField(
                  label: "Driver's Licence No.", value: 'KE-DL-2019-847231'),
              const SizedBox(height: 24),

              CustomPaint(
                painter: _DottedBorderPainter(),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Color(0xFFF8F9FA), shape: BoxShape.circle),
                        child: const Icon(Icons.person_add_alt_1_outlined,
                            color: Colors.grey, size: 20),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Add a second driver',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            Text('Free · Both drivers must be 23+',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right,
                          color: Colors.grey, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Special Requests (optional)',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF2D3E50)),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _specialRequestsController,
                maxLines: 3,
                decoration: InputDecoration(
                  fillColor: const Color(0xFFF8F9FA),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 32),

              // Bottom Trip Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D3E50),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('YOUR TRIP',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          const Text('Jun 20 – Jun 25, 2025',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                          const SizedBox(height: 2),
                          const Text('5 days · KSh 46,000 total',
                              style: TextStyle(
                                  color: RentyColors.primary, fontSize: 12)),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(widget.car.imageUrl,
                          width: 80, height: 50, fit: BoxFit.cover),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TermsScreen(
                          car: widget.car,
                          startDate: widget.startDate,
                          endDate: widget.endDate,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RentyColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Continue to Terms',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _modeTab(
      {required String label,
      required bool active,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: active ? RentyColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: active ? Colors.white : Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xFF2D3E50))),
        ),
      ],
    );
  }

  Widget _buildLicenceField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Row(
            children: [
              const Icon(Icons.description_outlined,
                  color: RentyColors.primary, size: 20),
              const SizedBox(width: 12),
              Expanded(
                  child: Text(value,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xFF2D3E50)))),
              const Icon(Icons.check_circle,
                  color: Color(0xFF4CAF50), size: 16),
              const SizedBox(width: 4),
              const Text('Verified',
                  style: TextStyle(
                      color: Color(0xFF4CAF50),
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}

class _DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const dashWidth = 5.0;
    const dashSpace = 3.0;
    final radius = Radius.circular(16.0);
    final RRect rRect = RRect.fromLTRBR(0, 0, size.width, size.height, radius);
    final Path path = Path()..addRRect(rRect);

    final Path dashPath = Path();
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final double end = distance + dashWidth;
        dashPath.addPath(
          metric.extractPath(distance, end),
          Offset.zero,
        );
        distance = end + dashSpace;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
