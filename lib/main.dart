import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/favourites_provider.dart';
import 'providers/bookings_provider.dart';
import 'screens/splash/splash_screen.dart';
import 'auth/welcome_screen.dart';
import 'core/theme.dart';
import 'screens/main_screen.dart';
import 'auth/sign_up_screen.dart';
import 'auth/otp_screen_fixed.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/profile/favourites_screen.dart';
import 'screens/profile/my_bookings_screen.dart';
import 'screens/profile/messages_screen.dart';
import 'auth/photo_screen.dart';
import 'auth/profile_info_screen.dart';
import 'auth/license_screen.dart';
import 'driver_screen.dart';
import 'models/car.dart';
import 'screens/booking/car_detail_screen.dart';

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
      theme: RentyTheme.light,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/main': (context) => const MainScreen(),
        '/auth/sign-in': (context) => const WelcomeScreen(),
        '/auth/sign-up': (context) => const SignUpScreen(),
        '/auth/otp': (context) => const OtpScreen(phoneNumber: '+254712345678'),
        '/auth/photo': (context) => const PhotoScreen(),
        '/auth/profile-info': (context) => const ProfileInfoScreen(),
        '/auth/license': (context) => const LicenseScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/profile/favourites': (context) => const FavouritesScreen(),
        '/profile/bookings': (context) => const MyBookingsScreen(),
        '/profile/messages': (context) => const MessagesScreen(),
        '/driver': (context) => const DriverScreen(
              car: Car(
                id: '1',
                name: 'Toyota Land Cruiser',
                location: 'Nairobi',
                year: 2023,
                price: 8500,
                imageUrl: 'assets/images/toyota_landcruiser.png',
              ),
            ),
        '/booking/car-detail': (context) => const CarDetailScreen(
                car: Car(
              id: '1',
              name: 'Toyota Land Cruiser',
              location: 'Nairobi',
              year: 2023,
              price: 8500,
              imageUrl: 'assets/images/toyota_landcruiser.png',
            )),
      },
    );
  }
}
