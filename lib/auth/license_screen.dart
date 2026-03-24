import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../core/theme.dart';
import '../screens/main_screen.dart';
import 'widgets/auth_flow_stepper.dart';

class LicenseScreen extends StatefulWidget {
  const LicenseScreen({super.key});

  @override
  State<LicenseScreen> createState() => _LicenseScreenState();
}

class _LicenseScreenState extends State<LicenseScreen> {
  File? _frontLicense;
  File? _backLicense;

  Future<void> _pickLicense({required bool forBack}) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    setState(() {
      if (forBack) {
        _backLicense = File(picked.path);
      } else {
        _frontLicense = File(picked.path);
      }
    });
  }

  bool get _canSubmit => _frontLicense != null && _backLicense != null;

  void _submit() {
    if (!_canSubmit) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please upload both sides of your licence')),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthFlowStepper(currentStep: 5),
              const SizedBox(height: 18),
              Text(
                'Upload your licence',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.dark,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Required for insurance purposes. Upload both sides of your valid driver\'s licence.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppTheme.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'Front Side — ${_frontLicense != null ? "Uploaded" : "Tap to upload"}',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              _LicenseUploadTile(
                imageFile: _frontLicense,
                onTap: () => _pickLicense(forBack: false),
                placeholderIcon: Icons.badge_outlined,
              ),
              const SizedBox(height: 18),
              Text(
                'Back Side — ${_backLicense != null ? "Uploaded" : "Required"}',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              _LicenseUploadTile(
                imageFile: _backLicense,
                onTap: () => _pickLicense(forBack: true),
                placeholderIcon: Icons.badge,
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => _pickLicense(forBack: true),
                child: const Text(
                    'Upload the back side of your licence to continue'),
              ),
              const SizedBox(height: 14),
              Text(
                'Photo tips',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppTheme.dark,
                ),
              ),
              const SizedBox(height: 8),
              const _TipLine('Full licence visible — no corners cut off'),
              const _TipLine('Photo must not be expired'),
              const _TipLine('All text must be clearly readable'),
              const _TipLine('Both front and back required'),
              const SizedBox(height: 14),
              Text(
                '256-bit Encrypted  |  GDPR Compliant',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.grey,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Submit & Finish — Upload Back Side First',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.grey700,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Submit & Finish'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LicenseUploadTile extends StatelessWidget {
  final File? imageFile;
  final VoidCallback onTap;
  final IconData placeholderIcon;

  const _LicenseUploadTile({
    required this.imageFile,
    required this.onTap,
    required this.placeholderIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: imageFile == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(placeholderIcon, size: 50, color: AppTheme.primary),
                    const SizedBox(height: 10),
                    Text(
                      'Tap to upload',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppTheme.grey700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Take a photo or upload from gallery',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.grey,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(imageFile!, fit: BoxFit.cover),
              ),
      ),
    );
  }
}

class _TipLine extends StatelessWidget {
  final String text;
  const _TipLine(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(
        text,
        style: TextStyle(
          color: AppTheme.grey700,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
