import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'models/car.dart';
import 'screens/booking/widgets/booking_flow_stepper.dart';
import 'screens/booking/payment_screen.dart';

class TermsScreen extends StatefulWidget {
  final Car car;
  final DateTime? startDate;
  final DateTime? endDate;

  const TermsScreen({
    super.key,
    required this.car,
    this.startDate,
    this.endDate,
  });

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool _agreed = false;
  bool _signed = false;

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
          'Terms and Agreement',
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
              const BookingFlowStepper(currentStep: 3),
              const SizedBox(height: 32),

              // Booking Summary Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(20)),
                      child: Image.asset(widget.car.imageUrl,
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('BOOKING SUMMARY',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(widget.car.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(0xFF2D3E50))),
                              Text(
                                '${_formatDate(widget.startDate)} – ${_formatDate(widget.endDate)} · ${_rentalDays()} days',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Total',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                              Text(
                                  'KSh ${((widget.car.price * _rentalDays()) + 3500).toInt().toString()}',
                                  style: const TextStyle(
                                      color: RentyColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              const Row(
                children: [
                  Icon(Icons.description_outlined,
                      color: RentyColors.primary, size: 20),
                  SizedBox(width: 8),
                  Text('Rental Agreement and Terms',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3E50))),
                ],
              ),
              const SizedBox(height: 24),

              _buildTermItem(
                icon: Icons.directions_car_outlined,
                title: 'Vehicle Return',
                desc:
                    'Return the vehicle in the same condition as received. Late returns are charged at KSh 1,500/hour.',
              ),
              const SizedBox(height: 16),
              _buildTermItem(
                icon: Icons.local_gas_station_outlined,
                title: 'Fuel Policy',
                desc:
                    'Full-to-full policy. Vehicle must be returned with a full tank of fuel.',
              ),
              const SizedBox(height: 16),
              _buildTermItem(
                icon: Icons.security_outlined,
                title: 'Insurance and Liability',
                desc:
                    'Comprehensive insurance included with KSh 50,000 deductible for any damages.',
              ),
              const SizedBox(height: 8),
              Center(
                  child: Text('Scroll to read all terms',
                      style: TextStyle(
                          color: RentyColors.primary.withOpacity(0.6),
                          fontSize: 11))),
              const SizedBox(height: 24),

              // Agreement Checkbox
              GestureDetector(
                onTap: () => setState(() => _agreed = !_agreed),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F6F6).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color:
                            _agreed ? RentyColors.primary : Colors.transparent),
                  ),
                  child: Row(
                    children: [
                      Icon(
                          _agreed
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: RentyColors.primary,
                          size: 20),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'I have read, understood, and agree to the Rental Agreement, Terms & Conditions, and Cancellation Policy.',
                          style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF2D3E50),
                              height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Signature Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.edit_outlined,
                          color: RentyColors.primary, size: 20),
                      SizedBox(width: 8),
                      Text('Your Signature',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3E50))),
                    ],
                  ),
                  if (_signed)
                    const Row(
                      children: [
                        Icon(Icons.check_circle,
                            color: Color(0xFF4CAF50), size: 16),
                        SizedBox(width: 4),
                        Text('Signed',
                            style: TextStyle(
                                color: Color(0xFF4CAF50),
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                  'Sign below to confirm your consent to the rental agreement above.',
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 16),
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: RentyColors.primary, width: 1.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    // Mock signature path
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: CustomPaint(
                          painter: _SignaturePainter(),
                          size: Size.infinite,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () => setState(() => _signed = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color: const Color(0xFFF8F9FA),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade200)),
                          child: const Row(
                            children: [
                              Icon(Icons.refresh, size: 14, color: Colors.grey),
                              SizedBox(width: 4),
                              Text('Clear',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                  child: Text(
                      'Your signature confirms agreement to all terms above',
                      style: TextStyle(color: Colors.grey, fontSize: 10))),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _agreed
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PaymentScreen(
                                car: widget.car,
                                startDate: widget.startDate ?? DateTime.now(),
                                endDate: widget.endDate ??
                                    DateTime.now().add(const Duration(days: 5)),
                                totalAmount:
                                    (widget.car.price * _rentalDays()) + 3500,
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RentyColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    disabledBackgroundColor: Colors.grey.shade300,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.credit_card_outlined,
                          color: Colors.white, size: 20),
                      SizedBox(width: 12),
                      Text('Proceed to Payment',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'By proceeding you agree to our Terms and\nCancellation Policy',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.grey, fontSize: 12, height: 1.5),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  int _rentalDays() {
    if (widget.startDate == null || widget.endDate == null) return 5;
    return widget.endDate!.difference(widget.startDate!).inDays + 1;
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Jun 20';
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
    return '${months[date.month - 1]} ${date.day}';
  }

  Widget _buildTermItem(
      {required IconData icon, required String title, required String desc}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade100),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: Colors.grey, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF2D3E50))),
                const SizedBox(height: 4),
                Text(desc,
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 12, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SignaturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2D3E50)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.1, size.height * 0.4,
        size.width * 0.2, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.3, size.height * 1.0,
        size.width * 0.4, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.2,
        size.width * 0.6, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.7, size.height * 1.0,
        size.width * 0.8, size.height * 0.8);
    path.lineTo(size.width, size.height * 0.8);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
