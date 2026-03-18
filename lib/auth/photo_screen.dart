import 'package:flutter/material.dart';
import 'license_screen.dart';
import '../core/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../screens/home/home_screen.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});
  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  File? _image;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Add a profile photo")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              "Please upload a clear photo of yourself",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 80,
                backgroundColor: theme.primaryColor.withOpacity(0.1),
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? Icon(Icons.camera_alt,
                        size: 60, color: theme.primaryColor)
                    : null,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _continue,
              child: const Text("Continue with this Photo"),
            ),
            TextButton(
                onPressed: _pickImage,
                child: const Text("Upload a different photo")),
          ],
        ),
      ),
    );
  }
}
