import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'profile/favourites_screen.dart';
import 'profile/my_bookings_screen.dart';
import 'profile/messages_screen.dart';
import 'profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const FavouritesScreen(),
    const MyBookingsScreen(),
    const MessagesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF00BFA5),
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: "Favourites"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "Bookings"),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline), label: "Messages"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }
}
