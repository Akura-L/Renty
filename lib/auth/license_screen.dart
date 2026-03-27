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
    if (!_canSubmit) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
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
          'Step 5 of 5',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const AuthFlowStepper(currentStep: 5),
              const SizedBox(height: 32),
              const Text(
                'Upload your licence',
                style: RentyTextStyles.headingXL,
              ),
              const SizedBox(height: 8),
              const Text(
                'Required for insurance purposes. Upload\nboth sides of your valid driver\'s licence.',
                style: RentyTextStyles.bodyM,
              ),
              const SizedBox(height: 32),

              // Front Side Card
              _LicenseUploadCard(
                title: 'Front Side',
                isUploaded: _frontLicense != null,
                onTap: () => _pickLicense(forBack: false),
                child: _frontLicense != null
                    ? _buildLicensePreview(isFront: true)
                    : null,
              ),

              const SizedBox(height: 20),

              // Back Side Card
              _LicenseUploadCard(
                title: 'Back Side',
                isUploaded: _backLicense != null,
                onTap: () => _pickLicense(forBack: true),
                child: _backLicense != null
                    ? _buildLicensePreview(isFront: false)
                    : null,
              ),

              const SizedBox(height: 32),

              // Photo Tips Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.help_outline,
                            size: 20, color: Colors.orange.shade400),
                        const SizedBox(width: 12),
                        const Text(
                          'Photo tips',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D3E50),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _TipItem(text: 'Full licence visible — no corners cut off'),
                    _TipItem(text: 'Photo must not be expired'),
                    _TipItem(text: 'All text must be clearly readable'),
                    _TipItem(text: 'Both front and back required'),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Security Bar
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_outline, size: 16, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      '256-bit Encrypted',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 16),
                    SizedBox(
                      height: 16,
                      child: VerticalDivider(width: 1, color: Colors.grey),
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.shield_outlined, size: 16, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      'GDPR Compliant',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _canSubmit ? _submit : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _canSubmit
                        ? RentyColors.primary
                        : const Color(0xFFF1F3F4),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    _canSubmit
                        ? 'Submit & Finish'
                        : _frontLicense == null
                            ? 'Submit & Finish — Upload Front'
                            : 'Submit & Finish — Upload Back',
                    style: RentyTextStyles.button.copyWith(
                      color: _canSubmit ? Colors.white : Colors.grey.shade400,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Warning Message
              if (!_canSubmit)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _frontLicense == null
                          ? 'Upload the front side of your licence to continue'
                          : 'Upload the back side of your licence to continue',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLicensePreview({required bool isFront}) {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: const Color(0xFF2D3E50),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20,
            top: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 100,
                    height: 8,
                    color: Colors.white.withOpacity(0.1)),
                const SizedBox(height: 8),
                Container(
                    width: 80, height: 8, color: Colors.white.withOpacity(0.1)),
                const SizedBox(height: 8),
                Container(
                    width: 120,
                    height: 8,
                    color: Colors.white.withOpacity(0.1)),
              ],
            ),
          ),
          Positioned(
            right: 20,
            top: 20,
            child: Container(
              width: 50,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.person, color: Colors.white24, size: 32),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                      color: RentyColors.primary, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
                const Text(
                  'REPUBLIC OF KENYA',
                  style: TextStyle(
                    color: Colors.white24,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                      color: RentyColors.primary, shape: BoxShape.circle),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LicenseUploadCard extends StatelessWidget {
  final String title;
  final bool isUploaded;
  final VoidCallback onTap;
  final Widget? child;

  const _LicenseUploadCard({
    required this.title,
    required this.isUploaded,
    required this.onTap,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUploaded ? RentyColors.primary : Colors.grey.shade200,
          width: isUploaded ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isUploaded
                  ? RentyColors.primaryLight
                  : const Color(0xFFF8F9FA),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Row(
              children: [
                Icon(
                  isUploaded ? Icons.check_circle : Icons.upload_outlined,
                  size: 20,
                  color: isUploaded ? RentyColors.primary : Colors.grey,
                ),
                const SizedBox(width: 12),
                Text(
                  isUploaded ? '$title — Uploaded' : title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isUploaded
                        ? RentyColors.primary
                        : const Color(0xFF2D3E50),
                  ),
                ),
                const Spacer(),
                if (isUploaded)
                  TextButton(
                    onPressed: onTap,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Replace',
                      style: TextStyle(
                        color: RentyColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                else
                  Text(
                    'Required',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),

          // Body
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: child ?? _buildUploadPlaceholder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadPlaceholder() {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
          style: BorderStyle
              .solid, // In a real app we might use a dotted border package
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F3F4),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.upload_outlined,
                color: Colors.grey.shade400, size: 24),
          ),
          const SizedBox(height: 12),
          const Text(
            'Tap to upload',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3E50),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Take a photo or upload from gallery',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _TipItem extends StatelessWidget {
  final String text;
  const _TipItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: RentyColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
