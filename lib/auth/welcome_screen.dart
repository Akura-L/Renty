import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/theme.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 1),
            SvgPicture.asset(
              'assets/icons/logo.svg',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 32),
            Text(
              'Welcome back',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.dark,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sign in to continue',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.grey,
                  ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignInScreen()),
                ),
                child: const Text('Sign In'),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SignUpScreen()),
              ),
              child: const Text('Don\'t have an account? Sign up'),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: OutlinedButton(
                  onPressed: () => debugPrint('Continue with Google'),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.g_mobiledata),
                      SizedBox(width: 8),
                      Text('Google'),
                    ],
                  ),
                )),
                const SizedBox(width: 16),
                Expanded(
                    child: OutlinedButton(
                  onPressed: () => debugPrint('Continue with Apple'),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone_iphone),
                      SizedBox(width: 8),
                      Text('Apple'),
                    ],
                  ),
                )),
              ],
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
