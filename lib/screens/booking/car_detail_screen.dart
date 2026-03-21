import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import 'date_picker_screen.dart';

class CarDetailScreen extends StatelessWidget {
  const CarDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Toyota Land Cruiser GX V8")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.network("https://picsum.photos/id/1015/600/400",
                fit: BoxFit.cover),
            const SizedBox(height: 20),
            Text("KSh 5,500 / day",
                style: GoogleFonts.inter(
                    fontSize: 28,
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const DatePickerScreen())),
                child: const Text("Continue to Book"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
