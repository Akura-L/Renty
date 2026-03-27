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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(RentySpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthFlowStepper(currentStep: 5),
                const SizedBox(height: 18),
                const Text(
                  'Upload your licence',
                  style: RentyTextStyles.headingXL,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Required for insurance purposes. Upload both sides of your valid driver\'s licence.',
                  style: RentyTextStyles.bodyM,
                ),
                const SizedBox(height: 22),
                const Text(
                  'Front Side',
                  style: RentyTextStyles.labelL,
                ),
                const SizedBox(height: 10),
                _LicenseUploadTile(
                  imageFile: _frontLicense,
                  onTap: () => _pickLicense(forBack: false),
                  placeholderIcon: Icons.card_membership,
                ),
                const SizedBox(height: 18),
                const Text(
                  'Back Side',
                  style: RentyTextStyles.labelL,
                ),
                const SizedBox(height: 10),
                _LicenseUploadTile(
                  imageFile: _backLicense,
                  onTap: () => _pickLicense(forBack: true),
                  placeholderIcon: Icons.card_membership,
                ),
                const SizedBox(height: 12),
                if (!_canSubmit)
                  const Text(
                    'Upload both sides to continue',
                    style: TextStyle(
                      color: RentyColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                const SizedBox(height: 24),
                const Text(
                  'Photo tips',
                  style: RentyTextStyles.headingS,
                ),
                const SizedBox(height: 12),
                const _TipLine('• Full licence visible — no corners cut off'),
                const _TipLine('• Photo must not be expired'),
                const _TipLine('• All text must be clearly readable'),
                const _TipLine('• Both front and back required'),
                const SizedBox(height: 24),
                const Text(
                  '256-bit Encrypted | GDPR Compliant',
                  style: RentyTextStyles.caption,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _canSubmit ? _submit : null,
                    child: const Text('Submit & Finish'),
                  ),
                ),
              ],
            ),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160,
        width: double.infinity,
        decoration: imageFile == null 
          ? RentyDecorations.uploadZone 
          : BoxDecoration(
              borderRadius: BorderRadius.circular(RentyRadius.lg),
              border: Border.all(color: RentyColors.border),
            ),
        child: imageFile == null
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo_outlined, size: 40, color: RentyColors.textSecondary),
                    SizedBox(height: 10),
                    Text(
                      'Tap to upload',
                      style: RentyTextStyles.labelM,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'JPG or PNG preferred',
                      style: RentyTextStyles.caption,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(RentyRadius.lg),
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
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, size: 16, color: RentyColors.success),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: RentyTextStyles.bodyM)),
        ],
      ),
    );
  }
}
