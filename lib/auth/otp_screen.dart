import 'package:flutter/material.dart';
import '../core/theme.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  bool _resendVisible = false;
  int _seconds = 60;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 60), () {
      if (mounted) {
        setState(() {
          _resendVisible = true;
        });
      }
    });
  }

  String get _otp => _controllers.map((c) => c.text).join();

  void _verifyOtp() {
    if (_otp.length == 6) {
      // TODO: Verify OTP
      debugPrint('Verified OTP: $_otp');
      // Navigate to home
      // Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void _resendOtp() {
    setState(() {
      _resendVisible = false;
    });
    _startTimer();
    _controllers.clear();
    _controllers.addAll(List.generate(6, (_) => TextEditingController()));
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter OTP')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Verification code sent to your phone',
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  6,
                  (index) => SizedBox(
                        width: 50,
                        child: TextField(
                          controller: _controllers[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          onChanged: (value) {
                            if (value.length == 1 && index < 5) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                        ),
                      )),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _otp.length == 6 ? _verifyOtp : null,
              child: const Text('Verify'),
            ),
            const SizedBox(height: 16),
            if (_resendVisible)
              TextButton(
                onPressed: _resendOtp,
                child: const Text('Resend OTP'),
              )
            else
              Text('Resend in $_seconds seconds'),
          ],
        ),
      ),
    );
  }
}
