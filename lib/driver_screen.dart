import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import 'screens/booking/payment_screen.dart';

class DriverScreen extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;

  const DriverScreen({
    super.key,
    this.startDate,
    this.endDate,
  });

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  final List<Map<String, String>> _drivers = [
    {
      'name': 'James Mwangi',
      'phone': '+254 700 123 456',
      'image': 'assets/images/sample_car.jpg'
    },
    {
      'name': 'John Doe',
      'phone': '+254 711 789 012',
      'image': 'assets/images/sample_car.jpg'
    },
  ];
  String? _selectedDriver;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Driver'),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.dark,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.startDate != null && widget.endDate != null) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Rental Period',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(
                        '${widget.startDate!.day}/${widget.startDate!.month} - ${widget.endDate!.day}/${widget.endDate!.month}',
                        style: GoogleFonts.inter(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
            const Text('Available Drivers',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _drivers.length,
                itemBuilder: (context, index) {
                  final driver = _drivers[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/images/sample_car.jpg'),
                      ),
                      title: Text(driver['name']!,
                          style:
                              GoogleFonts.inter(fontWeight: FontWeight.w600)),
                      subtitle: Text(driver['phone']!),
                      trailing: Radio<String>(
                        value: driver['name']!,
                        groupValue: _selectedDriver,
                        onChanged: (value) =>
                            setState(() => _selectedDriver = value),
                      ),
                      onTap: () =>
                          setState(() => _selectedDriver = driver['name']),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedDriver != null
                    ? () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PaymentScreen(
                              startDate: widget.startDate,
                              endDate: widget.endDate,
                              selectedDriver: _selectedDriver!,
                            ),
                          ),
                        )
                    : null,
                style:
                    ElevatedButton.styleFrom(backgroundColor: AppTheme.primary),
                child: const Text('Continue',
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
