import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../models/car.dart';
import 'confirmation_screen.dart';
import 'widgets/booking_flow_stepper.dart';

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
  String _selectedMethod = 'mpesa';

  @override
  Widget build(BuildContext context) {
    const serviceFee = 3500.0;
    final totalToPay = widget.totalAmount;

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
            child: const Icon(Icons.chevron_left, color: Colors.black, size: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Payment',
          style: TextStyle(color: Color(0xFF2D3E50), fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const BookingFlowStepper(currentStep: 4),
              const SizedBox(height: 32),

              // Car Image Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  widget.car.imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 32),

              const Text(
                'Choose payment method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2D3E50)),
              ),
              const SizedBox(height: 16),

              _buildPaymentOption(
                id: 'mpesa',
                title: 'M-Pesa',
                subtitle: 'Safaricom · Most popular in Kenya',
                icon: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(color: Color(0xFF4CAF50), shape: BoxShape.circle),
                  child: const Center(child: Text('M', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                ),
              ),
              const SizedBox(height: 12),
              _buildPaymentOption(
                id: 'card',
                title: 'Credit / Debit Card',
                subtitle: 'Visa, Mastercard, Amex',
                icon: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: const Color(0xFF2D3E50), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.credit_card, color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(height: 12),
              _buildPaymentOption(
                id: 'bank',
                title: 'Bank Transfer',
                subtitle: 'KCB, Equity, NCBA',
                icon: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(color: Color(0xFF3F51B5), shape: BoxShape.circle),
                  child: const Center(child: Text('KE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                ),
              ),
              const SizedBox(height: 32),

              if (_selectedMethod == 'mpesa') ...[
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F6E8).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF4CAF50).withOpacity(0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 18),
                          SizedBox(width: 8),
                          Text('Pay via M-Pesa', style: TextStyle(color: Color(0xFF4CAF50), fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text('M-Pesa Phone Number', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade100),
                        ),
                        child: Row(
                          children: [
                            const Text('🇰🇪 +254', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text('712 345 678', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                            ),
                            const Icon(Icons.check, color: Color(0xFF4CAF50), size: 16),
                            const SizedBox(width: 4),
                            const Text('Verified', style: TextStyle(color: Color(0xFF4CAF50), fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'You will receive an M-Pesa STK push prompt on this number to authorize payment of KSh 46,000.',
                        style: TextStyle(color: Color(0xFF4CAF50), fontSize: 12, height: 1.4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],

              // Price Breakdown Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Price Breakdown', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF2D3E50))),
                    const SizedBox(height: 16),
                    _buildPriceRow('KSh 8,500 × 5 days', 'KSh 42,500'),
                    const SizedBox(height: 12),
                    _buildPriceRow('Service fee', 'KSh 3,500'),
                    const SizedBox(height: 12),
                    _buildPriceRow('Insurance and protection', 'Free', isGreen: true),
                    const SizedBox(height: 20),
                    const Divider(color: Color(0xFFF1F3F4)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total to pay', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text('KSh ${totalToPay.toInt().toString()}', style: const TextStyle(color: RentyColors.primary, fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline, size: 14, color: Colors.grey.shade400),
                  const SizedBox(width: 4),
                  Text('Secure checkout', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                  const SizedBox(width: 12),
                  Text('|', style: TextStyle(color: Colors.grey.shade300)),
                  const SizedBox(width: 12),
                  Icon(Icons.shield_outlined, size: 14, color: Colors.grey.shade400),
                  const SizedBox(width: 4),
                  Text('Free cancellation 24h', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ConfirmationScreen(
                          car: widget.car,
                          startDate: widget.startDate,
                          endDate: widget.endDate,
                          totalAmount: totalToPay,
                          paidViaMpesa: _selectedMethod == 'mpesa',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RentyColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_selectedMethod == 'mpesa')
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
                          child: const Text('M', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      const SizedBox(width: 12),
                      Text(
                        _selectedMethod == 'mpesa'
                            ? 'Pay KSh ${totalToPay.toInt().toString()} via M-Pesa'
                            : 'Pay KSh ${totalToPay.toInt().toString()} with Card',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'By paying you agree to our Terms and Cancellation Policy',
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required String id,
    required String title,
    required String subtitle,
    required Widget icon,
  }) {
    final bool isSelected = _selectedMethod == id;
    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = id),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? RentyColors.primary : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF2D3E50))),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? RentyColors.primary : Colors.grey.shade300, width: isSelected ? 6 : 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: isGreen ? const Color(0xFF4CAF50) : const Color(0xFF2D3E50),
          ),
        ),
      ],
    );
  }
}
