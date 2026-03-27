import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../core/theme.dart';
import 'otp_screen_fixed.dart';
import 'welcome_screen.dart';
import 'widgets/auth_flow_stepper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController(text: '712345678');
  String? _selectedCountryCode = '+254';
  final _emailController = TextEditingController(text: 'james@example.com');
  // Gender and location moved to profile_info_screen

  // Lists moved to profile_info_screen.dart

  final List<DropdownMenuItem<String>> countryCodeItems =
      ['+254', '+1', '+44', '+91']
          .map((code) => DropdownMenuItem<String>(
                value: code,
                child: Text(code),
              ))
          .toList();

  bool _usePhone = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _continue() {
    if (!_formKey.currentState!.validate()) return;
    final String phoneNumber = _usePhone
        ? (_selectedCountryCode ?? '+254') + _phoneController.text.trim()
        : _emailController.text.trim();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OtpScreen(phoneNumber: phoneNumber),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(RentySpacing.xxl, RentySpacing.xxl,
              RentySpacing.xxl, RentySpacing.xl),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthFlowStepper(currentStep: 1),
                const SizedBox(height: 18),
                const Text(
                  'Create your account',
                  style: RentyTextStyles.headingXL,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter your phone or email to get started. It only takes a minute.',
                  style: RentyTextStyles.bodyM,
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
                      if (_usePhone) ...[
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: DropdownButtonFormField<String>(
                                value: _selectedCountryCode,
                                decoration: const InputDecoration(
                                  labelText: 'Code',
                                ),
                                items: countryCodeItems,
                                onChanged: (value) => setState(
                                    () => _selectedCountryCode = value),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  labelText: 'Phone Number',
                                  hintText: '712 345 678',
                                ),
                                validator: (v) {
                                  if (v == null || v.trim().isEmpty) {
                                    return 'Enter your phone number';
                                  }
                                  final clean =
                                      v.trim().replaceAll(RegExp(r'[^\d]'), '');
                                  if (!RegExp(r'^\d{9,10}$').hasMatch(clean)) {
                                    return 'Local number should be 9-10 digits';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "We'll send a verification code to this number",
                          style: RentyTextStyles.bodyM,
                        ),
                        const SizedBox(height: 28),
                      ] else ...[
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'james@example.com',
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Enter your email';
                            }
                            if (!RegExp(r'^[\\w-]+@[a-z\\d-]+\\.[a-z]{2,}$')
                                .hasMatch(v.trim())) {
                              return 'Enter valid email';
                            }
                            return null;
                          },
                        ),
                      ],
                    ],
                  ),
                ),
                _buildWhyJoinSection(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
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
      borderRadius: BorderRadius.circular(RentyRadius.lg),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RentyRadius.lg),
          border: Border.all(
            color: active ? RentyColors.primary : RentyColors.border,
            width: active ? 2 : 1,
          ),
          color: active ? RentyColors.primaryLight : RentyColors.background,
        ),
        child: Center(
          child: Text(
            label,
            style: RentyTextStyles.labelL.copyWith(
              color: active ? RentyColors.primary : RentyColors.textPrimary,
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
          const Text(
            'Why join Renty?',
            style: RentyTextStyles.headingM,
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
          const Icon(Icons.check_circle, color: RentyColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: RentyTextStyles.bodyM)),
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
            style: RentyTextStyles.caption,
            children: [
              const TextSpan(text: 'By continuing, you agree to our '),
              TextSpan(
                text: 'Terms of Service',
                style:
                    RentyTextStyles.link.copyWith(fontWeight: FontWeight.w600),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Navigate to terms
                  },
              ),
              const TextSpan(text: ' and '),
              TextSpan(
                text: 'Privacy Policy',
                style:
                    RentyTextStyles.link.copyWith(fontWeight: FontWeight.w600),
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
