import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../providers/bookings_provider.dart';
import '../../models/car.dart';
import '../../models/booking.dart';
import '../main_screen.dart';
import 'widgets/booking_flow_stepper.dart';

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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              const BookingFlowStepper(currentStep: 5),
              const SizedBox(height: 32),

              // Success Icon
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F6F6),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child:
                      Icon(Icons.check, color: RentyColors.primary, size: 40),
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Booking Confirmed!',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3E50)),
              ),
              const SizedBox(height: 8),
              Text(
                'Your ${car.name} is reserved. Get\nready for an incredible drive!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.grey, fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 32),

              // Booking Reference Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: RentyColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('BOOKING REFERENCE',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(bookingId,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24)),
                          const SizedBox(height: 2),
                          const Text('Save this for check-in',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 11)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle),
                      child: const Icon(Icons.share_outlined,
                          color: Colors.white, size: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Car Details Overlay Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: [
                      Image.asset(car.imageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover),
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.8)
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Column(
                          children: [
                            _buildInfoRow(
                                Icons.calendar_today_outlined,
                                'Jun 20 – Jun 25, 2025',
                                '5 days · Pickup at 09:00 AM'),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                                Icons.location_on_outlined,
                                'Westlands, Nairobi',
                                'Exact address in your confirmation SMS'),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFE8F6E8)
                                          .withOpacity(0.3),
                                      shape: BoxShape.circle),
                                  child: const Icon(Icons.check,
                                      color: Color(0xFFE8F6E8), size: 16),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'KSh ${totalAmount.toInt().toString()} paid',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                      Text(
                                          paidViaMpesa
                                              ? 'M-Pesa · +254 712 345 678'
                                              : 'Card · **** 4242',
                                          style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 11)),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFE8F6E8),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: const Text('PAID',
                                      style: TextStyle(
                                          color: Color(0xFF4CAF50),
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Host Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade100),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                          color: RentyColors.primary, shape: BoxShape.circle),
                      child: const Center(
                          child: Text('DM',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('David M.',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color(0xFF2D3E50))),
                          Row(
                            children: [
                              Icon(Icons.star,
                                  color: Color(0xFFFFC107), size: 14),
                              SizedBox(width: 4),
                              Text('4.9 · 128 trips',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _buildCircleIcon(Icons.phone_outlined),
                    const SizedBox(width: 12),
                    _buildCircleIcon(Icons.chat_bubble_outline, isFilled: true),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text('What happens next?',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3E50))),
              ),
              const SizedBox(height: 16),
              _buildTimelineStep(1, 'Owner notified',
                  'David M. has been alerted and will confirm within 1 hour',
                  isCompleted: true),
              _buildTimelineStep(2, 'Confirmation SMS',
                  'You\'ll receive details to +254 712 345 678'),
              _buildTimelineStep(3, 'Pickup day',
                  'Head to Westlands, Nairobi at 09:00 AM on Jun 20'),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const MainScreen()),
                    (route) => false,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RentyColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.directions_car_outlined,
                          color: Colors.white, size: 20),
                      const SizedBox(width: 12),
                      const Text('View My Booking',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const MainScreen()),
                    (route) => false,
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade200),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Back to Explore',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                ),
              ),
              const SizedBox(height: 32),

              // Review Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9E6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star,
                                color: Color(0xFFFFC107), size: 16),
                            Icon(Icons.star,
                                color: Color(0xFFFFC107), size: 16),
                            Icon(Icons.star,
                                color: Color(0xFFFFC107), size: 16),
                            Icon(Icons.star,
                                color: Color(0xFFFFC107), size: 16),
                            Icon(Icons.star,
                                color: Color(0xFFFFC107), size: 16),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'After your trip, leave a review to help other drivers find great cars!',
                        style: TextStyle(
                            color: Color(0xFF856404),
                            fontSize: 12,
                            height: 1.4),
                      ),
                    ),
                    Icon(Icons.chevron_right,
                        color: const Color(0xFFFFC107), size: 18),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14)),
              Text(subtitle,
                  style: const TextStyle(color: Colors.white70, fontSize: 11)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCircleIcon(IconData icon, {bool isFilled = false}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isFilled ? RentyColors.primary : Colors.transparent,
        shape: BoxShape.circle,
        border: isFilled ? null : Border.all(color: const Color(0xFFCCE8E8)),
      ),
      child: Icon(icon,
          color: isFilled ? Colors.white : RentyColors.primary, size: 20),
    );
  }

  Widget _buildTimelineStep(int index, String title, String desc,
      {bool isCompleted = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: isCompleted
                  ? const Color(0xFF4CAF50)
                  : const Color(0xFFF1F3F4),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : Text(index.toString(),
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isCompleted
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFF2D3E50))),
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
