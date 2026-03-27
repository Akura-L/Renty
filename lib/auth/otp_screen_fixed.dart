import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme.dart';
import 'profile_info_screen.dart';
import 'widgets/auth_flow_stepper.dart';

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
  Timer? _timer;

  String _formatClock(int seconds) {
    final d = Duration(seconds: seconds);
    final mm = d.inMinutes.toString().padLeft(2, '0');
    final ss = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$mm:$ss';
  }

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
    });

    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
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
    setState(() {});
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
              borderRadius: BorderRadius.circular(RentyRadius.md),
              borderSide: const BorderSide(color: RentyColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(RentyRadius.md),
              borderSide:
                  const BorderSide(color: RentyColors.primary, width: 2),
            ),
            filled: true,
            fillColor: RentyColors.surface,
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
      body: Padding(
        padding: const EdgeInsets.all(RentySpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthFlowStepper(currentStep: 2),
            const SizedBox(height: 18),
            Icon(
              Icons.message_outlined,
              size: 28.0,
              color: theme.primaryColor,
            ),
            const SizedBox(height: 14),
            Text(
              'Verify your number',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'We sent a 6-digit code to ${widget.phoneNumber}.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.primaryColor,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Please enter it below.',
              style:
                  RentyTextStyles.bodyS.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 14),
            AnimatedBuilder(
              animation: _shakeController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_shakeController.value * 10, 0),
                  child: child!,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, _buildDigitField),
              ),
            ),
            const SizedBox(height: 18),
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
                    : const Text('Verify Code'),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Didn't receive the code?",
                    style: TextStyle(
                      color: RentyColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  _formatClock(_seconds),
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: _resendVisible ? _resendOtp : null,
                child: Text(
                  'Resend Code',
                  style: TextStyle(color: theme.primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      // Mock alternative delivery
                    },
                    child: Text(
                      'Send via Email',
                      style: TextStyle(color: theme.primaryColor),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      // Mock alternative delivery
                    },
                    child: Text(
                      'Call me instead',
                      style: TextStyle(color: theme.primaryColor),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const Text(
              'Check your SMS inbox',
              style: TextStyle(
                color: RentyColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'The code may take up to 2 minutes to arrive. Check that your phone has signal and the number is correct.',
              style: TextStyle(
                color: RentyColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
