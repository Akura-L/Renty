import 'package:flutter/material.dart';
import 'license_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../core/theme.dart';
import 'widgets/auth_flow_stepper.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});
  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final picked = await picker.pickImage(source: source);
    if (picked != null) {
      setState(() => _image = File(picked.path));
    }
  }

  void _continue() {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a profile photo')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LicenseScreen()),
    );
  }

  void _skip() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LicenseScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(RentySpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthFlowStepper(currentStep: 4),
              const SizedBox(height: 18),
              const Text(
                'Add a profile photo',
                style: RentyTextStyles.headingXL,
              ),
              const SizedBox(height: 10),
              const Text(
                'Rentals are 70% more successful with a clear, verified profile photo.',
                style: RentyTextStyles.bodyM,
              ),
              const SizedBox(height: 18),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: RentyColors.primaryLight,
                      backgroundImage:
                          _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? const Text(
                              'JM',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(133, 8, 227, 227),
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(height: 8),
                    if (_image != null)
                      const Text(
                        'Photo selected',
                        style: RentyTextStyles.labelL,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _pickImage(ImageSource.camera),
                      child: const Text('Take a Photo'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      child: const Text('Choose File'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Photo requirements',
                style: RentyTextStyles.headingS,
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  '• Clear well-lit face photo',
                  style: RentyTextStyles.bodyM,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  '• No sunglasses or hats',
                  style: RentyTextStyles.bodyM,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  '• Neutral background preferred',
                  style: RentyTextStyles.bodyM,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  '• File size under 5 MB (JPG/PNG)',
                  style: RentyTextStyles.bodyM,
                ),
              ),
              const Spacer(),
              if (_image != null)
                Center(
                  child: TextButton(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    child: const Text('Not happy with it? Retake photo'),
                  ),
                ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _image == null ? null : _continue,
                  child: const Text('Continue with this Photo'),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: _skip,
                  child: const Text('Skip for now — I\'ll add later'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
