import 'package:flutter/material.dart';

import '../core/theme.dart';
import 'otp_screen.dart';
import 'welcome_screen.dart';
import 'widgets/auth_flow_stepper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _contactController = TextEditingController(text: '+254 712 345 678');

  bool _usePhone = true;

  @override
  void dispose() {
    _contactController.dispose();
    super.dispose();
  }

  void _continue() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OtpScreen(phoneNumber: _contactController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthFlowStepper(currentStep: 1),
              const SizedBox(height: 18),
              Text(
                'Create your account',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.dark,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your phone or email to get started. It only takes a minute.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.grey,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: _modeChip(
                      label: 'Phone',
                      active: _usePhone,
                      onTap: () => setState(() => _usePhone = true),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _modeChip(
                      label: 'Email',
                      active: !_usePhone,
                      onTap: () => setState(() => _usePhone = false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _contactController,
                      keyboardType: _usePhone
                          ? TextInputType.phone
                          : TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: _usePhone ? 'Phone' : 'Email',
                        hintText: _usePhone ? '+254 712 345 678' : 'james@example.com',
                        prefixIcon: _usePhone 
                          ? Icon(Icons.flag_outlined, color: Colors.green[800], size: 24)
                          : null,
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return _usePhone
                              ? 'Enter your phone number'
                              : 'Enter your email';
                        }
                        return null;
                      },
                    ),
                    if (_usePhone) ...[
                      const SizedBox(height: 8),
                      Text(
                        'We'll send a verification code to this number',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              _buildWhyJoinSection(),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _continue,
                  child: const Text('Continue'),
                ),
              ),
              const SizedBox(height: 14),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                  ),
                  child: const Text('Already have an account? Sign In'),
                ),
              ),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _modeChip({
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: active ? AppTheme.primary : AppTheme.grey25,
            width: active ? 2 : 1,
          ),
          color: active ? AppTheme.primary.withOpacity(0.08) : Colors.white,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: active ? AppTheme.primary : AppTheme.dark,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWhyJoinSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why join Renty?',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.dark,
            ),
          ),
          const SizedBox(height: 12),
          _buildBullet('Browse 500+ verified cars across Kenya'),
          _buildBullet('Free cancellation on most rentals'),
          _buildBullet('24/7 roadside support included'),
        ],
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: AppTheme.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.grey),
            children: [
              const TextSpan(text: 'By continuing, you agree to our '),
              TextSpan(
                text: 'Terms of Service',
                style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w600),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Navigate to terms
                  },
              ),
              const TextSpan(text: ' and '),
              TextSpan(
                text: 'Privacy Policy',
                style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w600),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Navigate to privacy policy
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
