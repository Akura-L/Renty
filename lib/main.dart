import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/favourites_provider.dart';
import 'providers/bookings_provider.dart';
import 'core/theme.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavouritesProvider()),
        ChangeNotifierProvider(create: (_) => BookingsProvider()),
      ],
      child: const RentyApp(),
    ),
  );
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
