import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'profile_info_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with TickerProviderStateMixin {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  late AnimationController _shakeController;
  late AnimationController _scaleController;
  bool _resendVisible = false;
  int _seconds = 60;
  bool _isLoading = false;
  bool _hasError = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _startTimer();
    _shakeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _shakeController.reverse();
      }
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _seconds = 60;
    _resendVisible = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_seconds > 0) {
            _seconds--;
          } else {
            _resendVisible = true;
            timer.cancel();
          }
        });
      }
    });
  }

  String get _otp => _controllers.map((c) => c.text).join();

  void _onOtpChanged(String value, int index) {
    if (value.length == 1) {
      if (index < 5) {
        FocusScope.of(context).nextFocus();
      }
      if (_otp.length == 6) {
        _verifyOtp(auto: true);
      }
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).previousFocus();
    }
  }

  Future<void> _verifyOtp({bool auto = false}) async {
    if (_otp.length != 6) return;

    HapticFeedback.lightImpact();
    if (!auto) {
      _scaleController.forward().then((_) => _scaleController.reverse());
    }

    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      // Always succeed for demo, TODO: Real verification
      debugPrint('Verified OTP: $_otp for ${widget.phoneNumber}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProfileInfoScreen()),
      );
    }
  }

  void _resendOtp() {
    HapticFeedback.mediumImpact();
    _startTimer();
    for (var controller in _controllers) {
      controller.clear();
    }
    setState(() {
      _hasError = false;
    });
    FocusScope.of(context).requestFocus(FocusNode());
  }

  Widget _buildDigitField(int index) {
    return Expanded(
      child: SizedBox(
        height: 68,
        child: TextField(
          controller: _controllers[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          decoration: InputDecoration(
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
          onChanged: (value) => _onOtpChanged(value, index),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _shakeController.dispose();
    _scaleController.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Phone'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(flex: 1),
            Icon(
              Icons.message_outlined,
              size: 80,
              color: theme.primaryColor,
            ),
            const SizedBox(height: 24),
            Text(
              'Enter verification code',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'sent to ${widget.phoneNumber}',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.primaryColor,
              ),
            ),
            const SizedBox(height: 40),
            AnimatedBuilder(
              animation: _shakeController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_shakeController.value * 10, 0),
                  child: child,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, _buildDigitField),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    _isLoading || _otp.length != 6 ? null : () => _verifyOtp(),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Verify'),
              ),
            ),
            const SizedBox(height: 24),
            const Spacer(),
            if (_resendVisible)
              TextButton(
                onPressed: _resendOtp,
                child: const Text('Resend Code'),
              )
            else
              Text(
                'Resend in ${_seconds.toString().padLeft(2, '0')}s',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
