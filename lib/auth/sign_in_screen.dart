import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../screens/main_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      // Mock auth success
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: EdgeInsets.all(AppTheme.kPaddingXL),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: AppTheme.kFontSizeLargeTitle + 6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppTheme.kPaddingXS),
              Text(
                'Sign in to continue',
                style: TextStyle(
                  fontSize: AppTheme.kFontSizeSmall + 4,
                  color: AppTheme.grey,
                ),
              ),
              SizedBox(height: AppTheme.kPaddingLarge),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Enter email' : null,
              ),
              SizedBox(height: AppTheme.kPaddingMedium),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Enter password' : null,
              ),
              SizedBox(height: AppTheme.kPaddingXS),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Forgot Password - Stub')),
                    );
                  },
                  child: const Text('Forgot Password?'),
                ),
              ),
              SizedBox(height: AppTheme.kPaddingLarge),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _signIn,
                  child: const Text('Sign In'),
                ),
              ),
              SizedBox(height: AppTheme.kPaddingMedium),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const MainScreen()),
                      );
                    },
                    icon: const Icon(Icons.g_mobiledata),
                    label: const Text('Google'),
                  ),
                  SizedBox(width: AppTheme.kPaddingMedium),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const MainScreen()),
                      );
                    },
                    icon: const Icon(Icons.apple),
                    label: const Text('Apple'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
