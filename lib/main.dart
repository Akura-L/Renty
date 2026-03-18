import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const RentyApp());
}

class RentyApp extends StatelessWidget {
  const RentyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Renty',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainScreen(),
    );
  }
}
