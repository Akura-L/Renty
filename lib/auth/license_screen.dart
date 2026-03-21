import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../screens/home/home_screen.dart';

class LicenseScreen extends StatefulWidget {
  const LicenseScreen({super.key});

  @override
  State<LicenseScreen> createState() => _LicenseScreenState();
}

class _LicenseScreenState extends State<LicenseScreen> {
  File? _license;

  Future<void> _pickLicense() async {
    final ImagePicker picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _license = File(picked.path));
    }
  }

  void _continue() {
    if (_license == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload your driving license')),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Driver License')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Please upload a clear photo of your driving license',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'We need to verify your driving credentials',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _pickLicense,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _license == null
                    ? const Center(
                        child: Icon(
                          Icons.verified_user,
                          size: 60,
                          color: Color(0xFF00BFA5),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(_license!, fit: BoxFit.cover),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            if (_license != null)
              TextButton(
                onPressed: _pickLicense,
                child: const Text('Upload a different license'),
              ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _continue,
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
