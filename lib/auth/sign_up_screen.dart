import 'package:flutter/material.dart';
import 'otp_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create your account')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
                decoration: const InputDecoration(labelText: 'Email or Phone')),
            const SizedBox(height: 16),
            TextField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          const OtpScreen(phoneNumber: '+1 (555) 123-4567'))),
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
