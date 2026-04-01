import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../auth/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 0.6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WelcomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top teal bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 4,
              color: RentyColors.primary,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),
                // Top dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDot(isActive: false),
                    const SizedBox(width: 8),
                    _buildDot(isActive: true),
                    const SizedBox(width: 8),
                    _buildDot(isActive: false),
                  ],
                ),

                const Spacer(flex: 2),

                // Logo
                Image.asset(
                  'assets/images/renty.png',
                  width: 220,
                  fit: BoxFit.contain,
                ),

                const Spacer(flex: 2),

                // Middle divider with dot
                _buildDividerWithDot(),

                const SizedBox(height: 40),

                // Tagline
                const Text(
                  'D R I V E   T H E\nM O M E N T',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF2D3E50),
                    letterSpacing: 4,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 20),

                // Teal small divider
                Container(
                  width: 40,
                  height: 2,
                  color: RentyColors.primary,
                ),

                const SizedBox(height: 20),

                // Sub-tagline
                const Text(
                  'YOUR JOURNEY STARTS HERE',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const Spacer(flex: 3),

                // Progress Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        value: _progressAnimation.value,
                        backgroundColor: Colors.grey.shade200,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(RentyColors.primary),
                        minHeight: 3,
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Footer Text
                const Text(
                  'CAR RENTALS and HIRES',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    letterSpacing: 4,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: isActive ? RentyColors.primary : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildDividerWithDot() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: RentyColors.primary,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
      ],
    );
  }
}
