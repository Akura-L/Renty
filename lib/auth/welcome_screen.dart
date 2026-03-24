import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/theme.dart';
import 'sign_up_screen.dart';
import '../screens/main_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'james@example.com');
    _passwordController = TextEditingController(text: 'password123');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppTheme.kPaddingXL),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/icons/logo.svg',
                  width: 120,
                  height: 120,
                ),
                SizedBox(height: AppTheme.kPaddingSmall),
                Text(
                  'Sign in to access your bookings and saved cars',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.grey,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(height: AppTheme.kPaddingXS),
                Text(
                  'Welcome back',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.dark,
                      ),
                ),
                SizedBox(height: AppTheme.kPaddingLarge),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _signIn,
                    icon: const Icon(Icons.g_mobiledata),
                    label: const Text('Continue with Google'),
                  ),
                ),
                SizedBox(height: AppTheme.kPaddingSmall),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _signIn,
                    icon: const Icon(Icons.phone_iphone),
                    label: const Text('Continue with Apple'),
                  ),
                ),
                SizedBox(height: AppTheme.kPaddingLarge),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppTheme.grey.withOpacity(0.25),
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'or sign in with email',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.grey,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppTheme.grey.withOpacity(0.25),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppTheme.kPaddingLarge),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email or Phone',
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: AppTheme.kPaddingMedium),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Forgot password?'),
                        ),
                      ),
                      SizedBox(height: AppTheme.kPaddingMedium),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _signIn,
                          child: const Text('Sign In'),
                        ),
                      ),
                      SizedBox(height: AppTheme.kPaddingLarge),
                      Center(
                        child: TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignUpScreen(),
                            ),
                          ),
                          child: const Text(
                              'New to Renty? Create a free account'),
                        ),
                      ),
                      SizedBox(height: AppTheme.kPaddingSmall),
                      Text(
                        '4.9 / 5 • Trusted by 10,000+ drivers across Kenya',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.grey,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
